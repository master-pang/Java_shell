package com.example.library.interceptor;

import com.example.library.domain.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 资源拦截器
 */
public class ResourcesInterceptor extends HandlerInterceptorAdapter {
    //任意角色都能访问的路径
    private List<String> ignoreUrl;
    //springMVCconfig中 @Bean public ResourcesInterceptor resourcesInterceptor()返回
    public ResourcesInterceptor(List<String> ignoreUrl) {
        this.ignoreUrl = ignoreUrl;
    }
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws
            Exception {
        User user = (User) request.getSession().getAttribute("USER_SESSION");
        //获取请求的路径
        String uri = request.getRequestURI();
        //如果用户是已登录状态，判断访问的资源是否有权限
//        判断session中有没有用户信息  有信息已经登录 无信息则无登录 因为登录后会将信息set入session中
        if (user != null) {
            //如果是管理员，放行
            if ("ADMIN".equals(user.getRole())) {
                return true;
            }
            //如果是普通用户
            else if (!"ADMIN".equals(user.getRole())) {
                for (String url : ignoreUrl) {
                    //访问的资源不是管理员权限的资源，放行 。。。。对比现在的路径uri与ignoreUrl中的路径 如果存在 则放行
                    if (uri.indexOf(url) >= 0) {
                        return true;
                    }
                }
            }
        }
        //对用户登录的相关请求，放行  indexOf返回特定子字符串第一次在源字符串中的位置。如果源字符中不存在目标字符，则返回-1
        if (uri.indexOf("login") >= 0 || uri.indexOf("register1") >= 0 || uri.indexOf("register2") >=0) {
            return true;
        }
        //其他情况都直接跳转到登录页面
        request.setAttribute("msg", "您还没有登录，请先登录！");
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        return false;
    }
}