import { createRouter, createWebHistory } from 'vue-router'

const routes = [
    {
        path: '/',
        redirect: '/login'
    },
    {
        path: '/manager',
        name: 'manager',
        meta: { title: '图书管理系统' },
        component: () => import('../views/ManagerView.vue'),
        children: [
            {
                path: '',
                redirect: 'home'  // 默认重定向到首页
            },
            {
                path: 'home',
                name: 'home',
                meta: { title: '系统首页' },
                component: () => import('../views/HomeView.vue')
            },
            {
                path: 'books',
                name: 'books',
                meta: { title: '图书管理' },
                component: () => import('../views/BookView.vue')
            },
            {
                path: 'borrow',
                name: 'borrow',
                meta: { title: '借阅书籍' },
                component: () => import('../views/BorrowBooks.vue')
            },
            {
                path: 'user',
                name: 'user',
                meta: { title: '用户管理' },
                component: () => import('../views/UserManagement.vue')
            },
            {
                path: 'data',
                name: 'data',
                meta: { title: '数据统计' },
                component: () => import('../views/DataView.vue')
            },
            {
                path: 'profile',  // 新增个人信息管理页面
                name: 'profile',
                meta: { title: '个人信息管理' },
                component: () => import('../views/Profile.vue')  // 确保文件路径正确
            },
            {
                path: 'borrow-record',

                name: 'BorrowRecord',
                meta: { title: '借阅记录' },
                component: () => import('../views/BorrowRecord.vue') //
            },

            {
                path: 'people',
                name: 'people',
                meta: { title: '打卡' },
                component: () => import('../views/people.vue') //
            },

            {
                path: 'borrow-admin',
                name: 'borrow-admin',
                meta: { title: '全部借阅记录' },
                component: () => import('../views/AdminBorrowRecord.vue') //
            },
            {
                path: 'fine',
                name: 'fine',
                meta: { title: '罚款缴纳' },
                component: () => import('../views/Fine.vue') //
            },
            {
                path: 'operation',
                name: 'operation',
                meta: { title: '操作日志' },
                component: () => import('../views/OperationLog.vue') //
            },
            {
                path: 'message',
                name: 'message',
                meta: { title: '留言板' },
                component: () => import('../views/Message.vue'), //
            },
            {
                path: 'message-detail/:id',
                name: 'message-detail',
                meta: { title: '留言详情' },
                component: () => import('../views/MessageDetail.vue')
            }
        ]
    },
    {
        path: '/login',
        name: 'login',
        meta: { title: '登录' },
        component: () => import('../views/LoginView.vue')
    },
    {
        path: '/register',
        name: 'register',
        meta: { title: '注册账号' },
        component: () => import('../views/Register.vue')
    },
    {
        path: '/reset-password',
        name: 'resetPassword',
        meta: { title: '修改密码' },
        component: () => import('../views/ResetPassword.vue')
    },
    // 新增404页面（放在最后）
    {
        path: '/:pathMatch(.*)*',
        name: 'not-found',
        component: () => import('../views/NotFound.vue'),
        meta: { title: '页面不存在' }
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes,
    // 新增滚动行为优化
    scrollBehavior(to, from, savedPosition) {
        // 如果存在保存的位置则恢复
        if (savedPosition) {
            return savedPosition
        }
        // 否则滚动到顶部
        return { top: 0 }
    }
})

// 添加导航守卫：设置页面标题 + 登录验证
router.beforeEach((to, from, next) => {
    const user = localStorage.getItem('xm-pro-user')

    // 设置页面标题
    document.title = to.meta.title || '图书管理系统'

    // 登录验证逻辑优化
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (!user) {
            next({
                path: '/login',
                query: { redirect: to.fullPath }
            })
        } else {
            next()
        }
    } else if (to.path === '/login' && user) {
        // 已登录用户访问登录页时重定向到首页
        next({ path: '/manager/home' })
    } else {
        next()
    }
})

export default router
