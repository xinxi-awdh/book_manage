# 图书管理系统

本项目为毕业设计——基于 Vue 和 Node.js 的图书管理系统。实现了图书的增删改查、借阅管理、用户管理等功能，适用于图书馆、学校等场景。

## 功能简介

- 用户注册与登录
- 图书信息管理（增删改查）
- 图书借阅与归还
- 借阅历史查询
- 用户权限管理（普通用户/管理员）
- 数据统计与报表

## 技术栈

- 前端：Vue.js、Element UI
- 后端：Node.js、Express
- 数据库：MySQL

## 项目结构

```
project/
├── backend/         # 后端代码（Node.js/Express）
├── frontend/        # 前端代码（Vue.js）
├── README.md
└── ...
```

## 部署与运行

### 1. 克隆项目

```bash
git clone git@github.com:xinxi-awdh/book_manage.git
cd book_manage
```

### 2. 启动后端

```bash
cd backend
npm install
npm run start
```

### 3. 启动前端

```bash
cd ../frontend
npm install
npm run serve
```

### 4. 访问系统

浏览器访问：`http://localhost:8080`

## 数据库初始化

请参考 `backend/db/README.md` 或相关 SQL 文件，导入初始数据表。

## 贡献说明

欢迎提交 issue 和 pull request！

## License

MIT
