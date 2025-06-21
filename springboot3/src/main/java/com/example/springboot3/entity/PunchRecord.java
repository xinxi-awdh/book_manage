package com.example.springboot3.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class PunchRecord {
    private Integer id;
    private String userNo;
    private String userName;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date punchTime; // ✅ 字段放在前面，注解生效


    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUserNo() { return userNo; }
    public void setUserNo(String userNo) { this.userNo = userNo; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public Date getPunchTime() {
        return punchTime;
    }

    public void setPunchTime(Date punchTime) {
        this.punchTime = punchTime;
    }
}
