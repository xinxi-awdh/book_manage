<template>
  <div class="card">
    <el-input v-model="data.input" style="width: 240px" placeholder="请输入查询的名字" />
    <el-button  type="primary" @click="load">查询</el-button>
    <el-button  type="warning" @click="reset">重置</el-button>
  </div>
  <div class="card" style="margin-top: 5px">
    <el-button  type="primary" @click="add">新增</el-button>
    <el-button  type="warning" @click="BatchDel">批量删除</el-button>
    <el-upload style="display: inline-block;margin-left: 10px;margin-right: 10px "
               action="http://localhost:9090/student/import"
               :show-file-list="false"
               :on-success="importSuccess"
    >
      <el-button  type="success">导入</el-button>
    </el-upload>
    <el-button  type="info" @click="exportData">导出</el-button>
  </div>
  <div style="margin-top: 5px">
    <el-table :data="data.tableData" stripe @selection-change="SelectChange">
      <el-table-column type="selection" width="55" />
      <el-table-column prop="no" label="学号" width="180" />
      <el-table-column prop="name" label="姓名" width="180" />
      <el-table-column label="头像">
        <template #default="scope" >
          <img :src="scope.row.avatar||img2" alt="" style="width: 40px;height: 40px;border-radius: 50%"/>
        </template>
      </el-table-column>
      <el-table-column prop="unit" label="学院" width="180" />
      <el-table-column prop="mobile" label="手机" width="180"/>
      <el-table-column prop="role" label="权限" width="180"/>
      <el-table-column label="账号状态" width="180">
        <template #default="scope">
    <span :style="{
      color: scope.row.status === '正常' ? 'green' :
             scope.row.status === '挂失' ? 'red' :
             scope.row.status === '冻结' ? 'orange' : 'black'
    }">
      {{ scope.row.status }}
    </span>
        </template>
      </el-table-column>

      <el-table-column fixed="right" label="数据操作" min-width="250">
        <template #default="scope">
          <el-button @click="edit(scope.row)" type="primary" :icon="Edit" circle />
          <el-button @click="del(scope.row)" type="danger" :icon="Delete" circle />
        </template>
      </el-table-column>
    </el-table>
    <div>
      <el-pagination
          @size-change="load"
          @current-change="load"
          v-model:current-page="data.pageNum"
          v-model:page-size="data.pageSize"
          :page-sizes="[5, 10, 15, 20]"
          background
          layout="total,sizes, prev, pager, next, jumper"
          :total="data.total"

      />
    </div>
    <el-dialog v-model="data.dialogVisible"  title="管理学生信息"  width="500" destroy-on-close>
      <el-form :model="data.form" label-width="auto" style="max-width: 600px">
        <el-form-item label="学号">
          <el-input v-model="data.form.no" />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="data.form.name" />
        </el-form-item>
        <el-form-item label="头像">
          <el-upload
              action="http://localhost:9090/files/upload"
              list-type="picture"
              :on-success="handleAvatarSuccess"
          >
            <el-button type="primary">上传头像</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="学院">
          <el-input v-model="data.form.unit" />
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="data.form.mobile" />
        </el-form-item>
        <el-form-item label="权限">
          <el-select v-model="data.form.role"placeholder="请选择权限" >
            <el-option label="user" value="user" />
            <el-option label="admin" value="admin" />
          </el-select>
        </el-form-item>
        <el-form-item label="账号状态">
          <el-select v-model="data.form.status" placeholder="请选择状态">
            <el-option label="正常" value="正常" />
            <el-option label="挂失" value="挂失" />
            <el-option label="冻结" value="冻结" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="data.dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">保存</el-button>
        </div>
      </template>
    </el-dialog>
  </div>

</template>

<script setup>
import request from "@/utils/request.js";
import {reactive} from "vue";
import {ElMessage, ElMessageBox} from "element-plus";
import {Delete, Edit} from "@element-plus/icons-vue";
import img2 from "@/assets/学生1.png"

const data= reactive({
  input:"",
  tableData:[ ],
  pageNum:1,
  pageSize:5,
  total:null,
  dialogVisible:false,
  form:{},
  ids:[]

})
const importSuccess = (res) => {
  if (res.code === '200') {
    ElMessage.success('导入数据成功')
    load()
  } else {
    ElMessage.error(res.msg)
  }
}
const load =()=>{
  request.get("/student/selectPage",{
    params:{
      pageNum:data.pageNum,
      pageSize:data.pageSize,
      name:data.input
    }
  }).then(res=>{
    console.log(res)
    data.tableData=res.data.list
    data.total=res.data.total
  })
}

const save =() =>{
  if(data.form.id){
    request.put("student/update",data.form).then(res=>{
      if(res.code==='200'){
        load()
        ElMessage.success("操作成功")
      }else{
        ElMessage.error(res.msg)
      }
    })
  }
  else{
    request.post("student/add",data.form).then(res=>{
      if(res.code==='200'){
        load()
        ElMessage.success("操作成功")
      }else{
        ElMessage.error(res.msg)
      }
    })
  }
  data.dialogVisible = false
}
const add =() =>{
  data.form= {};
  data.dialogVisible = true
}
const reset =() =>{
  data.input=null;
  load()
}

const edit =(row) =>{
  data.form=JSON.parse(JSON.stringify(row))
  data.dialogVisible = true
}

const del =(row) =>{
  ElMessageBox.confirm("删除数据后无法恢复，您确认要删除吗？","删除确认",{type:"warning"}).then(()=>{
    request.delete("student/deleteById/"+row.id).then(res=>{
      if(res.code==='200'){
        load()
        ElMessage.success("操作成功")
      }else{
        ElMessage.error(res.msg)
      }
    })
  })
}

const BatchDel =() =>{
  if(data.ids.length===0){
    ElMessage.warning("请选择数据")
    return
  }
  ElMessageBox.confirm("批量删除数据后无法恢复，您确认要删除吗？","批量删除确认",{type:"warning"}).then(()=>{
    request.delete("student/deleteBatch",{data:data.ids}).then(res=>{
      if(res.code==='200'){
        load()
        ElMessage.success("操作成功")
      }else{
        ElMessage.error(res.msg)
      }
    })
  })
}

const SelectChange =(rows) =>{
  data.ids =rows.map(row =>row.id)
  console.log(data.ids)
}
const handleAvatarSuccess = (res) => {
  data.form.avatar = res.data
}
const exportData = () => {
  // 导出数据 是通过流的形式下载 excel   打开流的链接，浏览器会自动帮我们下载文件
  window.open('http://localhost:9090/student/export')
}

load()
</script>

<style scoped>

::v-deep(.el-dialog__header) {
  text-align: center;
}

::v-deep(.el-dialog__title) {
  display: inline-block;
  font-size: 18px;
  font-weight: bold;
  color: #ff4081; /* 可根据你的主题风格调整颜色 */
}

::v-deep(.el-dialog) {
  border-radius: 20px;
  background: #fff5f5;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  border: 2px solid #ffb6c1;
}


  /* 背景和字体 */
.user-management-container {
  min-height: 100vh;
  padding: 40px 20px;
  background: linear-gradient(-45deg, #ff9a9e, #fad0c4, #fbc2eb, #a18cd1);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
  font-family: 'Comic Sans MS', 'Segoe UI', cursive, sans-serif;
  color: #4a2c3b;
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

/* 页面主体卡片 */
.user-management-card {
  background: #fff5f5;
  border-radius: 30px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  border: 3px solid #ffb6c1;
  padding: 30px 40px;
  max-width: 1200px;
  margin: 0 auto;
}

/* 标题 */
.user-management-card h2 {
  font-size: 28px;
  color: #ff4081;
  font-weight: bold;
  text-align: center;
  margin-bottom: 30px;
  text-shadow: 1px 1px #fff0f0;
}

/* 输入框样式 */
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

/* 按钮通用样式 */
.el-button {
  border-radius: 20px !important;
  font-weight: bold;
  font-size: 15px;
  transition: all 0.2s;
}

/* 主按钮 */
.el-button--primary {
  background-color: #ff80ab !important;
  border-color: #ff80ab !important;
  color: white !important;
}

.el-button--primary:hover {
  background-color: #ff4081 !important;
  border-color: #ff4081 !important;
  color: white !important;
}

/* 次按钮和文本按钮 */
.el-button--default {
  background-color: #ffe0f0 !important;
  border: 1px solid #ffb6c1 !important;
  color: #d63384 !important;
}

.el-button--default:hover {
  background-color: #ffd0e6 !important;
  color: #ad1457 !important;
}

/* 表格整体风格 */
.el-table {
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 8px 20px rgba(255, 105, 180, 0.15);
  font-weight: 600;
  font-size: 14px;
  color: #4a2c3b;
  background: #fff0f5;
}

/* 表头 */
.el-table th {
  background: #ffbad2;
  color: #7b2b50;
  font-weight: 700;
  font-size: 15px;
}

/* 鼠标悬停行背景 */
.el-table tr:hover {
  background: linear-gradient(90deg, #ffd0e6, #ffb0cf);
}

/* 表格单元格字体 */
.el-table-column .cell {
  font-weight: 600;
  color: #5c2a46;
}

/* 分页器样式 */
.el-pagination {
  color: #ad1457;
  font-weight: 600;
}

/* 弹窗风格 */
.el-dialog {
  border-radius: 30px;
  overflow: hidden;
  background: #fff5f5;
  box-shadow: 0 8px 30px rgba(255, 105, 180, 0.3);
}

.el-dialog__header {
  background: linear-gradient(90deg, #ff80ab, #ff4081);
  color: white;
  font-weight: 700;
  font-size: 20px;
  border-bottom: none;
  border-radius: 30px 30px 0 0;
}

.el-dialog__body {
  padding: 30px 40px;
  font-size: 15px;
  color: #4a2c3b;
}

/* 表单标签 */
.el-form-item__label {
  font-weight: 700;
  font-size: 14px;
  color: #ad1457;
}

/* 表单输入框容器 */
.el-form-item {
  margin-bottom: 24px;
}

/* 状态标签 */
.el-tag {
  border-radius: 15px;
  font-weight: 700;
  font-size: 13px;
}

/* 适当增加按钮间距 */
.action-buttons {
  display: flex;
  gap: 16px;
  margin-top: 20px;
  justify-content: flex-end;
}
</style>

