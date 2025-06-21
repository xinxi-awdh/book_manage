package com.example.springboot3.mapper;

import com.example.springboot3.entity.Student;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface StudentMapper {

    List<Student> selectAll(Student student);

    @Select("select * from student where no=#{no}")
    Student selectById(Integer no);



    void add(Student student);

    void updateById(Student student);


    @Delete("delete from student where id=#{id}")
    void deleteById(Integer id);

    // 根据学号查询学生
    @Select("select * from student where no=#{no}")
    Student selectByNo(String no);

    Student findByNo(@Param("no") String no);

    int updatePassword(@Param("no") String no, @Param("password") String password);

    int updateStatus(@Param("id") Integer id, @Param("status") String status);


}


