package com.example.springboot3.ServiceImpl;

import com.example.springboot3.entity.Message;
import com.example.springboot3.mapper.MessageMapper;
import com.example.springboot3.service.MessageService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MessageServiceImpl implements MessageService {

    private final MessageMapper mapper;

    public MessageServiceImpl(MessageMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public List<Message> getMessages(Map<String, Object> params) {
        return mapper.selectMessages(params);
    }

    @Override
    public int countMessages(Map<String, Object> params) {
        return mapper.countMessages(params);
    }

    @Override
    public boolean addMessage(Message message) {
        return mapper.insertMessage(message) > 0;
    }

    /**
     * 删除留言规则：
     * - 管理员可以删除所有留言
     * - 普通用户只能删除自己的留言
     */
    @Override
    public boolean deleteMessage(Long id, Integer currentUserNo, boolean isAdmin) {
        if (isAdmin) {
            return mapper.deleteById(id) > 0;
        } else {
            // 先查留言所属用户no
            Message msg = mapper.selectMessages(Map.of("id", id)).stream().findFirst().orElse(null);
            if (msg != null && msg.getNo() != null && msg.getNo().equals(currentUserNo)) {
                return mapper.deleteById(id) > 0;
            }
            return false;
        }
    }
    @Override
    public boolean likeMessage(Long messageId, Integer userNo) {
        // 如果你有防重复点赞的表，可加校验逻辑
        return mapper.incrementLikeCount(messageId) > 0;
    }
    @Override
    public boolean replyMessage(Message reply) {
        // 插入 reply（parentId 不能为空）
        boolean inserted = mapper.insertReply(reply) > 0;
        if (inserted && reply.getParentId() != null) {
            // 父留言回复数 +1
            mapper.incrementReplyCount(reply.getParentId());
        }
        return inserted;
    }
    @Override
    public List<Message> getSortedMessages(Map<String, Object> params) {
        return mapper.selectSortedMessages(params);
    }



    @Override
    public Message getById(Long id) {
        return mapper.selectById(id);
    }

    @Override
    public List<Message> getReplies(Long parentId) {
        return mapper.selectRepliesByParentId(parentId);
    }






}
