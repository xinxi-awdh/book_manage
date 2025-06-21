package com.example.springboot3.controller;

import com.example.springboot3.common.Result;
import com.example.springboot3.entity.Message;
import com.example.springboot3.service.MessageService;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/messages")
public class MessageController {

    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    /**
     * 分页查询留言
     * 参数：userNo(可选，管理员查询所有不传)，title(可选筛选书名)，page, pageSize
     */
    @GetMapping
    public Result<Map<String, Object>> getMessages(
            @RequestParam(required = false) Integer userNo,
            @RequestParam(required = false) String title,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize
    ) {
        Map<String, Object> params = new HashMap<>();
        if (userNo != null) params.put("userNo", userNo);
        if (title != null && !title.isEmpty()) params.put("title", title);
        params.put("page", page);
        params.put("pageSize", pageSize);

        List<Message> list = messageService.getMessages(params);
        int total = messageService.countMessages(params);

        Map<String, Object> data = new HashMap<>();
        data.put("list", list);
        data.put("total", total);
        return Result.success(data);
    }

    /**
     * 添加留言
     */
    @PostMapping
    public Result<Void> addMessage(@RequestBody Message message) {
        if (message.getNo() == null) {
            return Result.fail("缺少用户学号（no）");
        }
        boolean success = messageService.addMessage(message);
        return success ? Result.success() : Result.fail("添加失败");
    }

    /**
     * 删除留言（权限控制在service）
     */
    @DeleteMapping("/{id}")
    public Result<Void> deleteMessage(@PathVariable Long id,
                                      @RequestParam Integer currentUserNo,
                                      @RequestParam Boolean isAdmin) {
        boolean success = messageService.deleteMessage(id, currentUserNo, isAdmin);
        return success ? Result.success() : Result.fail("无权限删除或留言不存在");
    }
    /**
     * 点赞或取消点赞（权限控制在service）
     */
    @PostMapping("/{id}/like")
    public Result<Void> likeMessage(@PathVariable Long id, @RequestParam Integer no) {
        boolean success = messageService.likeMessage(id, no);
        return success ? Result.success() : Result.fail("点赞操作失败");
    }

    /**
     * 回复评论（权限控制在service）
     */
    @PostMapping("/{id}/reply")
    public Result<Void> replyMessage(@PathVariable Long id,
                                     @RequestBody Message reply,
                                     @RequestParam Integer userNo) {
        reply.setParentId(id);  // 设置父留言 ID
        reply.setNo(userNo);    // 回复用户的学号
        boolean success = messageService.replyMessage(reply);
        return success ? Result.success() : Result.fail("回复失败");
    }
    //排序
    @GetMapping("/sorted")
    public Result<Map<String, Object>> getSortedMessages(
            @RequestParam(required = false) String title,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(defaultValue = "time") String sortBy, // 可选：like、reply、time
            @RequestParam(defaultValue = "desc") String order,  // 可选：asc、desc
            @RequestParam(required = false) String startTime,   // 选填：起始时间
            @RequestParam(required = false) String endTime      // 选填：截止时间
    ) {
        Map<String, Object> params = new HashMap<>();
        if (title != null && !title.isEmpty()) params.put("title", title);
        if (startTime != null) params.put("startTime", startTime);
        if (endTime != null) params.put("endTime", endTime);
        params.put("page", page);
        params.put("pageSize", pageSize);
        params.put("sortBy", sortBy);
        params.put("order", order);

        List<Message> list = messageService.getSortedMessages(params);
        int total = messageService.countMessages(params);

        Map<String, Object> data = new HashMap<>();
        data.put("list", list);
        data.put("total", total);
        return Result.success(data);
    }

    @GetMapping("/{id}/detail")
    public Result<Map<String, Object>> getMessageDetail(@PathVariable Long id) {
        Message message = messageService.getById(id);
        List<Message> replies = messageService.getReplies(id);

        Map<String, Object> data = new HashMap<>();
        data.put("message", message);
        data.put("replies", replies);

        return Result.success(data);
    }




}
