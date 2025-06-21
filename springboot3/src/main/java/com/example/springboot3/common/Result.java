package com.example.springboot3.common;

public class Result<T> {

    private String code;
    private String msg;
    private T data;

    // 构造函数
    public Result(String code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static Result error(String s) {
        return error();
    }

    // Getters 和 Setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    // 静态方法：成功的响应，不带数据
    public static <T> Result<T> success() {
        return new Result<>("200", "操作成功", null);
    }

    // 静态方法：成功的响应，带数据
    public static <T> Result<T> success(T data) {
        return new Result<>("200", "操作成功", data);
    }

    // 静态方法：失败的响应，不带数据
    public static <T> Result<T> error() {
        return new Result<>("500", "操作失败", null);
    }

    // 静态方法：失败的响应，带自定义错误信息
    public static <T> Result<T> error(String code, String msg) {
        return new Result<>(code, msg, null);
    }

    // fail 的别名方法，常用于返回失败结果
    public static <T> Result<T> fail(String msg) {
        return new Result<>("500", msg, null);
    }

    public static <T> Result<T> fail(String code, String msg) {
        return new Result<>(code, msg, null);
    }




}
