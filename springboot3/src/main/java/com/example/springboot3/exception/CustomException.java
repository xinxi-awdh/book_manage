package com.example.springboot3.exception;

public class CustomException extends RuntimeException {
    private String code;
    private String msg;





// 构造函数传入错误码和消息
    public CustomException(String code, String msg) {
        super(msg);  // 调用父类构造器传递消息
        this.code = code;
        this.msg = msg;
    }
    // 获取错误码
    public String getCode() {
        return code;
    }

    // 设置错误码
    public void setCode(String code) {
        this.code = code;
    }

    // 获取错误消息
    public String getMsg() {
        return msg;
    }

    // 设置错误消息
    public void setMsg(String msg) {
        this.msg = msg;
    }

    // 可选：提供给外部一个获取详细信息的方法，便于调试
    @Override
    public String toString() {
        return "CustomException{code='" + code + "', msg='" + msg + "'}";
    }

    public class BookAlreadyBorrowedException extends CustomException {
        public BookAlreadyBorrowedException() {
            super("400", "该学生已借阅此书且尚未归还");
        }
    }

}
