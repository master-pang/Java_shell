package com.example.library.service;
import com.example.library.domain.Book;
import com.example.library.domain.User;
import entity.PageResult;

import java.util.List;

/**
 * 预约接口
 */
public interface BookService {
//查询最新上架的场所
PageResult selectNewBooks(Integer pageNum, Integer pageSize);
//根据id查询预约信息
Book findById(String id);

    List<Book> findAll();
//预约场所
Integer borrowBook(Book book);
//分页查询预约
PageResult search(Book book, Integer pageNum, Integer pageSize);
//新增预约
Integer addBook(Book book);
//编辑预约信息
Integer editBook(Book book);
//查询当前预约的场所
PageResult searchBorrowed(Book book, User user, Integer pageNum, Integer pageSize);
//离开场所
boolean returnBook(String  id,User user);
//确认离开
Integer returnConfirm(String id);

}
