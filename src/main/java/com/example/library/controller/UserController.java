package com.example.library.controller;

import com.example.library.domain.User;
import com.example.library.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {
//    这里没有
    @RequestMapping("/toMainPage")
    public String toMainPage() {
        return "main";
    }

    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login(User user, HttpServletRequest request) {
        try {
            User user1 = userService.login(user);
            if (user1 != null) {
                request.getSession().setAttribute("USER_SESSION",user1);
                return "redirect:/admin/main.jsp";
            }
            request.setAttribute("msg", "用户名或密码错误");
            return "forward:/admin/login.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "系统错误");
            return "forward:/admin/login.jsp";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            //销毁Session
            session.invalidate();
            return "forward:/admin/login.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "系统错误");
            return "forward:/admin/login.jsp";
        }
    }

    @RequestMapping("/register2")
    public String register(User user, HttpServletRequest request) {
        int adduser = userService.addUser(user);
        if (adduser == 0) {
            request.setAttribute("msg", "注册失败");
            return "forward:/admin/register.jsp";
        } else {
            return "forward:/admin/login.jsp";
        }
    }
    @RequestMapping("/register1")
    public String register1() {
        return "register";
    }

}
