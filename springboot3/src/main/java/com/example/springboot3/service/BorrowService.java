package com.example.springboot3.service;

import com.example.springboot3.entity.BorrowRecord;
import com.example.springboot3.entity.BorrowRule;
import com.example.springboot3.exception.BookAlreadyBorrowedException;
import com.example.springboot3.mapper.BorrowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class BorrowService {

    @Autowired
    private BorrowMapper borrowMapper;

    private static final int RULE_ID = 1; // 默认规则主键

    // 借书操作（不含资格验证）
    @Transactional
    public void borrowBook(BorrowRecord record) {
        BorrowRecord existing = borrowMapper.findByNoAndTitleAndReturnTimeIsNull(record.getNo(), record.getTitle());
        if (existing != null) {
            throw new BookAlreadyBorrowedException("该学生已借阅此书且尚未归还");
        }
        record.setBorrowTime(LocalDateTime.now());
        borrowMapper.insertBorrowRecord(record);
    }

    // 借书前资格验证：数量、状态、规则限制等
    public String checkBorrowEligibility(BorrowRecord record) {
        BorrowRule rule = getBorrowRules();
        int currentBorrowed = countBorrowedBooksByNo(record.getNo()) - countReturnedBooksByNo(record.getNo());

        if (currentBorrowed >= rule.getMaxBooks()) {
            return "借阅失败：已达最大可借数量限制（" + rule.getMaxBooks() + "本）";
        }

        // 已借未还同书
        BorrowRecord existing = borrowMapper.findByNoAndTitleAndReturnTimeIsNull(record.getNo(), record.getTitle());
        if (existing != null) {
            return "该书已被借阅且尚未归还";
        }

        return null; // 合法
    }

    // 归还操作并计算罚款
    @Transactional
    public double returnBookAndCalculateFine(BorrowRecord record) {
        LocalDateTime now = LocalDateTime.now();
        record.setReturnTime(now);

        // 查询原记录（用于获取借阅时间）
        BorrowRecord original = borrowMapper.findByNoAndTitleAndReturnTimeIsNull(record.getNo(), record.getTitle());
        if (original == null) {
            throw new RuntimeException("未找到未归还的借阅记录");
        }

        long days = ChronoUnit.DAYS.between(original.getBorrowTime(), now);
        BorrowRule rule = getBorrowRules();

        double fine = 0;
        if (days > rule.getBorrowDays()) {
            fine = (days - rule.getBorrowDays()) * rule.getFinePerDay();
        }

        record.setFine(fine); // 假如 BorrowRecord 有 fine 字段（否则忽略）
        borrowMapper.updateReturnTime(record);
        return fine;
    }

    // 查询学生的借阅记录
    public List<BorrowRecord> getBorrowRecordByNo(String no) {
        return borrowMapper.findByNo(no);
    }

    // 查询所有借阅记录（管理员用）
    public List<BorrowRecord> getAllBorrowRecords() {
        return borrowMapper.findAll();
    }

    // 借阅统计 - 总数
    public int countBorrowedBooksByNo(String no) {
        return borrowMapper.countBorrowedBooksByNo(no);
    }

    // 借阅统计 - 已归还
    public int countReturnedBooksByNo(String no) {
        return borrowMapper.countReturnedBooksByNo(no);
    }

    // 设置借阅规则（管理员功能）
    @Transactional
    public void setBorrowRules(BorrowRule rule) {
        BorrowRule existing = borrowMapper.getBorrowRule();
        if (existing == null) {
            borrowMapper.insertBorrowRule(rule);
        } else {
            borrowMapper.updateBorrowRule(rule);
        }
    }

    // 获取当前借阅规则
    public BorrowRule getBorrowRules() {
        return borrowMapper.getBorrowRule();
    }

}
