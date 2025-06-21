<template>
  <div class="book-management">
    <!-- 轮播图 -->
    <el-carousel height="200px" autoplay>
      <el-carousel-item v-for="(img, index) in carouselImages" :key="index">
        <img :src="img" alt="轮播图" style="width: 100%; height: 200px; object-fit: cover;" />
      </el-carousel-item>
    </el-carousel>

    <!-- 轮播图下方左右布局 -->
    <div class="content-wrapper">
      <!-- 左边书籍列表 -->
      <div class="book-list">
        <el-table
            :data="books"
            style="width: 100%;"
            v-loading="loading"
            border
            stripe
        >
          <el-table-column prop="title" label="书名" width="250" />
          <el-table-column prop="author" label="作者" width="180" />
          <el-table-column label="状态" width="120">
            <template #default="{ row }">
              <el-tag :type="statusType(row.status)">
                {{ statusText(row.status) }}
              </el-tag>

            </template>
          </el-table-column>
        </el-table>

        <el-pagination
            style="margin-top: 20px; text-align: right;"
            background
            layout="prev, pager, next"
            :total="total"
            :page-size="pageSize"
            v-model:current-page="page"
            @current-change="loadBooks"
        />
      </div>

      <!-- 右边介绍文字 -->
      <div class="intro-side">
        <h2>关于我们的图书馆</h2>
        <p>
          我们的图书馆拥有丰富的藏书，涵盖文学、科技、历史等多个领域。您可以方便快捷地查询书籍状态并进行借阅。
        </p>
        <p>
          本系统支持图书的实时管理和状态更新，致力于为读者提供更好的服务体验。
        </p>
        <p>
          欢迎各位读者积极使用本系统，享受阅读的乐趣。
        </p>
      </div>
    </div>
    <!-- 页尾 -->
    <footer class="page-footer">
      <div class="footer-content">
        <p>版权所有 &copy; 2025 小新-图书管理系统</p>
        <p>联系方式：1656450632@qq.c0m | 电话：139-4567-4890</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import request from '@/utils/request'
import img1 from '@/assets/1.jpg'
import img2 from '@/assets/2.jpg'
import img3 from '@/assets/3.jpg'

const carouselImages = [img1, img2, img3]

const books = ref([])
const loading = ref(false)
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const searchKey = ref('')

// 状态映射：数字状态对应显示文字和颜色
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


const loadBooks = async () => {
  loading.value = true
  try {
    const res = await request.post('/books/page', {
      pageNum: page.value,
      pageSize: pageSize.value,
      title: searchKey.value.trim(),
    })
    if (res.code === '200') {
      books.value = res.data.list || []
      total.value = res.data.total || 0
    } else {
      ElMessage.error(res.message || '加载图书列表失败')
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('请求异常')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadBooks()
})
</script>

<style scoped>
.book-management {
  padding: 20px;
}

/* 轮播图和内容间距 */


/* 左右布局 */
.content-wrapper {
  display: flex;
  gap: 20px;
}

/* 左边书籍列表，占比大 */
.book-list {
  flex: 3;
}

/* 右边介绍文字，占比小 */
.intro-side {
  flex: 1;
  background: #f9f9f9;
  padding: 20px;
  border-radius: 8px;
  color: #555;
  box-shadow: 0 0 10px rgb(0 0 0 / 0.1);
}

.intro-side h2 {
  margin-bottom: 16px;
  font-weight: 600;
}

.intro-side p {
  margin-bottom: 12px;
  line-height: 1.5;
}
.el-carousel {
  max-width: 960px;      /* 最大宽度 */
  margin: 0 auto 20px;   /* 上下间距20px，水平居中 */
  border-radius: 8px;    /* 圆角（可选） */
  overflow: hidden;      /* 防止图片溢出圆角 */
  box-shadow: 0 4px 10px rgba(0,0,0,0.1); /* 轻微阴影 */
}

.el-carousel-item img {
  width: 100%;
  height: 250px;         /* 稍微调高一点 */
  object-fit: cover;     /* 保持比例填充 */
}

.page-footer {
  margin-top: 40px;
  padding: 20px 0;
  background-color: #f5f5f5;
  text-align: center;
  color: #888;
  font-size: 14px;
  border-top: 1px solid #ddd;
}

.page-footer .footer-content p {
  margin: 4px 0;
}

</style>
