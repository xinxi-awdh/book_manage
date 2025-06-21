package com.example.springboot3.mapper;

import com.example.springboot3.entity.Message;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageMapper {

    // 分页查询留言，支持按用户id过滤，管理员传null查所有
    List<Message> selectMessages(@Param("params") Map<String, Object> params);

    // 统计留言总数
    int countMessages(@Param("params") Map<String, Object> params);

    // 添加留言
    int insertMessage(Message message);

    // 删除留言
    int deleteById(@Param("id") Long id);

    // 点赞数 +1
    int incrementLikeCount(@Param("id") Long id);

    // 点赞数 -1（取消赞时）
    int decrementLikeCount(@Param("id") Long id);

    // 回复数 +1
    int incrementReplyCount(@Param("id") Long id);

    // 插入回复（也是一条留言，但有 parent_id）
    int insertReply(Message reply);

    // 获取排序后的留言列表（支持按点赞数、回复数、时间）
    List<Message> selectSortedMessages(@Param("params") Map<String, Object> params);

    List<Message> selectReplies(Long parentId);

    Message selectById(Long id);

    List<Message> selectRepliesByParentId(Long parentId);


}
