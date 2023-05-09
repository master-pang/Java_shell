package com.example.library.config;

import org.springframework.util.AntPathMatcher;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


//过滤器的配置比较简单，直接实现Filter 接口即可，也可以通过@WebFilter注解实现对特定URL拦截，看到Filter 接口中定义了三个方法。
@WebFilter(filterName = "encodingFilter",urlPatterns = "/*")//过滤器的name属性  url匹配模式
public class EncodingFilter  implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("----EncodingFilter过滤器初始化----");
    }
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        // 先对request和response进行一些预处理 再执行filterChain.doFilter
        servletRequest.setCharacterEncoding("UTF-8");
        servletResponse.setCharacterEncoding("UTF-8");
        filterChain.doFilter(servletRequest,servletResponse);
    }
    @Override
    public void destroy() {}
}