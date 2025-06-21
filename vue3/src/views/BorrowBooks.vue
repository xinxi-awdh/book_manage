<template>
  <div>
    <!-- 搜索栏 -->
    <div class="toolbar">
      <el-input v-model="searchKey" placeholder="输入书名" style="width: 240px" />
      <el-button type="primary" @click="searchBooks">查询</el-button>
      <el-button type="warning" @click="resetSearch">重置</el-button>
    </div>

    <el-table :data="books" style="width: 100%" stripe v-loading="loading">
      <el-table-column prop="isbn" label="ISBN" width="180" />
      <el-table-column prop="title" label="书名" width="180" />
      <el-table-column prop="author" label="作者" />
      <el-table-column prop="publisher" label="出版社" />
      <el-table-column prop="price" label="价格" />
      <el-table-column prop="stock" label="库存" />
      <el-table-column label="操作" width="220">
        <template #default="scope">
          <el-button
              @click="borrowBook(scope.row)"
              size="small"
              :disabled="scope.row.stock <= 0 || scope.row.borrowed"
              :type="scope.row.borrowed ? 'info' : 'success'"
          >
            借阅
          </el-button>
          <el-button
              @click="returnBook(scope.row)"
              size="small"
              :disabled="!scope.row.borrowed"
              :type="scope.row.borrowed ? 'danger' : 'info'"
          >
            归还
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="total"
        :page-sizes="[10, 20, 50]"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        layout="total, sizes, prev, pager, next"
        class="custom-pagination"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import request from '@/utils/request'
import { ElMessage } from 'element-plus'

const searchKey = ref('') // 输入的书名或关键词
const books = ref([]) // 图书列表
const loading = ref(false)

const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 当前用户信息
const user = JSON.parse(localStorage.getItem('xm-pro-user') || '{}')

// 用于存储当前用户所有借阅记录的书名集合，方便判断某书是否已借阅
const userBorrowedTitles = ref(new Set())

// 加载用户借阅记录，初始化 userBorrowedTitles
const loadUserBorrowRecords = async () => {
  if (!user.no) return

  try {
    const res = await request.get(`/book/record?No=${user.no}`)
    if (res.code === '200' && Array.isArray(res.data)) {
      // 只记录未归还的书
      userBorrowedTitles.value = new Set(
          res.data
              .filter(record => !record.returnTime)  // returnTime 为 null 表示未归还
              .map(record => record.title)
      )
    } else {
      userBorrowedTitles.value = new Set()
    }
  } catch (e) {
    console.error('加载借阅记录失败', e)
    userBorrowedTitles.value = new Set()
  }
}

// 加载书籍数据（分页）
const loadBooks = async () => {
  loading.value = true
  try {
    const params = {
      pageNum: currentPage.value,
      pageSize: pageSize.value,
      title: searchKey.value.trim(),
      author: searchKey.value.trim()
    }
    const res = await request.post('/books/page', params)
    if (res.code === '200' && res.data && Array.isArray(res.data.list)) {
      // 标记是否已借阅
      books.value = res.data.list.map(book => ({
        ...book,
        borrowed: userBorrowedTitles.value.has(book.title)
      }))
      total.value = res.data.total
    } else {
      ElMessage.error(res.message || '加载图书失败')
    }
  } catch (e) {
    console.error('加载图书失败', e)
    ElMessage.error('系统异常，加载图书失败')
  } finally {
    loading.value = false
  }
}

// 查询书籍（重置分页并加载）
const searchBooks = () => {
  currentPage.value = 1
  loadBooks()
}

// 重置搜索条件
const resetSearch = () => {
  searchKey.value = ''
  searchBooks()
}

// 处理分页每页条数变化
const handleSizeChange = (size) => {
  pageSize.value = size
  currentPage.value = 1
  loadBooks()
}

// 处理分页页码变化
const handleCurrentChange = (page) => {
  currentPage.value = page
  loadBooks()
}

// 借阅图书
const borrowBook = async (book) => {
  if (!user.no) {
    ElMessage.warning('请先登录')
    return
  }
  if (book.stock <= 0) {
    ElMessage.warning('库存不足，无法借阅')
    return
  }
  if (book.borrowed) {
    ElMessage.info('您已借阅该书')
    return
  }

  try {
    const res = await request.post('/book/borrow', {
      no: user.no,
      title: book.title
    })
    if (res.code === '200') {
      ElMessage.success('借阅成功')
      book.stock--
      book.borrowed = true
      userBorrowedTitles.value.add(book.title)
    } else {
      ElMessage.error(res.message || '借阅失败')
    }
  } catch (e) {
    console.error('借阅接口异常', e)
    ElMessage.error('借阅失败，服务器异常')
  }
}

// 归还图书
const returnBook = async (book) => {
  if (!user.no) {
    ElMessage.warning('请先登录')
    return
  }
  if (!book.borrowed) {
    ElMessage.info('该书尚未借阅')
    return
  }

  try {
    const res = await request.post('/book/return', {
      no: user.no,
      title: book.title
    })
    if (res.code === '200') {
      ElMessage.success(`归还成功，罚款金额：${res.data?.fine ?? 0} 元`)
      book.stock++
      book.borrowed = false
      userBorrowedTitles.value.delete(book.title)
    } else {
      ElMessage.error(res.message || '归还失败')
    }
  } catch (e) {
    console.error('归还接口异常', e)
    ElMessage.error('归还失败，服务器异常')
  }
}

// 初始化加载数据，先加载借阅记录，再加载图书列表
onMounted(async () => {
  await loadUserBorrowRecords()
  await loadBooks()
})
</script>

<style scoped>
/* 新增分页样式 */
:deep(.el-pagination) {
  margin-top: 20px;
  justify-content: center;
}

/* 分页按钮样式 */
:deep(.el-pagination .btn-prev),
:deep(.el-pagination .btn-next),
:deep(.el-pagination .el-pager li) {
  background: rgba(255, 255, 255, 0.8);
  border-radius: 15px;
  margin: 0 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

/* 悬停效果 */
:deep(.el-pagination .btn-prev:hover),
:deep(.el-pagination .btn-next:hover),
:deep(.el-pagination .el-pager li:hover) {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
  background: linear-gradient(145deg, #f0f9ff, #c8e6ff);
}

/* 当前页样式 */
:deep(.el-pagination .el-pager li.is-active) {
  background: linear-gradient(135deg, #409EFF, #79BBFF);
  color: white;
  font-weight: bold;
  border-radius: 15px;
}

/* 禁用状态样式 */
:deep(.el-pagination button[disabled]) {
  background: rgba(245, 245, 245, 0.8) !important;
  color: #c0c4cc !important;
}

/* 分页信息文字样式 */
:deep(.el-pagination__total),
:deep(.el-pagination__jump) {
  color: #666;
  font-size: 14px;
}

/* 下拉选择框样式 */
:deep(.el-select .el-input__wrapper) {
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.9);
}

/* 背景渐变 */
.content {
  background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
}

/* 渐变动画 */
@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

.el-table__row {
  background-color: rgba(0, 0, 0) !important;
}

.el-table__row:nth-child(odd) {
  background-color: rgba(0, 0, 0) !important; /* 透明背景 */
}

.el-table__row:nth-child(even) {
  background-color: rgba(0, 0, 0, 0.1); /* 透明背景 */
}
</style>
