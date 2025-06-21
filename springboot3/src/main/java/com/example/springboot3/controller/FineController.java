package com.example.springboot3.controller;

import com.example.springboot3.common.Result;
import com.example.springboot3.entity.FineRecord;
import com.example.springboot3.service.FineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/fine")
public class FineController {

    @Autowired
    private FineService fineService;

    // 获取所有罚款和赔偿记录，支持筛选
    @GetMapping("/records")
    public Result<List<FineRecord>> getFineRecords(
            @RequestParam(required = false) String no,
            @RequestParam(required = false) String title,
            @RequestParam(required = false) String type
    ) {
        System.out.println("查询参数：no=" + no + ", title=" + title + ", type=" + type);
        List<FineRecord> list = fineService.getFineRecords(no, title, type);
        System.out.println("查询结果数量：" + list.size());
        return Result.success(list);
    }


    // 缴纳罚款或赔偿
    @PostMapping("/pay")
    public Result<Void> payFine(@RequestBody IdRequest idRequest) {
        fineService.payFine(idRequest.getId());
        return Result.success();
    }

    // 新增罚款或赔偿记录，前端传入type字段区分类型
    @PostMapping("/add")
    public Result<Void> addFineRecord(@RequestBody FineRecord record) {
        fineService.addFineRecord(record);
        return Result.success();
    }

    public static class IdRequest {
        private Long id;
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
    }
}
