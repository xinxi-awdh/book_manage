package com.example.springboot3.controller;

import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.example.springboot3.common.Result;
import com.example.springboot3.entity.Student;
import com.example.springboot3.service.StudentService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController // 标识这是个Rest控制器
@RequestMapping("/student") // 所有请求路径以 /student 开头
public class StudentController {
    @Resource
    private StudentService studentService; // 注入学生业务层

    /**
     * 查询所有学生信息
     * URL: http://localhost:9090/student/selectAll
     * 可带参数no
     */
    @GetMapping("/selectAll")
    public Result selectAll(Student student) {
        List<Student> list = studentService.selectAll(student);
        return Result.success(list);
    }

    /**
     * 按ID查询学生
     * URL: http://localhost:9090/student/selectById/1
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Student student = studentService.selectById(id);
        return Result.success(student);
    }

    /**
     * 根据用户ID查询学生
     * URL: http://localhost:9090/student/selectByUId?id=1
     */
    @GetMapping("/selectByUId")
    public Result selectByUId(@RequestParam Integer id) {
        Student student = studentService.selectById(id);
        return Result.success(student);
    }

    /**
     * 支持分页查询学生信息
     * URL: http://localhost:9090/student/selectPage?pageNum=1&pageSize=5
     */
    @GetMapping("/selectPage")
    public Result selectPage(Student student,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "5") Integer pageSize) {
        // 调用分页查询
        PageInfo<Student> pageInfo = studentService.selectPage(student, pageNum, pageSize);
        return Result.success(pageInfo);
    }

    /**
     * 添加学生信息
     * POST /student/add
     */
    @PostMapping("/add")
    public Result add(@RequestBody Student student) {
        studentService.add(student);
        return Result.success();
    }

    /**
     * 更新学生信息
     * PUT /student/update
     */
    @PutMapping("/update")
    public Result update(@RequestBody Student student) {
        studentService.update(student);
        return Result.success();
    }

    /**
     * 根据ID删除学生
     * DELETE /student/deleteById/{id}
     */
    @DeleteMapping("deleteById/{id}")
    public Result deleteById(@PathVariable Integer id) {
        studentService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除学生
     * POST请求体为ID列表
     */
    @DeleteMapping("deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        studentService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改密码
     * PUT /student/updatePassword
     */
    @PutMapping("/updatePassword")
    public ResponseEntity<Map<String, Object>> updatePassword(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String oldPassword = params.get("oldPassword");
        String newPassword = params.get("newPassword");

        Map<String, Object> response = new HashMap<>();

        // 校验参数是否为空
        if (username == null || oldPassword == null || newPassword == null) {
            response.put("code", "400");
            response.put("message", "参数不能为空");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }

        try {
            boolean success = studentService.updatePassword(username, oldPassword, newPassword);
            if (success) {
                response.put("code", "200");
                response.put("message", "密码修改成功");
                return new ResponseEntity<>(response, HttpStatus.OK);
            } else {
                response.put("code", "401");
                response.put("message", "用户名或原密码错误");
                return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
            }
        } catch (Exception e) {
            response.put("code", "500");
            response.put("message", "服务器错误");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 登录接口
     * POST /student/login
     */
    @PostMapping("/login")
    public Result login(@RequestBody Student student) {
        Student res = studentService.login(student);
        if (res != null) {
            // 登录成功，返回用户信息
            System.out.println(res);
            return Result.success(res);
        }
        // 登录失败
        return Result.error("登录失败", null);
    }

    /**
     * 导出学生数据为Excel文件
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 获取所有学生数据
        List<Student> students = studentService.selectAll(null);

        // 创建Excel写入对象
        ExcelWriter writer = ExcelUtil.getWriter(true);

        // 设置Excel表头别名（字段中文名）
        writer.addHeaderAlias("no", "学号");
        writer.addHeaderAlias("name", "姓名");
        writer.addHeaderAlias("unit", "学院");
        writer.addHeaderAlias("mobile", "手机号码");


        // 只输出有别名的字段
        writer.setOnlyAlias(true);

        // 写数据到Excel
        writer.write(students, true);

        // 设置响应内容类型和文件名（支持中文）
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("学生信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        // 获取输出流并写出Excel
        ServletOutputStream os = response.getOutputStream();
        writer.flush(os);
        // 关闭Excel写入对象
        writer.close();
    }

    @PutMapping("/updateStatus")
    public Result updateStatus(@RequestBody Map<String, Object> params) {
        Integer id = (Integer) params.get("id");
        String status = (String) params.get("status");

        if (id == null || status == null) {
            return Result.error("参数缺失");
        }

        boolean success = studentService.updateStatus(id, status);
        return success ? Result.success("状态更新成功") : Result.error("状态更新失败");
    }

}