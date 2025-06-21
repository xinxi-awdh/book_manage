<template>
  <div class="borrow-record-page">
    <h2>借阅记录</h2>
    <el-table :data="paginatedRecords" style="width: 100%" stripe v-loading="loading">
      <el-table-column prop="title" label="书名" />
      <el-table-column prop="borrowTime" label="借阅时间" />
      <el-table-column prop="returnTime" label="归还时间" />
      <el-table-column prop="fine" label="罚款（元）" />
    </el-table>

    <!-- 分页组件 -->
    <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="totalRecords"
        layout="total, sizes, prev, pager, next"
        @current-change="handlePageChange"
        class="custom-pagination"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import request from '@/utils/request'

const allRecords = ref([]) // 全部借阅记录
const paginatedRecords = ref([]) // 当前页
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const totalRecords = ref(0)

const user = JSON.parse(localStorage.getItem('xm-pro-user') || '{}')

const fetchRecords = async () => {
  if (!user.no) {
    ElMessage.warning('用户未登录')
    return
  }

  loading.value = true
  try {
    // 请求接口，根据用户学号查询记录
    const res = await request.get(`/book/record?No=${user.no}`)
    if (res.code === '200') {
      allRecords.value = Array.isArray(res.data) ? res.data : [res.data]
      totalRecords.value = allRecords.value.length
      updatePaginatedRecords()
    } else {
      ElMessage.error(res.message || '获取记录失败')
    }
  } catch (err) {
    console.error(err)
    ElMessage.error('系统异常，无法获取借阅记录')
  } finally {
    loading.value = false
  }
}

// 分页更新
const updatePaginatedRecords = () => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  paginatedRecords.value = allRecords.value.slice(start, end)
}

const handlePageChange = (page) => {
  currentPage.value = page
  updatePaginatedRecords()
}

onMounted(() => {
  fetchRecords()
})
</script>

<style scoped>
.borrow-record-page {
  padding: 20px;
  background-color: #e0d4d4;
  color: #f0f0f0;
  border-radius: 10px;
}
.borrow-record-page h2 {
  color: #ffffff;
  text-align: center;
  margin-bottom: 20px;
}
.el-table {
  background-color: #1e1e1e;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  border: 1px solid #444;
}
.el-table__row {
  background-color: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 5px;
  transition: all 0.3s ease;
}
.el-table__row:nth-child(odd) {
  background-color: rgba(255, 255, 255, 0.1);
}
.el-table__row:nth-child(even) {
  background-color: rgba(255, 255, 255, 0.15);
}
.el-table__row:hover {
  background-color: rgba(255, 255, 255, 0.2);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}
.el-table th {
  background-color: #333;
  color: #ffffff;
  font-weight: bold;
  padding: 12px;
  text-align: center;
}
.el-table__cell {
  padding: 10px;
  color: #f0f0f0;
}
.el-loading-mask {
  background-color: rgba(0, 0, 0, 0.5) !important;
}
.custom-pagination {
  margin-top: 20px;
  text-align: center;
}
</style>
