package com.example.springboot3.service;

import com.example.springboot3.entity.Student; // 学生实体类
import com.example.springboot3.exception.CustomException; // 自定义异常类
import com.example.springboot3.mapper.StudentMapper; // Mapper接口
import com.github.pagehelper.PageHelper; // 分页工具类
import com.github.pagehelper.PageInfo; // 分页封装类
import jakarta.annotation.Resource; // 资源注入
import org.springframework.stereotype.Service; // 业务层标识

import java.util.List;

@Service // 标记为Spring管理的Service层组件
public class StudentService {

    @Resource
    private StudentMapper studentMapper; // 注入Mapper，用于数据库交互

    /**
     * 查询所有学生，可带条件参数
     * @param student 条件参数（可为空）
     * @return 学生列表
     */
    public List<Student> selectAll(Student student) {
        return studentMapper.selectAll(student);
    }

    /**
     * 根据ID查询学生信息
     * @param id 学生ID
     * @return 学生对象
     */
    public Student selectById(Integer id) {
        return studentMapper.selectById(id);
    }

    /**
     * 分页查询学生
     * @param student 条件参数
     * @param pageNum 当前页码
     * @param pageSize 每页大小
     * @return 分页封装对象
     */
    public PageInfo<Student> selectPage(Student student, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize); // 开启分页
        List<Student> list = studentMapper.selectAll(student); // 查询数据
        return PageInfo.of(list); // 返回分页对象
    }

    /**
     * 添加学生
     * @param student 学生对象
     */
    public void add(Student student) {
        studentMapper.add(student);
    }

    /**
     * 更新学生信息
     * @param student 包含更新信息的学生对象（ID已设置）
     */
    public void update(Student student) {
        studentMapper.updateById(student);
    }

    /**
     * 根据ID删除学生
     * @param id 学生ID
     */
    public void deleteById(Integer id) {
        studentMapper.deleteById(id);
    }

    /**
     * 批量删除学生
     * @param ids 学生ID列表
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            this.deleteById(id);
        }
    }

    /**
     * 修改学生密码（用户名唯一标识）
     * @param username 用户名
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 是否成功
     */
    public boolean updatePassword(String username, String oldPassword, String newPassword) {
        Student student = studentMapper.findByNo(username); // 查找学生
        if (student == null) {
            return false; // 用户不存在
        }
        if (!student.getPassword().equals(oldPassword)) {
            return false; // 旧密码不匹配
        }
        // 更新密码，返回更新行数是否大于0
        return studentMapper.updatePassword(username, newPassword) > 0;
    }

    /**
     * 用户登录验证
     * @param student 包含用户名（no）和密码
     * @return 通过验证的学生对象
     * @throws CustomException 账号不存在或密码错误
     */
    public Student login(Student student) {
        String no = student.getNo();
        Student dbstudent = studentMapper.selectByNo(no); // 根据编号查询

        // 校验账号是否存在
        if (dbstudent == null) {
            throw new CustomException("500", "账号不存在");
        }

        String password = student.getPassword();
        // 校验密码是否正确
        if (!password.equals(dbstudent.getPassword())) {
            throw new CustomException("500", "账号或密码错误");
        }

        // 返回完整的用户信息（可能包括角色等信息）
        return dbstudent;
    }


    /**
     * ✅ 新增：更新学生状态
     */
    public boolean updateStatus(Integer id, String status) {
        return studentMapper.updateStatus(id, status) > 0;
    }




}