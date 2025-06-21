package com.example.springboot3.service;

import com.example.springboot3.entity.Book;
import com.example.springboot3.mapper.BookMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional  // 开启事务管理，所有public方法默认事务
public class BookService {

    @Autowired
    private BookMapper bookMapper;

    public List<Book> getAllBooks(String title, String author) {
        return bookMapper.selectAll(title, author);
    }

    // 分页条件查询，参数增加isbn, categoryCode, keyword
    public PageInfo<Book> getBooksByPage(int pageNum, int pageSize, String title, String author, String isbn, String categoryCode, String keyword) {
        PageHelper.startPage(pageNum, pageSize);
        List<Book> books = bookMapper.selectByConditions(title, author, isbn, categoryCode, keyword);
        return PageInfo.of(books);
    }

    public void addBook(Book book) {
        bookMapper.addBook(book);
    }

    public void updateBook(Book book) {
        bookMapper.update(book);
    }

    public void deleteBook(Integer id) {
        bookMapper.deleteById(id);
    }

    // 搜索书籍，同样支持多个条件
    public List<Book> searchBooks(String title, String author, String isbn, String categoryCode, String keyword) {
        return bookMapper.selectByConditions(title, author, isbn, categoryCode, keyword);
    }
}
