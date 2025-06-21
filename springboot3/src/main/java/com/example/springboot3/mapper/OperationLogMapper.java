package com.example.springboot3.mapper;

import com.example.springboot3.entity.OperationLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OperationLogMapper {
    void insert(OperationLog log);
    List<OperationLog> selectByFilter(Map<String, Object> filter);
}
