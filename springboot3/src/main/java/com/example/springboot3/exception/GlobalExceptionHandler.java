package com.example.springboot3.exception;

import com.example.springboot3.common.Result;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice("com.example.springboot3.controller")
public class GlobalExceptionHandler {

    /**
     * 处理自定义业务异常（如重复借书）
     */
    @ExceptionHandler(CustomException.class)
    @ResponseBody
    public Result handleCustomException(CustomException e) {
        e.printStackTrace();
        return Result.error(e.getCode(), e.getMsg());
    }

    /**
     * 处理数据库唯一键冲突异常（如学号重复插入）
     */
    @ExceptionHandler(DuplicateKeyException.class)
    @ResponseBody
    public Result handleDuplicateKeyException(DuplicateKeyException e) {
        e.printStackTrace();
        return Result.error("409", "数据冲突，请检查学号或书籍信息");
    }

    /**
     * 处理其他未明确捕获的异常
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result handleGeneralException(Exception e) {
        e.printStackTrace();
        return Result.error("500", "系统繁忙，请稍后重试");
    }
}