package com.example.springboot3.entity;

public class BorrowRule {
    private Integer id;           // 规则ID（通常为1）
    private Integer maxBooks;     // 最大借书数
    private Integer borrowDays;   // 借阅期限（天）
    private Integer maxRenewals;  // 最大续借次数
    private Integer renewalDays;  // 每次续借天数
    private Double finePerDay;    // 超期罚金（每本每天）

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMaxBooks() {
        return maxBooks;
    }

    public void setMaxBooks(Integer maxBooks) {
        this.maxBooks = maxBooks;
    }

    public Integer getBorrowDays() {
        return borrowDays;
    }

    public void setBorrowDays(Integer borrowDays) {
        this.borrowDays = borrowDays;
    }

    public Integer getMaxRenewals() {
        return maxRenewals;
    }

    public void setMaxRenewals(Integer maxRenewals) {
        this.maxRenewals = maxRenewals;
    }

    public Integer getRenewalDays() {
        return renewalDays;
    }

    public void setRenewalDays(Integer renewalDays) {
        this.renewalDays = renewalDays;
    }

    public Double getFinePerDay() {
        return finePerDay;
    }

    public void setFinePerDay(Double finePerDay) {
        this.finePerDay = finePerDay;
    }
}
