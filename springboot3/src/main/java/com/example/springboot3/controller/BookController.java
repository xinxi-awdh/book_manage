package com.example.springboot3.controller;

import com.example.springboot3.common.Result;
import com.example.springboot3.entity.Book;
import com.example.springboot3.entity.BookPageRequest;
import com.example.springboot3.service.BookService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookService bookService;

    // 支持可选查询参数 title 和 author
    @GetMapping("/all-book")
    public Result getAllBooks(
            @RequestParam(required = false) String title,
            @RequestParam(required = false) String author) {
        List<Book> books = bookService.getAllBooks(title, author);
        return Result.success(books);
    }

    /**
     * 分页条件查询，支持更多筛选字段
     * POST /books/page
     */
    @PostMapping("/page")
    public Result getBooksByPage(@RequestBody BookPageRequest bookPageRequest) {
        PageInfo<Book> pageInfo = bookService.getBooksByPage(
                bookPageRequest.getPageNum(),
                bookPageRequest.getPageSize(),
                bookPageRequest.getTitle(),
                bookPageRequest.getAuthor(),
                bookPageRequest.getIsbn(),
                bookPageRequest.getCategoryCode(),
                bookPageRequest.getKeyword()
        );
        return Result.success(pageInfo);
    }

    @PostMapping("/add")
    public Result addBook(@RequestBody Book book) {
        bookService.addBook(book);
        return Result.success();
    }

    @PutMapping("/update")
    public Result updateBook(@RequestBody Book book) {
        System.out.println("Received publishDate: " + book.getPublishDate());
        bookService.updateBook(book);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result deleteBook(@PathVariable Integer id) {
        bookService.deleteBook(id);
        return Result.success();
    }

    /**
     * 搜索书籍接口，支持多条件
     * GET /books/search
     */
    @GetMapping("/search")
    public Result searchBooks(
            @RequestParam(required = false) String title,
            @RequestParam(required = false) String author,
            @RequestParam(required = false) String isbn,
            @RequestParam(required = false) String categoryCode,
            @RequestParam(required = false) String keyword
    ) {
        List<Book> books = bookService.searchBooks(title, author, isbn, categoryCode, keyword);
        return Result.success(books);
    }
}
