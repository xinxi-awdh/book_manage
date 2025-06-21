package com.example.springboot3.service;

import com.example.springboot3.entity.OperationLog;
import java.util.List;
import java.util.Map;

public interface OperationLogService {
    void save(OperationLog log);
    List<OperationLog> getLogs(Map<String, Object> filter);
}

