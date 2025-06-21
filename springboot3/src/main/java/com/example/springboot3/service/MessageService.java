package com.example.springboot3.service;

import com.example.springboot3.entity.Message;

import java.util.List;
import java.util.Map;

public interface MessageService {

    // 分页查询留言
    List<Message> getMessages(Map<String, Object> params);

    // 查询留言总数
    int countMessages(Map<String, Object> params);

    // 添加留言
    boolean addMessage(Message message);

    // 删除留言（支持管理员或本人）
    boolean deleteMessage(Long id, Integer currentUserNo, boolean isAdmin);

    // 点赞留言（可设计为自动点赞/取消点赞切换）
    boolean likeMessage(Long messageId, Integer userNo);

    // 添加回复
    boolean replyMessage(Message reply);

    // 获取排序后的留言
    List<Message> getSortedMessages(Map<String, Object> params);


    List<Message> getReplies(Long parentId);

    Message getById(Long id);
}
