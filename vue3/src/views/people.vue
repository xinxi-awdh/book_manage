<template>
  <el-card class="punch-card" shadow="always">
    <div class="header">
      <el-icon><User /></el-icon>
      <h2>打卡中心</h2>
    </div>

    <div class="user-info">
      <el-descriptions title="用户信息" column="1" border>
        <el-descriptions-item label="编号">{{ userNo || '未获取' }}</el-descriptions-item>
        <el-descriptions-item label="姓名">{{ userName || '未获取' }}</el-descriptions-item>
        <el-descriptions-item label="打卡时间">{{ punchTime || '未打卡' }}</el-descriptions-item>
      </el-descriptions>
    </div>

    <div class="punch-section">
      <el-button
          type="success"
          size="large"
          :loading="loading"
          :disabled="!isUserValid || hasPunched"
          @click="handlePunch"
      >
        {{ buttonText }}
      </el-button>
    </div>
  </el-card>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { User } from '@element-plus/icons-vue'
import axios from '@/utils/request'

const userNo     = ref('')
const userName   = ref('')
const loading    = ref(false)
const hasPunched = ref(false)
const punchTime  = ref('')

// 判断按钮状态
const isUserValid = computed(() => !!userNo.value && !!userName.value)
const buttonText  = computed(() => {
  if (hasPunched.value) return '已打卡'
  return loading.value ? '打卡中...' : '立即打卡'
})

// 载入本地登录信息
function loadUserInfo() {
  try {
    const str = localStorage.getItem('xm-pro-user')
    if (!str) {
      ElMessage.warning('未找到登录信息')
      return
    }
    const u = JSON.parse(str)
    userNo.value   = (u.no   || '').trim()
    userName.value = (u.name || '').trim()
  } catch {
    ElMessage.error('用户信息解析失败')
  }
}

// 把后端返回的任意 ISO 字符串提取成 yyyy-MM-dd HH:mm:ss 格式并转换为中国时区
function normalizeTime(raw = '') {
  if (!raw) return ''

  // 有些 Java 返回的是 "Thu Apr 24 04:48:46 AWST 2025" 这种格式
  const parsedTime = Date.parse(raw)
  if (isNaN(parsedTime)) return '无效时间'

  const date = new Date(parsedTime)
  const options = {
    timeZone: 'Asia/Shanghai',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false
  }

  return date.toLocaleString('zh-CN', options).replace(/\//g, '-').replace(',', '')
}

// 检查打卡状态 & 拿到原始时间字符串
async function checkPunchStatus() {
  if (!userNo.value) return
  try {
    const res = await axios.get('/api/punch/check', {
      params: { userNo: userNo.value }
    })

    console.log('接口返回数据：', res.data)

    const result = res.data
    if (typeof result === 'string' && result.includes('今日已打卡')) {
      hasPunched.value = true

      // 提取时间
      const timeStr = result.split('时间：')[1]?.trim()
      punchTime.value = normalizeTime(timeStr)
    } else {
      hasPunched.value = false
      punchTime.value = ''
    }
  } catch (err) {
    console.error(err)
    ElMessage.error('检查打卡状态失败')
  }
}


// 点击打卡
async function handlePunch() {
  if (!isUserValid.value || hasPunched.value) return
  loading.value = true
  try {
    await axios.post('/api/punch', null, {
      params: {
        userNo:   userNo.value,
        userName: userName.value
      }
    })
    ElMessage.success('打卡成功')
    await checkPunchStatus()
  } catch (err) {
    console.error(err)
    ElMessage.error('打卡失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadUserInfo()
  checkPunchStatus()
})
</script>

<style scoped>
.punch-card {
  max-width: 500px;
  margin: 80px auto;
  padding: 30px;
  border-radius: 20px;
  background: #ffffff;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  background-color: #f5f7fa; /* 背景色 */
  border: 2px solid #dcdfe6; /* 边框分界线 */
}

.punch-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
}

.header {
  text-align: center;
  margin-bottom: 24px;
}

.header h2 {
  font-weight: bold;
  font-size: 24px;
  color: #333;
  margin: 12px 0 0;
}

.user-info {
  margin-bottom: 24px;
  background-color: #d0b8b8; /* 背景色 */
  border: 1px solid #9fadcb; /* 边框分界线 */
  padding: 16px;
  border-radius: 8px;
}

.punch-section {
  text-align: center;
  margin-top: 24px;
}

.punch-alert {
  margin-top: 24px;
}

/* 额外细化描述组件 */
.el-descriptions__title {
  font-weight: bold;
  font-size: 18px;
  color: #409EFF;
}

.el-descriptions {
  background: #f9fafb;
  border-radius: 12px;
  padding: 16px;
}

.el-descriptions-item__cell {
  padding: 12px 8px;
  font-size: 14px;
  color: #606266;
}

/* 美化按钮 */
.el-button {
  border-radius: 8px;
  padding: 12px 24px;
  font-size: 16px;
}

.el-button--success {
  background: linear-gradient(135deg, #67C23A, #4CAF50);
  border: none;
  color: #fff;
  transition: all 0.3s ease;
}

.el-button--success:hover {
  background: linear-gradient(135deg, #78d64b, #5cbf5a);
  box-shadow: 0 4px 12px rgba(103, 194, 58, 0.4);
}
</style>
