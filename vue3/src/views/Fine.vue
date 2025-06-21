<template>
  <div class="fine-management-page">
    <h2>罚款管理</h2>

    <!-- 查询栏 -->
    <div class="toolbar" style="margin-bottom: 15px; display: flex; gap: 10px; flex-wrap: wrap;">
      <el-input v-model="searchNo" placeholder="输入学号查询" style="width: 200px" clearable />
      <el-input v-model="searchTitle" placeholder="输入书名查询" style="width: 200px" clearable />
      <el-button type="primary" @click="searchFines">查询</el-button>
      <el-button @click="resetSearch">重置</el-button>

      <el-button type="success" @click="openCompensationDialog" style="margin-left: auto;">
        新增赔偿信息
      </el-button>
    </div>

    <!-- 罚款记录表 -->
    <el-table :data="paginatedFines" style="width: 100%" stripe v-loading="loading" :row-key="row => row.id">
      <el-table-column prop="no" label="学号" width="120" />
      <el-table-column prop="title" label="书名" width="180" />

      <!-- 使用 formatter 格式化时间
      <el-table-column
          label="借阅时间"
          width="160"
          :formatter="(row, column, cellValue) => formatDate(cellValue)"
          prop="borrow_time"
      />
      <el-table-column
          label="归还时间"
          width="160"
          :formatter="(row, column, cellValue) => formatDate(cellValue)"
          prop="return_time"
      />-->

      <el-table-column prop="amount" label="金额（元）" width="120" />

      <el-table-column prop="paid" label="是否已缴纳" width="100">
        <template #default="{ row }">
          <el-tag type="success" v-if="row.paid">已缴纳</el-tag>
          <el-tag type="warning" v-else>未缴纳</el-tag>
        </template>
      </el-table-column>

      <el-table-column
          label="缴纳时间"
          width="160"
          prop="payTime"
          :formatter="(row, column, cellValue) => formatDate(cellValue)"
      />


      <el-table-column label="操作" width="150">
        <template #default="{ row }">
          <el-button
              type="primary"
              size="small"
              :disabled="row.paid || row.amount === 0"
              @click="payFine(row)"
          >缴纳罚款</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="totalFines"
        layout="total, sizes, prev, pager, next"
        @current-change="handlePageChange"
        class="custom-pagination"
        background
        :page-sizes="[10, 20, 50]"
    />

    <!-- 新增赔偿弹窗 -->
    <el-dialog v-model="compensationDialogVisible" title="新增赔偿信息" width="500px">
      <el-form :model="compensationForm" label-width="100px" ref="compensationFormRef">
        <el-form-item
            label="学号"
            prop="no"
            :rules="[{ required: true, message: '请输入学号', trigger: 'blur' }]"
        >
          <el-input v-model="compensationForm.no" />
        </el-form-item>
        <el-form-item
            label="书名"
            prop="title"
            :rules="[{ required: true, message: '请输入书名', trigger: 'blur' }]"
        >
          <el-input v-model="compensationForm.title" />
        </el-form-item>
        <el-form-item
            label="赔偿金额"
            prop="amount"
            :rules="[{ required: true, type: 'number', min: 0.01, message: '请输入有效金额', trigger: 'blur' }]"
        >
          <el-input-number v-model="compensationForm.amount" :min="0.01" :step="0.01" />
        </el-form-item>
        <el-form-item label="赔偿描述" prop="description">
          <el-input type="textarea" v-model="compensationForm.description" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="compensationDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitCompensation">提交</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import request from '@/utils/request'

const searchNo = ref('')
const searchTitle = ref('')

const allFines = ref([])
const paginatedFines = ref([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const totalFines = ref(0)

const compensationDialogVisible = ref(false)
const compensationForm = reactive({
  no: '',
  title: '',
  amount: 0,
  description: ''
})

const compensationFormRef = ref(null)

// 格式化时间函数
const formatDate = (value) => {
  if (!value) return ''
  const date = new Date(value)
  if (isNaN(date.getTime())) return ''
  const y = date.getFullYear()
  const m = String(date.getMonth() + 1).padStart(2, '0')
  const d = String(date.getDate()).padStart(2, '0')
  const hh = String(date.getHours()).padStart(2, '0')
  const mm = String(date.getMinutes()).padStart(2, '0')
  const ss = String(date.getSeconds()).padStart(2, '0')
  return `${y}-${m}-${d} ${hh}:${mm}:${ss}`
}


// 获取罚款和赔偿记录
const fetchFines = async () => {
  loading.value = true
  try {
    let url = `/fine/records`
    if (searchNo.value) url += `?no=${encodeURIComponent(searchNo.value)}`
    if (searchTitle.value) {
      url += url.includes('?') ? '&' : '?'
      url += `title=${encodeURIComponent(searchTitle.value)}`
    }
    const res = await request.get(url)
    if (res.code === '200') {
      console.log('后台返回数据:', res.data)
      allFines.value = Array.isArray(res.data) ? res.data : []
      totalFines.value = allFines.value.length
      updatePaginatedFines()
    } else {
      ElMessage.error(res.message || '获取罚款记录失败')
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('系统错误，无法获取罚款记录')
  } finally {
    loading.value = false
  }

}





// 分页更新
const updatePaginatedFines = () => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  paginatedFines.value = allFines.value.slice(start, end)
}

// 页码切换
const handlePageChange = (page) => {
  currentPage.value = page
  updatePaginatedFines()
}

// 查询事件
const searchFines = () => {
  currentPage.value = 1
  fetchFines()
}

// 重置查询条件
const resetSearch = () => {
  searchNo.value = ''
  searchTitle.value = ''
  currentPage.value = 1
  fetchFines()
}

// 缴纳罚款事件
const payFine = (row) => {
  ElMessageBox.confirm(`确认缴纳学号为 ${row.no}，书名为《${row.title}》的罚款吗？`, '缴纳罚款', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    try {
      const res = await request.post('/fine/pay', { id: row.id })
      if (res.code === '200') {
        ElMessage.success('罚款缴纳成功')
        fetchFines()
      } else {
        ElMessage.error(res.message || '缴纳失败')
      }
    } catch (err) {
      console.error(err)
      ElMessage.error('系统错误，缴纳失败')
    }
  }).catch(() => {})
}

// 打开新增赔偿弹窗
const openCompensationDialog = () => {
  compensationDialogVisible.value = true
  compensationForm.no = ''
  compensationForm.title = ''
  compensationForm.amount = 0
  compensationForm.description = ''
}

// 提交新增赔偿
const submitCompensation = () => {
  compensationFormRef.value.validate(async (valid) => {
    if (!valid) return
    try {
      const res = await request.post('/fine/add', {
        ...compensationForm,
        type: 'compensation',
        paid: false,
        payTime: null,
        borrowTime: null,
        returnTime: null
      })
      if (res.code === '200') {
        ElMessage.success('赔偿信息添加成功')
        compensationDialogVisible.value = false
        fetchFines()
      } else {
        ElMessage.error(res.message || '添加失败')
      }
    } catch (err) {
      console.error(err)
      ElMessage.error('系统错误，添加失败')
    }
  })
}

// 初始化加载
onMounted(() => {
  fetchFines()
})
</script>
