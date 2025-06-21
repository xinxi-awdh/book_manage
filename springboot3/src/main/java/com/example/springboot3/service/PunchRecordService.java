package com.example.springboot3.service;

import com.example.springboot3.entity.PunchRecord; // 打卡记录实体类
import com.example.springboot3.mapper.PunchRecordMapper; // Mapper接口，用于数据库操作
import org.springframework.beans.factory.annotation.Autowired; // 依赖注入
import org.springframework.stereotype.Service; // 声明这是一个业务层组件

import java.time.LocalDate; // 日期类

@Service // 识别为服务层Bean
public class PunchRecordService {
    @Autowired
    private PunchRecordMapper punchRecordMapper; // 注入Mapper对象

    /**
     * 进行打卡操作
     * @param userNo 用户编号
     * @param userName 用户姓名
     *
     * 逻辑：
     * - 创建PunchRecord对象，设置用户编号和姓名
     * - 调用Mapper插入打卡记录（插入该次打卡信息，存时间等由数据库自动处理或在Mapper中设置）
     */
    public void punch(String userNo, String userName) {
        PunchRecord record = new PunchRecord();
        record.setUserNo(userNo);
        record.setUserName(userName);
        punchRecordMapper.insert(record);
    }

    /**
     * 判断用户今天是否已打卡
     * @param userNo 用户编号
     * @return true：已打卡；false：未打卡
     *
     * 逻辑：
     * - 获取当前日期的开始（00:00:00）
     * - 比较数据库中是否存在该用户当天（时间范围）已打卡的记录
     */
    public boolean hasPunchedToday(String userNo) {
        LocalDate today = LocalDate.now(); // 获取今天的日期
        return punchRecordMapper.existsByUserNoAndDate(
                userNo,
                today.atStartOfDay(), // 今天的起点时间
                today.plusDays(1).atStartOfDay() // 明天的起点时间（提前一天+今天的起点）
        );
    }

    /**
     * 获取用户最近一次的打卡记录
     * @param userNo 用户编号
     * @return 最新的打卡记录
     */
    public PunchRecord getLastPunch(String userNo) {
        return punchRecordMapper.selectLastByUserNo(userNo);
    }

    /**
     * 获取用户本月的打卡天数
     * @param userNo 用户编号
     * @return 本月打卡天数
     */
    public int getMonthPunchCount(String userNo) {
        return punchRecordMapper.getMonthPunchCount(userNo);
    }
}