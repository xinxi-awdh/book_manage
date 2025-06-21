package com.example.springboot3.controller;

import com.example.springboot3.common.Result;
import com.example.springboot3.entity.BorrowRecord;
import com.example.springboot3.entity.BorrowRule;
import com.example.springboot3.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/book")
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    /**
     * 借书接口（通过用户ID与图书条码/ID借书）
     */
    @PostMapping("/borrow")
    public Result borrowBook(@RequestBody BorrowRecord record) {
        if ("anonymousUser".equals(record.getNo())) {
            return Result.error("403", "用户未登录，无法借书");
        }

        // 验证借阅资格与图书状态
        String checkResult = borrowService.checkBorrowEligibility(record);
        if (checkResult != null) {
            return Result.error("403", checkResult);
        }

        // 借书处理
        borrowService.borrowBook(record);
        return Result.success("借阅成功");
    }

    /**
     * 还书接口（判断是否超期并计算罚款）
     */
    @PostMapping("/return")
    public Result returnBook(@RequestBody BorrowRecord record) {
        // 自动判断是否超期并计算罚款
        double fine = borrowService.returnBookAndCalculateFine(record);
        return Result.success(Map.of(
                "message", "归还成功",
                "fine", fine
        ));
    }

    /**
     * 借阅记录查询接口
     * - 读者传入 No 参数查询自己的
     * - 管理员传入 admin=true 查询所有记录
     */

    @GetMapping("/record")
    public Result getBorrowRecords(@RequestParam(required = false) String No) {
        if (No == null || No.isEmpty()) {
            return Result.error("400", "缺少学号参数");
        }

        List<BorrowRecord> records = borrowService.getBorrowRecordByNo(No);

        if (!records.isEmpty()) {
            return Result.success(records);
        } else {
            return Result.error("404", "借阅记录未找到");
        }
    }


    /**
     * 借阅统计信息（读者端用）
     */
    @GetMapping("/count")
    public Result getBorrowCounts(@RequestParam String No) {
        try {
            int totalBorrowed = borrowService.countBorrowedBooksByNo(No);
            int returned = borrowService.countReturnedBooksByNo(No);
            int unreturned = totalBorrowed - returned;

            return Result.success(Map.of(
                    "totalBorrowed", totalBorrowed,
                    "returned", returned,
                    "unreturned", unreturned
            ));
        } catch (Exception e) {
            return Result.error("500", "统计数据失败: " + e.getMessage());
        }
    }

    /**
     * 借阅规则设置（管理员功能）
     */
    @PostMapping("/rule")
    public Result setBorrowRules(@RequestBody BorrowRule rule) {
        borrowService.setBorrowRules(rule);
        return Result.success("借阅规则设置成功");
    }

    /**
     * 获取当前借阅规则
     */
    @GetMapping("/rule")
    public Result getBorrowRules() {
        BorrowRule rule = borrowService.getBorrowRules();
        return Result.success(rule);
    }
}
