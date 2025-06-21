<template>
  <div class="admin-borrow-record-page">
    <h2>借阅记录查询</h2>

    <!-- 查询栏 -->
    <div class="toolbar" style="margin-bottom: 15px; display: flex; gap: 10px;">
      <el-input
          v-model="searchNo"
          placeholder="请输入学号查询"
          style="width: 200px"
          clearable
          @clear="resetSearch"
      />
      <el-button type="primary" @click="searchByNo">查询</el-button>
      <el-button @click="resetSearch">重置</el-button>
    </div>

    <el-table
        :data="paginatedRecords"
        style="width: 100%"
        stripe
        v-loading="loading"
        element-loading-text="加载中..."
        :empty-text="emptyText"
    >
      <el-table-column prop="no" label="学号" width="120" />
      <el-table-column prop="title" label="书名" width="200" />
      <el-table-column prop="borrowTime" label="借阅时间" width="180" />
      <el-table-column prop="returnTime" label="归还时间" width="180" />
      <el-table-column prop="fine" label="罚款（元）" width="100" />
    </el-table>

    <el-pagination
        v-if="totalRecords > 0"
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="totalRecords"
        layout="total, sizes, prev, pager, next"
        @current-change="handlePageChange"
        @size-change="handleSizeChange"
        class="custom-pagination"
        style="margin-top: 20px; text-align: right;"
    />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import request from '@/utils/request'

const searchNo = ref('')       // 输入的学号
const allRecords = ref([])     // 后端返回的全部记录
const paginatedRecords = ref([]) // 当前页显示的分页记录
const loading = ref(false)     // 请求loading状态
const currentPage = ref(1)     // 当前页码
const pageSize = ref(10)       // 每页条数
const totalRecords = ref(0)    // 总条数
const emptyText = ref('请输入学号并点击查询')

const updatePaginatedRecords = () => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  paginatedRecords.value = allRecords.value.slice(start, end)
}

const searchByNo = async () => {
  if (!searchNo.value.trim()) {
    ElMessage.warning('请输入学号')
    return
  }
  loading.value = true
  emptyText.value = '暂无借阅记录'
  try {
    const res = await request.get('/book/record', {
      params: { No: searchNo.value.trim() }
    })
    if (res.code === '200') {
      allRecords.value = Array.isArray(res.data) ? res.data : [res.data]
      totalRecords.value = allRecords.value.length
      if (totalRecords.value === 0) {
        emptyText.value = '无借阅记录'
      }
      currentPage.value = 1
      updatePaginatedRecords()
    } else {
      ElMessage.error(res.message || '查询失败')
      allRecords.value = []
      paginatedRecords.value = []
      totalRecords.value = 0
      emptyText.value = '查询失败'
    }
  } catch (err) {
    console.error(err)
    ElMessage.error('系统错误，无法查询')
    allRecords.value = []
    paginatedRecords.value = []
    totalRecords.value = 0
    emptyText.value = '系统错误，无法查询'
  } finally {
    loading.value = false
  }
}

const resetSearch = () => {
  searchNo.value = ''
  allRecords.value = []
  paginatedRecords.value = []
  totalRecords.value = 0
  currentPage.value = 1
  emptyText.value = '请输入学号并点击查询'
}

const handlePageChange = (page) => {
  currentPage.value = page
  updatePaginatedRecords()
}

const handleSizeChange = (newSize) => {
  pageSize.value = newSize
  currentPage.value = 1
  updatePaginatedRecords()
}
</script>

<style scoped>
.admin-borrow-record-page {
  padding: 20px;
}
.toolbar {
  margin-bottom: 20px;
}
</style>
