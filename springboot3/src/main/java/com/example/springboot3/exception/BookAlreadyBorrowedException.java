// 新增文件：BookAlreadyBorrowedException.java
package com.example.springboot3.exception;

public class BookAlreadyBorrowedException extends RuntimeException {
    public BookAlreadyBorrowedException(String message) {
        super(message);
    }
}