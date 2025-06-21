package com.example.springboot3.controller;

import com.example.springboot3.exception.CustomException;
import jakarta.servlet.http.HttpServletResponse;
import com.example.springboot3.common.Result;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 这是为了实现文件上传下载的一个接口
 */
@RestController
@RequestMapping("/files")
public class FileController {
    //文件目录常量
    private static final String filePath=System.getProperty("user.dir");

    @PostMapping("upload")
    public Result upload(MultipartFile file) {
        String originalFilename= file.getOriginalFilename();
        String directoryPath = filePath + "/files";
        File directory = new File(directoryPath);
        if (!directory.exists()) {
            directory.mkdirs(); // 创建目录，包括任何必要的父目录
        }
        String fileName = System.currentTimeMillis() + "_" + originalFilename;
        File destFile = new File(directory, fileName);
        try {
            file.transferTo(destFile); // 直接将文件保存到磁盘
        } catch (IOException e) {
            e.printStackTrace();
            throw new CustomException("500", "文件上传失败");
        }
        String url = "http://localhost:9090/files/download/" + fileName;
        return Result.success(url);
    }

    @GetMapping("/download/{fileName}")
    public void download(@PathVariable String fileName, HttpServletResponse response) {
        try {
            // 构造文件的完整路径
            String directoryPath = filePath + "/files";
            File file = new File(directoryPath, fileName);

            // 检查文件是否存在
            if (!file.exists() || !file.isFile()) {
                throw new IOException("文件没有找到 " + fileName);
            }

            // 设置响应头
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, StandardCharsets.UTF_8));
            response.setContentType("application/octet-stream");

            // 获取文件的输入流和响应的输出流
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {

                // 创建一个缓冲区来读取文件内容
                byte[] buffer = new byte[4096]; // 4KB缓冲区
                int bytesRead;

                // 循环读取文件内容并写入响应输出流
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                // 刷新输出流（实际上在关闭OutputStream时会自动刷新）
                os.flush();
            }
        } catch (IOException e) {
            e.printStackTrace(); // 通常在生产环境中，不应该直接打印堆栈跟踪给最终用户
            throw new CustomException("500", "文件下载失败");
        }
    }
}
