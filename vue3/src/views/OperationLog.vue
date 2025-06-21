<template>
  <div class="log-page">
    <h2>操作日志记录</h2>

    <!-- 筛选栏 -->
    <div class="toolbar" style="margin-bottom: 16px; display: flex; gap: 12px; flex-wrap: wrap;">
      <el-input v-model="searchForm.username" placeholder="操作人" clearable style="width: 180px" />
      <el-input v-model="searchForm.operation" placeholder="操作内容" clearable style="width: 200px" />
      <el-date-picker
          v-model="searchForm.timeRange"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          format="YYYY-MM-DD"
          value-format="YYYY-MM-DD"
          style="width: 280px"
      />
      <el-button type="primary" @click="fetchLogs">查询</el-button>
      <el-button @click="resetSearch">重置</el-button>
    </div>

    <!-- 表格 -->
    <el-table :data="logs" v-loading="loading" border stripe style="width: 100%">
      <el-table-column prop="username" label="操作人" width="120" />
      <el-table-column prop="role" label="角色" width="100" />
      <el-table-column prop="operation" label="操作内容" width="180" />
      <el-table-column prop="ip" label="IP地址" width="120" />
      <el-table-column prop="uri" label="请求路径" width="200" />
      <el-table-column prop="method" label="方法" width="80" />
      <el-table-column prop="params" label="请求参数" show-overflow-tooltip />
      <el-table-column prop="result" label="返回结果" show-overflow-tooltip />
      <el-table-column prop="createdTime" label="时间" width="180">
        <template #default="{ row }">
          {{ formatDate(row.createdTime) }}
        </template>
      </el-table-column>
    </el-table>

    <template>
      <!-- 更新分页组件 -->
      <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :total="total"
          @current-change="fetchLogs"
          @size-change="fetchLogs"
      />
    </template>

  </div>
</template>

<script setup>
import { ref } from 'vue'
import request from '@/utils/request'
import { ElMessage } from 'element-plus'

const loading = ref(false)
const logs = ref([])

const searchForm = ref({
  username: '',
  operation: '',
  timeRange: [],
})

const currentPage = ref(1)
const pageSize = ref(10)
const paginatedLogs = ref([])

const updatePagination = () => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  paginatedLogs.value = logs.value.slice(start, end)
}




// 时间格式化
const formatDate = (value) => {
  if (!value) return ''
  return new Date(value).toLocaleString()
}

// 查询日志// 每次查询后调用
const fetchLogs = async () => {
  loading.value = true;
  try {
    const params = {
      pageNum: currentPage.value,
      pageSize: pageSize.value,
      name: searchForm.value.username,
      operation: searchForm.value.operation,
      excludeAnonymous: true
    };

    if (searchForm.value.timeRange?.length === 2) {
      params.startTime = searchForm.value.timeRange[0];
      params.endTime = searchForm.value.timeRange[1];
    }

    const res = await request.get('/logs', { params });
    if (res.code === '200') {
      logs.value = res.data.list || [];
      total.value = res.data.total || 0; // 使用后端返回的总数
    }
  } finally {
    loading.value = false;
  }
}

// 重置搜索
const resetSearch = () => {
  searchForm.value = {
    username: '',
    operation: '',
    timeRange: [],
  }
  fetchLogs()
}

fetchLogs()
</script>

<style scoped>
.log-page {
  padding: 20px;
}
</style>
