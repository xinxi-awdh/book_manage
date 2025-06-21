<template>
  <div class="reset-container">
    <div class="reset-box">
      <h2>修改密码</h2>
      <el-form :model="form" :rules="rules" ref="formRef">
        <el-form-item prop="username">
          <el-input v-model="form.username" placeholder="账号" />
        </el-form-item>
        <el-form-item prop="oldPassword">
          <el-input v-model="form.oldPassword" type="password" placeholder="原密码" />
        </el-form-item>
        <el-form-item prop="newPassword">
          <el-input v-model="form.newPassword" type="password" placeholder="新密码" />
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input v-model="form.confirmPassword" type="password" placeholder="确认新密码" />
        </el-form-item>
        <el-button type="primary" @click="handleReset" class="reset-button">确认修改</el-button>
        <el-button type="text" @click="router.push('/login')" class="login-button">返回登录</el-button>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import request from '@/utils/request'
import { ElMessage, ElMessageBox } from 'element-plus'

const router = useRouter()
const formRef = ref()
const form = reactive({
  username: '',
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const rules = {
  username: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  oldPassword: [{ required: true, message: '请输入原密码', trigger: 'blur' }],
  newPassword: [{ required: true, message: '请输入新密码', trigger: 'blur' }],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    {
      validator: (_, value) => {
        return value === form.newPassword ? true : new Error('两次密码不一致')
      },
      trigger: 'blur'
    }
  ]
}

const handleReset = async () => {
  try {
    // 进行表单验证
    const isValid = await new Promise(resolve => {
      formRef.value.validate(valid => resolve(valid));
    });

    // 如果验证不通过，直接返回
    if (!isValid) return;

    // 发送密码更新请求
    const res = await request.put('/student/updatePassword', {
      username: form.username,
      oldPassword: form.oldPassword,
      newPassword: form.newPassword
    });

    // 处理请求结果
    if (res.code === '200') {
      ElMessageBox.confirm('密码修改成功，请重新登录', '成功', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'success'
      }).then(() => {
        router.push('/login');
      });
    } else {
      ElMessage.error(res.message || '密码修改失败');
    }
  } catch (error) {
    // 错误处理
    ElMessage.error(error.message || '密码修改失败');
  }
};

</script>

<style scoped>
.reset-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: linear-gradient(135deg, #3a8ee6, #70c1ff);
}

.reset-box {
  width: 400px;
  padding: 40px 30px;
  background-color: #ffffffee;
  border-radius: 16px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #333;
  font-size: 24px;
  font-weight: bold;
}

.reset-button {
  width: 100%;
  margin-top: 20px;
}

.login-button {
  width: 100%;
  margin-top: 10px;
  color: #70c1ff;
  font-weight: bold;
}
</style>
