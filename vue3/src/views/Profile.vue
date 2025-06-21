<template>
  <div class="card" style="width:600px;margin-top: 10px;margin-left: 10px;">
    <el-form class="form" ref="formRef" :rules="data.rules" :model="data.form" >
      <el-form-item  label="头像" label-width="80px" >
        <div style="width: 100%;justify-content: center;display: flex;">
          <el-upload
              class="avatar-uploader"
              action="http://localhost:9090/files/upload"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
          >
            <img v-if="data.form.avatar" :src="data.form.avatar" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </div>
      </el-form-item>
      <el-form-item  label="学号" label-width="80px" prop="no">
        <el-input v-model="data.form.no" disabled/>
      </el-form-item>
      <el-form-item label="姓名" label-width="80px" prop="name">
        <el-input v-model="data.form.name" />
      </el-form-item>
      <el-form-item label="学院" label-width="80px" prop="unit">
        <el-input v-model="data.form.unit" />
      </el-form-item>
      <el-form-item label="手机号码" label-width="80px" prop="mobile">
        <el-input v-model="data.form.mobile" />
      </el-form-item>
      <el-form-item label="修改密码">
        <div
            style="cursor: pointer; color: #409EFF;"
            @click="goToChangePassword"
        >
          去修改密码
        </div>
      </el-form-item>
      <div style="text-align: center">
        <el-button type="primary" @click="updateUser">更新个人信息</el-button>
      </div>
    </el-form>
  </div>

</template>

<script setup>

import {reactive, ref} from "vue";
import request from "@/utils/request.js"
import {ElMessage} from "element-plus";
import {Plus} from "@element-plus/icons-vue";
import { useRouter } from 'vue-router'

const formRef=ref()
const data=reactive({
  form:{},
  user:JSON.parse(localStorage.getItem("xm-pro-user")),
  rules:{
    no:[{required:true,message:'请输入学号',trigger:'blur'}],
    password:[{required:true,message:'请输入用户密码',trigger:'blur'}],
  },
})

request.get("/student/selectById/"+data.user.no).then(res=> {
  data.form = res.data;
})

const emit=defineEmits("updateUser")

const updateUser =() =>{
  formRef.value.validate((valid) => {
    if (valid) {
      request.put("/student/update", data.form).then(res => {
        if (res.code = '200') {
          ElMessage.success("更新成功");
          localStorage.setItem('xm-pro-user', JSON.stringify(data.form));
          console.log(data.form);
          emit("updateUser")
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

const handleAvatarSuccess = (res) =>
{
  console.log(res.data)
  data.form.avatar=res.data

}

const router = useRouter()
const goToChangePassword = () => {
  router.push('/reset-password')
}

</script>

<style scoped>
.card {
  width: 720px;
  margin: 20px auto;
  padding: 24px;
  border-radius: 16px;
  background: #fff;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.form {
  padding: 24px;
  background: #f9fafb;
  border-radius: 16px;
  box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.03);
}

.avatar-uploader {
  border: 2px dashed #d9d9d9;
  border-radius: 50%;
  width: 128px;
  height: 128px;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: all 0.3s;
}

.avatar-uploader:hover {
  border-color: #409EFF;
  background-color: #f0f9ff;
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
}

.el-form-item {
  margin-bottom: 20px;
}

.el-form-item__label {
  font-weight: 600;
  color: #333;
}

.el-input__wrapper, .el-input-number__wrapper {
  border-radius: 8px;
}

.el-button--primary {
  width: 200px;
  height: 48px;
  border-radius: 10px;
  font-size: 16px;
  background-image: linear-gradient(135deg, #42a5f5, #478ed1);
  border: none;
}

.el-button--primary:hover {
  background-image: linear-gradient(135deg, #5eb0f7, #639be0);
  box-shadow: 0 4px 12px rgba(66, 165, 245, 0.4);
}
</style>
<style>
.avatar-uploader-icon {
  font-size: 32px;
  color: #b0b0b0;
  transition: color 0.3s;
}

.avatar-uploader-icon:hover {
  color: #409EFF;
}

.el-upload:hover {
  border-color: #409EFF !important;
}
</style>
