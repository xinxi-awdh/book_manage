package com.example.springboot3.ServiceImpl;

import com.example.springboot3.entity.OperationLog;
import com.example.springboot3.mapper.OperationLogMapper;
import com.example.springboot3.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class OperationLogServiceImpl implements OperationLogService {

    @Autowired
    private OperationLogMapper logMapper;

    @Override
    public void save(OperationLog log) {
        logMapper.insert(log);
    }

    @Override
    public List<OperationLog> getLogs(Map<String, Object> filter) {
        return logMapper.selectByFilter(filter);
    }
}

