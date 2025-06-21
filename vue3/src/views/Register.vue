<template>
  <div class="login-container">
    <div class="login-box">
      <h2>🎀 用户注册</h2>
      <el-form :model="form" :rules="rules" ref="formRef" label-position="top">
        <el-form-item prop="no">
          <el-input v-model="form.no" placeholder="学号" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" type="password" placeholder="密码" />
        </el-form-item>
        <el-form-item prop="name">
          <el-input v-model="form.name" placeholder="姓名" />
        </el-form-item>
        <el-form-item prop="unit">
          <el-input v-model="form.unit" placeholder="学院" />
        </el-form-item>
        <el-form-item prop="mobile">
          <el-input v-model="form.mobile" placeholder="手机号码" />
        </el-form-item>

        <el-button type="primary" @click="handleRegister" :loading="isLoading" style="width: 100%; margin-top: 20px;">
          注册
        </el-button>

        <div class="actions">
          <el-button type="text" @click="goLogin">已有账号？点我登录</el-button>
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
const formRef = ref()
const isLoading = ref(false)

const form = reactive({
  no: '',
  password: '',
  name: '',
  unit: '',
  mobile: ''
})

const rules = {
  no:      [{ required: true, message: '请输入学号', trigger: 'blur' }],
  password:[{ required: true, message: '请输入密码', trigger: 'blur' }],
  name:    [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  unit:    [{ required: true, message: '请输入学院', trigger: 'blur' }],
  mobile:  [{ required: true, message: '请输入手机号码', trigger: 'blur' }]
}

const handleRegister = () => {
  formRef.value.validate(async valid => {
    if (!valid) return
    isLoading.value = true
    try {
      const res = await request.post('/student/add', { ...form, role: 'user' })
      if (res.code === '200') {
        ElMessage.success('注册成功，请登录')
        router.push('/login')
      } else {
        ElMessage.error(res.message || '注册失败')
      }
    } catch {
      ElMessage.error('网络错误，请稍后再试')
    } finally {
      isLoading.value = false
    }
  })
}

const goLogin = () => {
  router.push('/login')
}
</script>

<style scoped>
@keyframes gradient {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
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
  padding: 40px 30px;
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
  justify-content: center;
  margin-top: 20px;
}

.actions .el-button {
  color: #ff69b4;
  font-size: 14px;
}
</style>
