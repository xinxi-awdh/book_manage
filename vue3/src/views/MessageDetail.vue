<!-- src/views/MessageDetail.vue -->
<template>
  <div class="message-detail-page">
    <h2>留言详情</h2>

    <!-- 主留言展示 -->
    <el-card class="main-message-card">
      <h3>{{ message.title }}</h3>
      <p style="margin: 10px 0;">{{ message.content }}</p>
      <small>
        用户: {{ message.name }} - 单位: {{ message.unit }}<br />
        时间: {{ formatDate(message.createdAt) }}
      </small>
    </el-card>

    <!-- 回复列表 -->
    <h3 style="margin-top: 30px;">回复列表</h3>
    <el-empty v-if="replies.length === 0" description="暂无回复" />
    <el-timeline v-else>
      <el-timeline-item
          v-for="reply in replies"
          :key="reply.id"
          :timestamp="formatDate(reply.createdAt)"
      >
        <p>{{ reply.content }}</p>
        <small>回复用户: {{ reply.name }} - 单位: {{ reply.unit }}</small>
      </el-timeline-item>
    </el-timeline>

    <!-- 回复输入框 -->
    <div class="reply-form">
      <el-input
          type="textarea"
          v-model="newReplyContent"
          placeholder="请输入回复内容"
          rows="4"
      />
      <el-button type="primary" @click="submitReply" style="margin-top: 10px;">
        提交回复
      </el-button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import request from '@/utils/request'
import { ElMessage } from 'element-plus'

const route = useRoute()
const messageId = route.params.id
const message = ref({})
const replies = ref([])
const newReplyContent = ref('')

const currentUser = JSON.parse(localStorage.getItem('xm-pro-user') || '{}')

const formatDate = (val) => (val ? new Date(val).toLocaleString() : '')

const fetchDetail = async () => {
  try {
    const res = await request.get(`/messages/${messageId}/detail`)
    if (res.code === '200') {
      message.value = res.data.message
      replies.value = res.data.replies
    } else {
      ElMessage.error(res.message || '加载留言详情失败')
    }
  } catch (e) {
    console.error(e)
    ElMessage.error('系统异常')
  }
}

const submitReply = async () => {
  if (!newReplyContent.value) {
    ElMessage.warning('请输入回复内容')
    return
  }

  try {
    const res = await request.post(
        `/messages/${messageId}/reply`,
        {
          no: currentUser.no,
          content: newReplyContent.value,
          title: '', // 回复不需要书名
        },
        {
          params: {
            userNo: currentUser.no, // 兼容 @RequestParam Integer userNo
          },
        }
    )

    if (res.code === '200') {
      ElMessage.success('回复成功')
      newReplyContent.value = ''
      fetchDetail()
    } else {
      ElMessage.error(res.message || '回复失败')
    }
  } catch (e) {
    console.error(e)
    ElMessage.error('系统异常')
  }
}

onMounted(() => {
  fetchDetail()
})
</script>

<style scoped>
.message-detail-page {
  padding: 20px;
}

.main-message-card {
  margin-bottom: 20px;
}

.reply-form {
  margin-top: 30px;
}
</style>
