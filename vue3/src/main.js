import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import "@/assets/global.css"


const app = createApp(App)
app.use(ElementPlus)
app.use(ElementPlus, {
    locale: zhCn,
})
app.use(router)

app.mount('#app')
