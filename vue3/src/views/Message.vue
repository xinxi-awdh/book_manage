<template>
  <div>
    <h2>留言列表</h2>

    <!-- 新增留言表单 -->
    <el-form :model="newMessage" label-width="80px" style="margin-bottom: 20px;">
      <el-form-item label="书名">
        <el-input v-model="newMessage.title" placeholder="请输入书名" />
      </el-form-item>
      <el-form-item label="留言内容">
        <el-input type="textarea" rows="4" v-model="newMessage.content" placeholder="请输入留言内容" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitMessage">发表留言</el-button>
        <el-button @click="resetNewMessage">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 排序控件 -->
    <div style="margin-bottom: 20px;">
      排序：
      <el-select v-model="sortBy" placeholder="选择排序字段" size="small" style="width: 120px; margin-right: 10px;">
        <el-option label="点赞数" value="like" />
        <el-option label="回复条数" value="reply" />
        <el-option label="时间" value="time" />
      </el-select>

      <el-select v-model="order" placeholder="排序方式" size="small" style="width: 100px;">
        <el-option label="降序" value="desc" />
        <el-option label="升序" value="asc" />
      </el-select>

      <el-button size="small" type="primary" @click="fetchMessages" style="margin-left: 10px;">排序</el-button>
    </div>

    <!-- 留言列表 -->
    <el-table :data="messages" style="width: 100%" v-loading="loading" border>
      <el-table-column prop="title" label="书名" />
      <el-table-column prop="content" label="留言内容" />
      <el-table-column prop="name" label="用户" />
      <el-table-column prop="likeCount" label="点赞数" width="100" />
      <el-table-column prop="replyCount" label="回复条数" width="100" />
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="statusTagType(row.status)">
            {{ statusText(row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createdAt" label="创建时间" />
      <el-table-column label="操作" width="240">
        <template #default="{ row }">
          <el-button size="mini" type="primary" @click="goToMessageDetail(row.id)">查看详情</el-button>
          <el-button size="mini" type="warning" @click="goToMessageDetail(row.id)">回复</el-button>
          <el-button size="mini" type="success" @click="like(row.id)">点赞</el-button>
          <el-button
              v-if="currentUser.role === 'admin'"
              size="mini"
              type="danger"
              @click="deleteMessage(row.id)"
          >
            删除
          </el-button>

        </template>
      </el-table-column>
    </el-table>
    <router-view />
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import request from '@/utils/request'
import { ElMessage, ElMessageBox } from 'element-plus'

const router = useRouter()
const messages = ref([])
const loading = ref(false)

const sortBy = ref('time')  // 默认按时间排序
const order = ref('desc')   // 默认降序

const newMessage = reactive({
  title: '',
  content: '',
})

const currentUser = JSON.parse(localStorage.getItem('xm-pro-user') || '{}')

// 状态对应文字
const statusText = (status) => {
  switch(status) {
    case 0: return '正常'
    case 1: return '审核中'
    case 2: return '已删除'
    default: return '未知'
  }
}

// 状态对应标签样式
const statusTagType = (status) => {
  switch(status) {
    case 0: return 'success'
    case 1: return 'warning'
    case 2: return 'danger'
    default: return 'info'
  }
}

// 获取留言列表，调用后端排序接口
const fetchMessages = async () => {
  loading.value = true
  try {
    const res = await request.get('/messages/sorted', {
      params: {
        page: 1,
        pageSize: 20,
        no: currentUser.no,
        sortBy: sortBy.value,
        order: order.value,
      }
    })
    if (res.code === '200') {
      // 只保留顶级留言
      messages.value = res.data.list.filter(item => item.parentId === null)
    } else {
      ElMessage.error(res.message || '加载留言失败')
    }
  } catch (e) {
    ElMessage.error('系统异常')
  } finally {
    loading.value = false
  }
}

// 新增留言
const submitMessage = async () => {
  if (!newMessage.title || !newMessage.content) {
    ElMessage.warning('书名和留言内容不能为空')
    return
  }
  try {
    const payload = {
      no: currentUser.no,
      title: newMessage.title,
      content: newMessage.content,
    }
    const res = await request.post('/messages', payload)
    if (res.code === '200') {
      ElMessage.success('留言成功')
      resetNewMessage()
      fetchMessages()
    } else {
      ElMessage.error(res.message || '留言失败')
    }
  } catch (e) {
    ElMessage.error('系统异常')
  }
}

// 重置输入框
const resetNewMessage = () => {
  newMessage.title = ''
  newMessage.content = ''
}

// 点赞
const like = async (id) => {
  try {
    const res = await request.post(`/messages/${id}/like`, null, { params: { no: currentUser.no } })
    if (res.code === '200') {
      ElMessage.success('点赞成功')
      fetchMessages()
    } else {
      ElMessage.error(res.message || '点赞失败')
    }
  } catch (e) {
    ElMessage.error('系统异常')
  }
}

// 删除留言，带确认弹窗
const deleteMessage = (id) => {
  ElMessageBox.confirm('确定要删除该留言吗？', '删除确认', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    try {
      const res = await request.delete(`/messages/${id}`, {
        params: {
          currentUserNo: currentUser.no,
          isAdmin: currentUser.isAdmin || false,
        }
      })
      if (res.code === '200') {
        ElMessage.success('删除成功')
        fetchMessages()
      } else {
        ElMessage.error(res.message || '删除失败')
      }
    } catch (e) {
      ElMessage.error('系统异常')
    }
  }).catch(() => {
    // 取消不做提示
  })
}
const goToMessageDetail = (id) => {
  router.push(`/manager/message-detail/${id}`)
}

// 跳转留言详情页
const goDetail = (id) => {
  router.push(`/manager/message-detail/${id}`) // ✅ 正确
}

// 初始化加载留言
fetchMessages()
</script>
