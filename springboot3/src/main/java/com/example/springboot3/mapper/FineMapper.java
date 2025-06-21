package com.example.springboot3.mapper;

import com.example.springboot3.entity.FineRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface FineMapper {

    /**
     * 查询罚款和赔偿记录，支持按学号、书名和类型过滤
     * @param no 学号，可空
     * @param title 书名，可空
     * @param type 类型，overdue(罚款) 或 compensation(赔偿)，可空
     * @return 记录列表
     */
    List<FineRecord> selectFineRecords(@Param("no") String no,
                                       @Param("title") String title,
                                       @Param("type") String type);

    /**
     * 标记罚款或赔偿已缴纳，更新paid和payTime
     */
    int payFineRecord(@Param("id") Long id, @Param("payTime") LocalDateTime payTime);

    int updateBorrowPayTimeIfOverdue(@Param("id") Long id, @Param("payTime") LocalDateTime payTime);



    /**
     * 新增罚款或赔偿记录
     */
    int insertFineRecord(FineRecord record);

    List<FineRecord> selectAllFineRecords(
            @Param("no") String no,
            @Param("title") String title
    );

}
