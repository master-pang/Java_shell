package com.example.library.service.impl;
import com.example.library.domain.User;
import com.example.library.mapper.UserMapper;
import com.example.library.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
/**
 *用户接口实现类
 */
@Service
public class UserServiceImpl  implements UserService {
    //注入userMapper
    @Autowired
    private UserMapper userMapper;
    //通过User的用户账号和用户密码查询用户信息
    @Override
//   登录
    public User login(User user) { return userMapper.login(user); }
//    注册添加用户
    public Integer addUser(User user) { return userMapper.addUser(user); }
}
