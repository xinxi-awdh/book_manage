<template>
  <div>
    <!-- 工具栏 -->
    <div class="toolbar">
      <el-input v-model="searchKey" placeholder="输入书名" style="width: 240px" />
      <el-button type="primary" @click="searchBooks">查询</el-button>
      <el-button type="warning" @click="resetSearch">重置</el-button>
      <el-button type="success" @click="openAddDialog">新增图书</el-button>
      <el-upload style="margin: 0 10px" :show-file-list="false" :before-upload="handleImport">
        <el-button type="success">导入</el-button>
      </el-upload>
      <el-button type="danger" @click="exportBooksToExcel">导出 Excel</el-button>
    </div>

    <!-- 图书表格 -->
    <el-table :data="books" style="width: 100%" stripe>
      <el-table-column prop="isbn" label="ISBN" width="140" />
      <el-table-column prop="title" label="书名" width="160" />
      <el-table-column prop="author" label="作者" width="120" />
      <el-table-column prop="publisher" label="出版社" width="120" />
      <el-table-column
          prop="publishDate"
          label="出版日期"
          width="120"
          :formatter="row => row.publishDate ? row.publishDate.split('T')[0] : ''"
      />
      <el-table-column prop="categoryCode" label="分类编码" width="100" />
      <el-table-column prop="price" label="价格" width="80" />
      <el-table-column label="封面" width="100">
        <template #default="{ row }">
          <img :src="row.cover || defaultCover" alt="封面" style="width: 40px; height: 60px; object-fit: cover;" />
        </template>
      </el-table-column>
      <el-table-column prop="description" label="描述" min-width="180" show-overflow-tooltip />
      <el-table-column prop="total" label="总数" width="80" />
      <el-table-column prop="stock" label="库存" width="80" />
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="statusType(row.status)">
            {{ statusText(row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button @click="editBook(row)" type="primary" size="small">编辑</el-button>
          <el-button @click="deleteBook(row.id)" type="danger" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
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

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px" :destroy-on-close="true">
      <el-form :model="form" label-width="100px" ref="formRef" :rules="rules" status-icon>
        <el-form-item label="ISBN" prop="isbn">
          <el-input v-model="form.isbn" autocomplete="off" />
        </el-form-item>
        <el-form-item label="书名" prop="title">
          <el-input v-model="form.title" autocomplete="off" />
        </el-form-item>
        <el-form-item label="作者" prop="author">
          <el-input v-model="form.author" autocomplete="off" />
        </el-form-item>
        <el-form-item label="出版社" prop="publisher">
          <el-input v-model="form.publisher" autocomplete="off" />
        </el-form-item>
        <el-form-item label="出版日期" prop="publishDate">
          <el-date-picker
              v-model="form.publishDate"
              type="date"
              placeholder="选择日期"
              style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="分类编码" prop="categoryCode">
          <el-input v-model="form.categoryCode" autocomplete="off" />
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="form.price" :precision="2" :min="0" style="width: 100%" />
        </el-form-item>
        <el-form-item label="封面" label-width="20px">
          <div style="width: 100%; justify-content: center; display: flex;">
            <el-upload
                class="cover-uploader"
                action="http://localhost:9090/files/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
            >
              <img v-if="form.cover" :src="form.cover" class="cover" />
              <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
            </el-upload>
          </div>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input type="textarea" v-model="form.description" />
        </el-form-item>
        <el-form-item label="总数" prop="total">
          <el-input-number v-model="form.total" :min="0" style="width: 100%" />
        </el-form-item>
        <el-form-item label="库存" prop="stock">
          <el-input-number v-model="form.stock" :min="0" style="width: 100%" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="选择状态">
            <el-option label="在馆" :value="0" />
            <el-option label="借出" :value="1" />
            <el-option label="预约中" :value="2" />
            <el-option label="下架" :value="3" />
            <el-option label="遗失" :value="4" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">提交</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, toRaw } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import request from '@/utils/request'
import * as XLSX from 'xlsx'
import { Plus } from '@element-plus/icons-vue'

const searchKey = ref('')
const books = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const dialogTitle = ref('新增图书')
const isEditMode = ref(false)

const form = reactive({
  id: null,
  isbn: '',
  title: '',
  author: '',
  publisher: '',
  publishDate: '',
  categoryCode: '',
  price: 0,
  cover: '',
  description: '',
  total: 0,
  stock: 0,
  status: 0,
})

const formRef = ref(null)
const defaultCover = '/default-cover.png'

const statusText = (status) => {
  status = Number(status)
  switch (status) {
    case 0:
      return '在馆'
    case 1:
      return '借出'
    case 2:
      return '预约中'
    case 3:
      return '下架'
    case 4:
      return '遗失'
    default:
      return '未知'
  }
}

const statusType = (status) => {
  status = Number(status)
  switch (status) {
    case 0:
      return 'success'
    case 1:
      return 'info'
    case 2:
      return 'warning'
    case 3:
    case 4:
      return 'danger'
    default:
      return 'info'
  }
}

const handleAvatarSuccess = (res) => {

  form.cover = res.data
}

const loadBooks = async () => {
  try {
    const res = await request.post('/books/page', {
      pageNum: currentPage.value,
      pageSize: pageSize.value,
      title: searchKey.value.trim(),
    })
    books.value = res.data.list || []
    total.value = res.data.total || 0
  } catch (error) {
    ElMessage.error('加载图书列表失败')
  }
}

const searchBooks = () => {
  currentPage.value = 1
  loadBooks()
}

const resetSearch = () => {
  searchKey.value = ''
  currentPage.value = 1
  loadBooks()
}

const editBook = (row) => {
  form.id = row.id
  form.isbn = row.isbn
  form.title = row.title
  form.author = row.author
  form.publisher = row.publisher
  form.publish_date = row.publishDate
  form.category_code = row.categoryCode
  form.price = row.price
  form.cover = row.cover
  form.description = row.description
  form.total = row.total
  form.stock = row.stock
  form.status = Number(row.status)

  dialogTitle.value = '编辑图书'
  isEditMode.value = true
  dialogVisible.value = true
}

const openAddDialog = () => {
  Object.keys(form).forEach((key) => {
    if (typeof form[key] === 'number') form[key] = 0
    else form[key] = ''
  })
  form.id = null
  dialogTitle.value = '新增图书'
  isEditMode.value = false
  dialogVisible.value = true
}

const submitForm = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) return

    try {
      const submitData = {
        ...toRaw(form),
        status: Number(form.status),
      }

      if (submitData.publish_date instanceof Date) {
        const d = submitData.publish_date
        submitData.publish_date = `${d.getFullYear()}-${(d.getMonth() + 1)
            .toString()
            .padStart(2, '0')}-${d.getDate().toString().padStart(2, '0')}`
      }

      if (isEditMode.value) {
        if (!submitData.id) {
          ElMessage.error('缺少图书ID')
          return
        }
        await request.put(`/books/update`, submitData)
        ElMessage.success('更新成功')
      } else {
        await request.post('/books/add', submitData)
        ElMessage.success('新增成功')
      }

      dialogVisible.value = false
      loadBooks()
    } catch (error) {
      console.error(error)
      ElMessage.error(error.response?.data?.message || '操作失败')
    }
  })
}

const deleteBook = async (id) => {
  try {
    await ElMessageBox.confirm('确认删除该图书吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    })
    await request.delete(`/books/${id}`)
    ElMessage.success('删除成功')
    if (books.value.length === 1 && currentPage.value > 1) {
      currentPage.value--
    }
    loadBooks()
  } catch (error) {
    if (error !== 'cancel') ElMessage.error('删除失败')
  }
}

const handleSizeChange = (size) => {
  pageSize.value = size
  currentPage.value = 1
  loadBooks()
}

const handleCurrentChange = (page) => {
  currentPage.value = page
  loadBooks()
}

const handleImport = async (file) => {
  try {
    const data = await file.arrayBuffer()
    const workbook = XLSX.read(data, { type: 'array' })
    const sheet = workbook.Sheets[workbook.SheetNames[0]]
    const json = XLSX.utils.sheet_to_json(sheet)

    const statusMap = {
      在馆: 0,
      借出: 1,
      预约中: 2,
      下架: 3,
      遗失: 4,
    }

    for (const row of json) {
      if (!row['ISBN'] || !row['书名']) continue
      await request.post('/books/add', {
        isbn: row['ISBN'],
        title: row['书名'],
        author: row['作者'],
        publisher: row['出版社'],
        publish_date: row['出版日期'],
        category_code: row['分类编码'],
        price: parseFloat(row['价格']) || 0,
        cover: row['封面'] || '',
        description: row['描述'] || '',
        total: parseInt(row['总数']) || 0,
        stock: parseInt(row['库存']) || 0,
        status: statusMap[row['状态']] ?? 0,
      })
    }
    ElMessage.success('导入成功')
    loadBooks()
  } catch (e) {
    console.error(e)
    ElMessage.error('导入失败')
  }
  return false
}

const exportBooksToExcel = async () => {
  try {
    const res = await request.get('/books/all-book')
    const exportData = res.data.map((book) => ({
      ISBN: book.isbn,
      书名: book.title,
      作者: book.author,
      出版社: book.publisher,
      出版日期: book.publish_date,
      分类编码: book.category_code,
      价格: book.price,
      封面: book.cover,
      描述: book.description,
      总数: book.total,
      库存: book.stock,
      状态: statusText(book.status),
    }))
    const sheet = XLSX.utils.json_to_sheet(exportData)
    const workbook = XLSX.utils.book_new()
    XLSX.utils.book_append_sheet(workbook, sheet, '图书列表')
    XLSX.writeFile(workbook, 'books_export.xlsx')
    ElMessage.success('导出成功')
  } catch (error) {
    ElMessage.error('导出失败')
  }
}

onMounted(loadBooks)
</script>

<style scoped>
.toolbar {
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
}
.custom-pagination {
  margin-top: 16px;
  text-align: right;
}
.cover-uploader img.cover {
  width: 80px;
  height: 100px;
  object-fit: cover;
  cursor: pointer;
}
</style>
