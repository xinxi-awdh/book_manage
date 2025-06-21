package com.example.springboot3.mapper;

import com.example.springboot3.entity.BorrowRecord;
import com.example.springboot3.entity.BorrowRule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface BorrowMapper {

    // 插入借阅记录
    void insertBorrowRecord(BorrowRecord record);

    // 更新归还时间和罚款
    void updateReturnTime(BorrowRecord record);

    // 查询某用户所有借阅记录
    List<BorrowRecord> findByNo(String no);

    // 查询所有借阅记录（管理员功能）
    List<BorrowRecord> findAll();

    // 根据图书ID查询当前借阅记录（判断是否被借阅中）
    BorrowRecord selectByBookId(Long bookId);

    // 查询未归还记录（用于判断是否已借）
    BorrowRecord findByNoAndTitleAndReturnTimeIsNull(@Param("no") String no, @Param("title") String title);

    // 统计总借阅数
    int countBorrowedBooksByNo(String no);

    // 统计已归还的数量
    int countReturnedBooksByNo(String no);

    // === 借阅规则 ===

    // 设置或更新借阅规则（建议只存一条，ID恒定为1）
    void updateBorrowRule(BorrowRule rule);

    // 插入规则（首次配置）
    void insertBorrowRule(BorrowRule rule);

    // 查询当前借阅规则（按ID）
    BorrowRule getBorrowRule();

    BorrowRecord selectById(@Param("id") Long id);

    int updatePayTimeById(@Param("id") Long id, @Param("payTime") LocalDateTime payTime);

}
