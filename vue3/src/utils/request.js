import axios from 'axios';
import {ElMessage} from 'element-plus'

const request= axios.create({
    baseURL: 'http://localhost:9090',
    timeout: 30000, // 30秒超时
    headers: {
        'Content-Type': 'application/json;charset=utf-8',
    },
});

//request拦截器
//可以自请求发送前对请求做一些处理
request.interceptors.request.use(config => {
        config.headers['Content-Type']='application/json;charset=utf-8'
        return config;
    },
    error => {
        return Promise.reject(error);
    }
);

// response拦截器,
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    // onFulfilled: 当请求成功时执行的函数
    response => {
        let res = response.data;
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res;
        }
        return res;
    },
    // onRejected: 当请求失败时执行的函数
    error => {
        if (error.response && error.response.status === 404) {
            // 使用ElMessage显示错误信息（这里假设ElMessage是一个UI库中的错误提示组件）
            ElMessage.error({ message: '未找到请求接口' });
        } else if (error.response && error.response.status === 500) {
            // 注意：原文本中的“=s= Soo”应为“=== 500”的误写
            ElMessage.error({ message: '系统异常，请查看后端控制台报错' });
        } else {
            console.error(error.message);
        }
        return Promise.reject(error);
    }

);

export default request