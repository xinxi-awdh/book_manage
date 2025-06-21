package com.example.springboot3.service;

import com.example.springboot3.entity.BorrowRecord;
import com.example.springboot3.entity.FineRecord;
import com.example.springboot3.mapper.BorrowMapper;
import com.example.springboot3.mapper.FineMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import java.math.BigDecimal;

@Service
public class FineService {

    @Autowired
    private FineMapper fineMapper;

    @Autowired
    private BorrowMapper borrowMapper;




    /**
     * 缴纳罚款或赔偿，更新paid和payTime
     */
    @Transactional
    public void payFine(Long id) {
        LocalDateTime now = LocalDateTime.now();

        if (id >= 1000000) {
            // 说明是从 borrow_record 拼出来的虚拟 overdue 记录
            Long borrowId = id - 1000000;

            // 查出原始 borrow_record 信息
            BorrowRecord borrow = borrowMapper.selectById(borrowId); // 你需要实现这个方法

            if (borrow != null) {
                // 插入到 fine_record 中
                FineRecord fine = new FineRecord();
                fine.setNo(borrow.getNo());
                fine.setTitle(borrow.getTitle());
                fine.setBorrowTime(borrow.getBorrowTime());
                fine.setReturnTime(borrow.getReturnTime());
                fine.setType("overdue");
                fine.setAmount(BigDecimal.valueOf(borrow.getFine())); // ✅ 类型转换
                fine.setPaid(true);
                fine.setPayTime(now);
                fine.setDescription("超期罚款");

                fineMapper.insertFineRecord(fine);
            }

            // 更新 borrow_record 的 pay_time 字段
            borrowMapper.updatePayTimeById(borrowId, now); // 你需要实现这个方法
        } else {
            // 正常 fine_record 表内的记录
            fineMapper.payFineRecord(id, now);
            fineMapper.updateBorrowPayTimeIfOverdue(id, now);
        }
    }



    /**
     * 新增罚款或赔偿记录，需传type字段
     */
    @Transactional
    public void addFineRecord(FineRecord record) {
        record.setCreatedTime(LocalDateTime.now());
        fineMapper.insertFineRecord(record);
    }

    public List<FineRecord> getFineRecords(String no, String title, String type) {
        if ("overdue".equalsIgnoreCase(type)) {
            return fineMapper.selectFineRecords(no, title, "overdue");
        } else if ("compensation".equalsIgnoreCase(type)) {
            return fineMapper.selectFineRecords(no, title, "compensation");
        } else {
            // 这里要调用联合查询方法
            return fineMapper.selectAllFineRecords(no, title);
        }
    }



}
