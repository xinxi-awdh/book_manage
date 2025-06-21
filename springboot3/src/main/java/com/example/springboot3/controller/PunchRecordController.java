package com.example.springboot3.controller;

import com.example.springboot3.common.Result; // 统一响应封装类
import com.example.springboot3.entity.PunchRecord; // 打卡记录实体类
import com.example.springboot3.service.PunchRecordService; // 业务逻辑接口
import org.springframework.beans.factory.annotation.Autowired; // 依赖注入
import org.springframework.web.bind.annotation.*; // REST请求注解

import java.text.SimpleDateFormat; // 时间格式化
import java.util.TimeZone; // 设置时区

@RestController // 定义为REST风格控制器，返回JSON
@RequestMapping("/api/punch") // 所有请求路径都以 /api/punch 开头
public class PunchRecordController {

    @Autowired
    private PunchRecordService punchRecordService; // 注入打卡服务

    /**
     * 打卡接口
     * POST /api/punch
     * 通过请求参数传递用户编号和姓名
     */
    @PostMapping
    public Result punch(@RequestParam String userNo, @RequestParam String userName) {
        System.out.println("[DEBUG] 收到打卡请求 - userNo: " + userNo + ", userName: " + userName); // 调试信息
        try {
            // 调用服务进行打卡
            punchRecordService.punch(userNo, userName);
            return Result.success("打卡成功"); // 返回成功消息
        } catch (Exception e) {
            e.printStackTrace(); // 打印异常堆栈
            // 出现异常，返回打卡失败信息（这里还是返回成功的结果类型，但内容提示失败）
            return Result.success("打卡失败: " + e.getMessage());
        }
    }

    /**
     * 查询当天是否已打卡
     * GET /api/punch/check?userNo=xxx
     */
    @GetMapping("/check")
    public Result checkPunchStatus(@RequestParam String userNo) {
        try {
            // 判断用户今天是否已打卡
            boolean hasPunched = punchRecordService.hasPunchedToday(userNo);
            // 获取最新的打卡记录
            PunchRecord lastRecord = punchRecordService.getLastPunch(userNo);

            if (hasPunched && lastRecord != null && lastRecord.getPunchTime() != null) {
                // 格式化时间（UTC时区）
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
                String formattedTime = sdf.format(lastRecord.getPunchTime());

                // 返回"已打卡"状态及时间
                return Result.success("今日已打卡，时间：" + formattedTime);
            } else {
                // 未打卡
                return Result.success("今日未打卡");
            }
        } catch (Exception e) {
            // 异常处理
            return Result.error("查询失败");
        }
    }


}