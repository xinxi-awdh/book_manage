package com.example.springboot3.mapper;

import com.example.springboot3.entity.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BookMapper {

    // 支持传 title 和 author 作为过滤条件
    List<Book> selectAll(@Param("title") String title, @Param("author") String author);

    Book selectById(Integer id);

    int addBook(Book book);

    int update(Book book);

    int deleteById(Integer id);

    /**
     * 多条件查询书籍
     */
    List<Book> selectByConditions(
            @Param("title") String title,
            @Param("author") String author,
            @Param("isbn") String isbn,
            @Param("categoryCode") String categoryCode,
            @Param("keyword") String keyword
    );
}
