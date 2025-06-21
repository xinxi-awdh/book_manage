<template>
  <div class="data-borrow-page">
    <h2>借阅统计与记录</h2>

    <el-card class="data-card">
      <h3>借阅统计</h3>
      <el-row :gutter="20">
        <el-col :span="8" v-for="stat in statistics" :key="stat.label">
          <el-card class="stat-card" shadow="hover">
            <h4>{{ stat.label }}</h4>
            <p class="stat-value">{{ stat.value }}</p>
          </el-card>
        </el-col>
      </el-row>
      <el-divider></el-divider>
      <div class="chart-section">
        <h4>借阅统计柱状图</h4>
        <div ref="barChart" class="chart"></div>
      </div>
    </el-card>

    <el-card class="data-card">
      <h3>已归还书籍的借阅记录</h3>
      <el-table :data="returnedRecords" style="width: 100%" stripe>
        <el-table-column prop="title" label="书名" />
        <el-table-column prop="borrowTime" label="借阅时间" />
        <el-table-column prop="borrowDays" label="借阅天数" />
      </el-table>
    </el-card>

    <el-card class="data-card">
      <h3>已归还书籍的借阅时间折线图</h3>
      <div ref="lineChart" class="chart"></div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import request from '@/utils/request'
import * as echarts from 'echarts'

const records = ref([])
const returnedRecords = ref([])
const loading = ref(false)

const statistics = ref([
  { label: '借阅总数', value: 0 },
  { label: '归还总数', value: 0 },
  { label: '待归还图书', value: 0 },
  { label: '借阅天数', value: 0 }
])

const barChart = ref(null)
const lineChart = ref(null)
let barChartInstance = null
let lineChartInstance = null

const getCurrentUser = () => JSON.parse(localStorage.getItem('xm-pro-user') || '{}')

const calculateBorrowDays = (borrowTime, returnTime) => {
  const borrowDate = new Date(borrowTime)
  const returnDate = returnTime ? new Date(returnTime) : new Date()
  // +1 保证借阅天数至少为1天
  return Math.max(1, Math.floor((returnDate - borrowDate) / (1000 * 60 * 60 * 24)))
}

const fetchRecords = async () => {
  const user = getCurrentUser()
  if (!user.no) {
    ElMessage.warning('用户未登录')
    return
  }

  loading.value = true
  try {
    const res = await request.get(`/book/record?No=${user.no}`)
    if (res.code === '200') {
      records.value = Array.isArray(res.data) ? res.data : [res.data]

      // 统计
      let totalBorrowedDays = 0
      let totalReturned = 0
      let totalUnreturned = 0
      const tempReturnedRecords = []

      for (const r of records.value) {
        if (r.returnTime) {
          totalReturned++
          const days = calculateBorrowDays(r.borrowTime, r.returnTime)
          totalBorrowedDays += days
          tempReturnedRecords.push({
            title: r.title,
            borrowTime: r.borrowTime,
            borrowDays: days
          })
        } else {
          totalUnreturned++
        }
      }

      statistics.value = [
        { label: '借阅总数', value: records.value.length },
        { label: '归还总数', value: totalReturned },
        { label: '待归还图书', value: totalUnreturned },
        { label: '借阅天数', value: totalBorrowedDays }
      ]

      returnedRecords.value = tempReturnedRecords

      updateBarChart()
      updateLineChart()
    } else {
      ElMessage.error(res.message || '获取记录失败')
    }
  } catch (error) {
    ElMessage.error('获取借阅记录失败')
  } finally {
    loading.value = false
  }
}

const updateBarChart = () => {
  if (!barChartInstance) {
    barChartInstance = echarts.init(barChart.value)
  }
  const option = {
    tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
    xAxis: {
      type: 'category',
      data: statistics.value.map(s => s.label),
      axisLabel: { interval: 0, rotate: 30 }
    },
    yAxis: { type: 'value' },
    series: [{
      name: '数量',
      type: 'bar',
      data: statistics.value.map(s => s.value),
      itemStyle: {
        color: (params) => {
          switch (params.dataIndex) {
            case 0: return '#42b983'
            case 1: return '#3498db'
            case 2: return '#f39c12'
            case 3: return '#e74c3c'
            default: return '#95a5a6'
          }
        }
      },
      barWidth: 40
    }]
  }
  barChartInstance.setOption(option)
}

const updateLineChart = () => {
  if (!lineChartInstance) {
    lineChartInstance = echarts.init(lineChart.value)
  }
  const titles = returnedRecords.value.map(r => r.title)
  const borrowDays = returnedRecords.value.map(r => r.borrowDays)
  const option = {
    tooltip: { trigger: 'axis' },
    xAxis: {
      type: 'category',
      data: titles,
      axisLabel: { rotate: 45 }
    },
    yAxis: {
      type: 'value',
      name: '借阅天数'
    },
    series: [{
      name: '借阅天数',
      type: 'line',
      data: borrowDays,
      smooth: true,
      lineStyle: { color: '#3498db' },
      symbolSize: 10,
      itemStyle: { color: '#3498db' }
    }]
  }
  lineChartInstance.setOption(option)
}

onMounted(() => {
  fetchRecords()
})
</script>

<style scoped>
.data-borrow-page {
  padding: 20px;
}

.data-card {
  margin-bottom: 20px;
}

.stat-card {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-value {
  font-size: 1.5em;
  color: #42b983;
}

.chart {
  height: 400px;
  border: 1px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
