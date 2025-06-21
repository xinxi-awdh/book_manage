package com.example.springboot3.mapper;

import com.example.springboot3.entity.PunchRecord;
import org.apache.ibatis.annotations.*;

import java.time.LocalDateTime;

@Mapper
public interface PunchRecordMapper {

    @Insert("INSERT INTO punch_record(user_no, user_name, punch_time) VALUES(#{userNo}, #{userName}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(PunchRecord record);

    @Select("SELECT * FROM punch_record WHERE user_no = #{userNo} " +
            "AND punch_time >= #{start} AND punch_time < #{end} LIMIT 1")
    boolean existsByUserNoAndDate(
            @Param("userNo") String userNo,
            @Param("start") LocalDateTime start,
            @Param("end") LocalDateTime end);

    @Select("SELECT * FROM punch_record WHERE user_no = #{userNo} ORDER BY punch_time DESC LIMIT 1")
    @Results(id = "PunchRecordMap", value = {
            @Result(column = "id", property = "id"),
            @Result(column = "user_no", property = "userNo"),
            @Result(column = "user_name", property = "userName"),
            @Result(column = "punch_time", property = "punchTime")  // 显式映射
    })
    PunchRecord selectLastByUserNo(String userNo);



    @Select("SELECT COUNT(*) FROM punch_record " +
            "WHERE user_no = #{userNo} " +
            "AND DATE_FORMAT(punch_time, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m')")
    int getMonthPunchCount(@Param("userNo") String userNo);


}
