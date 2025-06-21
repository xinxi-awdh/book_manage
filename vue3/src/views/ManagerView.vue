<template>
  <div class="layout">
    <!-- 侧边导航栏 -->
    <aside class="sidebar">
      <div class="logo">
        <img :src="logo" alt="Logo" />
        <span>图书管理系统</span>
      </div>
      <el-menu
          :default-active="$route.path"
          router
          class="el-menu-vertical-demo"
          background-color="#E8E8E8"
          text-color="#000"
          active-text-color="#409EFF"
          unique-opened
      >
        <el-menu-item index="/manager/home">
          <el-icon><House /></el-icon>
          <span>系统首页</span>
        </el-menu-item>
        <el-menu-item index="/manager/borrow">
          <el-icon><Reading /></el-icon>
          <span>借阅书籍</span>
        </el-menu-item>
        <el-menu-item index="/manager/borrow-record">
          <el-icon><Reading /></el-icon>
          <span>借阅记录</span>
        </el-menu-item>
        <el-menu-item v-if="user.role === 'admin'" index="/manager/books">
          <el-icon><User /></el-icon>
          <span>图书管理</span>
        </el-menu-item>
        <el-menu-item v-if="user.role === 'admin'" index="/manager/borrow-admin">
          <el-icon><User /></el-icon>
          <span>借阅管理</span>
        </el-menu-item>
        <el-menu-item v-if="user.role === 'admin'" index="/manager/user">
          <el-icon><User /></el-icon>
          <span>用户管理</span>
        </el-menu-item>
        <el-menu-item index="/manager/data">
          <el-icon><DataAnalysis /></el-icon>
          <span>数据统计</span>
        </el-menu-item>
        <el-menu-item v-if="user.role === 'admin' " index="/manager/operation">
          <el-icon><Reading /></el-icon>
          <span>操作日志</span>
        </el-menu-item>
        <el-menu-item index="/manager/fine">
          <el-icon><DataAnalysis /></el-icon>
          <span>罚款缴纳</span>
        </el-menu-item>
        <el-menu-item index="/manager/profile">
          <el-icon><Reading /></el-icon>
          <span>个人信息管理</span>
        </el-menu-item>
        <el-menu-item index="/manager/people">
          <el-icon><Reading /></el-icon>
          <span>学习打卡</span>
        </el-menu-item>
        <el-menu-item index="/manager/message">
          <el-icon><Reading /></el-icon>
          <span>留言板</span>
        </el-menu-item>
        <el-menu-item @click="logout">
          <el-icon><SwitchButton /></el-icon>
          <span>退出登录</span>
        </el-menu-item>
      </el-menu>

      <div class="user-info">
        <img :src="user.avatar || defaultAvatar" alt="Avatar" />
        <span>{{ user.username }}</span>
      </div>
    </aside>

    <!-- 主体内容区 -->
    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import {
  House,
  Reading,
  DataAnalysis,
  SwitchButton,
  User
} from '@element-plus/icons-vue'
import logo from '@/assets/xiaohui.png'
import defaultAvatar from '@/assets/xiaohui.png'

const storedUser = JSON.parse(localStorage.getItem('xm-pro-user') || '{}')
const user = reactive({
  username: storedUser.name || '未登录',
  role: storedUser.role || '',
  avatar: storedUser.avatar || defaultAvatar
})

const logout = () => {
  localStorage.removeItem('xm-pro-user')
  localStorage.removeItem('punchStatus')
  window.location.href = '/login'
}
</script>

<style scoped>
.layout {
  display: flex;
  height: 100vh;
  background-color: #f0f0f0;
}

/* 侧边栏样式 */
.sidebar {
  width: 220px;
  background-color: #E8E8E8;
  display: flex;
  flex-direction: column;
  padding: 20px;
  box-sizing: border-box;
  border-right: 1px solid #ddd;
}

/* logo 区域 */
.logo {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 30px;
  font-size: 20px;
  color: black;
}

.logo img {
  width: 40px;
  height: 40px;
}

/* 用户信息 */
.user-info {
  margin-top: auto;
  display: flex;
  align-items: center;
  gap: 10px;
  color: black;
}

.user-info img {
  width: 36px;
  height: 36px;
  border-radius: 50%;
}

/* 主内容区 */
.main-content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

/* 调整菜单字体颜色 */
.el-menu-vertical-demo {
  border-right: none;
}

.el-menu-vertical-demo .el-menu-item {
  color: #000 !important;
  border-radius: 8px;
}

.el-menu-vertical-demo .el-menu-item.is-active {
  background-color: #409EFF !important;
  color: white !important;
}
</style>