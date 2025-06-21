<template>
  <div class="login-container">
    <div class="login-box">
      <h2>图书管理系统登录</h2>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="no">
          <el-input v-model="form.no" placeholder="账号" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" type="password" placeholder="密码" />
        </el-form-item>
        <el-button type="primary" @click="handleLogin" :loading="isLoading" style="width: 100%">登录</el-button>
        <el-form-item prop="role">
          <div class="role-buttons">
            <el-button
                :type="form.role === 'reader' ? 'primary' : 'default'"
                @click="form.role = 'reader'"
            >普通用户</el-button>
            <el-button
                :type="form.role === 'admin' ? 'primary' : 'default'"
                @click="form.role = 'admin'"
            >管理员</el-button>
          </div>
        </el-form-item>

        <div class="actions">
          <el-button type="text" @click="goRegister">注册账号</el-button>
          <el-button type="text" @click="goResetPassword">修改密码</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import request from '@/utils/request'
import { ElMessage } from 'element-plus'

const router = useRouter()


const form = reactive({ no: '', password: '',role:'' })
const isLoading = ref(false)

const rules = {
  no: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  role: [{ required: true, message: '请选择角色', trigger: 'change' }]
}

const formRef = ref()

const handleLogin = async () => {
  await formRef.value.validate()

  isLoading.value = true
  const res = await request.post('/student/login', form)
  isLoading.value = false

  if (res.code === '200' && res.data) {
    localStorage.setItem('xm-pro-user', JSON.stringify({
      name: res.data.name,
      role: res.data.role,
      avatar: res.data.avatar,
      no: res.data.no,
    }))
    ElMessage.success('登录成功')

    // 区分跳转路径
    if (res.data.role === 'admin') {
      router.push('/manager/home')
    } else {
      router.push('/manager/home')
    }

    form.no = ''
    form.password = ''
    form.role = ''
  } else {
    ElMessage.error(res.msg || '登录失败')
  }
}
const goRegister = () => {
  router.push('/Register')
}

const goResetPassword = () => {
  router.push('/reset-password')
}


</script>

<style scoped>
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

.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: linear-gradient(-45deg, #ff9a9e, #fad0c4, #fbc2eb, #a18cd1);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
  font-family: 'Comic Sans MS', 'Segoe UI', cursive, sans-serif;
}

.login-box {
  width: 420px;
  padding: 40px;
  background: #fff5f5;
  border-radius: 30px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  border: 3px solid #ffb6c1;
}

h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #ff4081;
  font-size: 24px;
  font-weight: bold;
  text-shadow: 1px 1px #fff0f0;
}

.el-form .el-input {
  border-radius: 20px;
  overflow: hidden;
}

.el-input__inner {
  background-color: #fff0f5 !important;
  border: 1px solid #ffaec9 !important;
  color: #333;
  border-radius: 20px !important;
  padding: 12px 14px;
  font-size: 15px;
  transition: 0.3s;
}

.el-input__inner:focus {
  border-color: #ff69b4 !important;
  box-shadow: 0 0 6px #ffc0cb;
}

.el-button {
  border-radius: 20px !important;
  font-weight: bold;
  font-size: 15px;
  transition: all 0.2s;
}

.el-button--primary {
  background-color: #ff80ab;
  border-color: #ff80ab;
}

.el-button--primary:hover {
  background-color: #ff4081;
  border-color: #ff4081;
}

.actions {
  display: flex;
  justify-content: space-between;
  margin-top: 15px;
}

.actions .el-button {
  font-size: 14px;
  color: #ff69b4;
}

.role-buttons {
  display: flex;
  justify-content: space-between;
  width: 100%;
  margin-top: 15px;
}

.role-buttons .el-button {
  flex: 1;
  margin: 0 6px;
  background-color: #ffe0f0;
  border: 1px solid #ffb6c1;
  color: #d63384;
}

.role-buttons .el-button:hover {
  background-color: #ffd0e6;
  color: #ad1457;
}

.role-buttons .el-button--primary {
  background-color: #ff80ab;
  color: white;
  border: none;
}

</style>
