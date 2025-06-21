package com.example.springboot3.controller;

import com.example.springboot3.common.Result;
import com.example.springboot3.entity.OperationLog;
import com.example.springboot3.service.OperationLogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/logs")
public class OperationLogController {

    private final OperationLogService logService;

    public OperationLogController(OperationLogService logService) {
        this.logService = logService;
    }

    @GetMapping
    public Result<PageInfo<OperationLog>> getLogs(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String operation,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize
    ) {
        Map<String, Object> filter = new HashMap<>();
        filter.put("username", name);
        filter.put("operation", operation);
        filter.put("startTime", startTime);
        filter.put("endTime", endTime);
        filter.put("excludeAnonymous", true); // 新增排除条件

        PageHelper.startPage(pageNum, pageSize);
        List<OperationLog> logs = logService.getLogs(filter);
        PageInfo<OperationLog> pageInfo = new PageInfo<>(logs);
        return Result.success(pageInfo);
    }
}
