package com.example.springboot3.aspect;

import com.example.springboot3.entity.OperationLog;
import com.example.springboot3.service.OperationLogService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;
import java.util.Arrays;

@Aspect
@Component
@RequiredArgsConstructor
public class OperationLogAspect {

    private final OperationLogService logService;

    @Pointcut("execution(* com.example.springboot3.controller.*.*(..))")
    public void controllerMethods() {}

    @AfterReturning(pointcut = "controllerMethods()", returning = "result")
    public void logAfter(JoinPoint joinPoint, Object result) {
        try {
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attributes == null) return;

            HttpServletRequest request = attributes.getRequest();
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            if (authentication == null || !authentication.isAuthenticated()) return;

            OperationLog log = new OperationLog();

            // 安全获取用户信息
            log.setUsername(authentication.getName());

            // 获取用户角色
            if (!authentication.getAuthorities().isEmpty()) {
                log.setRole(authentication.getAuthorities().iterator().next().getAuthority());
            }

            // 精确记录操作信息
            log.setOperation(joinPoint.getSignature().getDeclaringTypeName() + "." +
                    joinPoint.getSignature().getName());

            log.setUri(request.getRequestURI());  // 单独记录URI
            log.setMethod(request.getMethod());   // 单独记录HTTP方法
            log.setParams(Arrays.toString(joinPoint.getArgs()));

            // 记录操作结果
            if (result != null) {
                log.setResult(result.toString().substring(0, Math.min(200, result.toString().length())));
            }

            log.setIp(request.getRemoteAddr());
            log.setCreatedTime(LocalDateTime.now());

            // 异步保存日志（推荐）
            new Thread(() -> logService.save(log)).start();
        } catch (Exception e) {
            // 记录日志失败不应影响主流程
            System.err.println("操作日志记录失败: " + e.getMessage());
        }
    }
}