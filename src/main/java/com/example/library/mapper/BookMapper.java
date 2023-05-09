package com.example.library.mapper;
import com.github.pagehelper.Page;
import com.example.library.domain.Book;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 预约接口
 */
public interface BookMapper {
    @Select("SELECT * FROM book where book_status !='3' order by book_uploadtime DESC")
    @Results(id = "bookMap",value = {
            //id字段默认为false，表示不是主键
            //column表示数据库表字段，property表示实体类属性名。
            @Result(id = true,column = "book_id",property = "id"),
            @Result(column = "book_name",property = "name"),
            @Result(column = "book_isbn",property = "isbn"),
            @Result(column = "book_press",property = "press"),
            @Result(column = "book_author",property = "author"),
            @Result(column = "book_pagination",property = "pagination"),
            @Result(column = "book_price",property = "price"),
            @Result(column = "book_uploadtime",property = "uploadTime"),
            @Result(column = "book_status",property = "status"),
            @Result(column = "book_borrower",property = "borrower"),
            @Result(column = "book_borrowtime",property = "borrowTime"),
            @Result(column = "book_returntime",property = "returnTime")
    })
    Page<Book> selectNewBooks();


@Select("SELECT * FROM book where book_id=#{id}")
@ResultMap("bookMap")
//根据id查询预约信息
Book findById(String id);

    @Select({"<script>" +
            "SELECT * FROM book " +
            "where book_status !='3'" +
            "<if test=\"name != null\"> AND  book_name  like  CONCAT('%',#{name},'%')</if>" +
            "<if test=\"press != null\"> AND book_press like  CONCAT('%', #{press},'%') </if>" +
            "<if test=\"author != null\"> AND book_author like  CONCAT('%', #{author},'%')</if>" +
            "order by book_borrowtime" +
            "</script>"
    })
    @ResultMap("bookMap")
    //分页查询预约
    Page<Book> searchBooks(Book book);
    //新增场所
    Integer addBook(Book book);
//编辑场所信息
    Integer editBook(Book book);
    @Select("SELECT * FROM book ")
    @ResultMap("bookMap")
    List<Book> findAll();
@Select(
        {"<script>" +
                "SELECT * FROM book " +
                "where book_borrower=#{borrower}" +
                "AND book_status ='4'"+
                "OR book_status ='1'"+

                "<if test=\"name != null\"> AND  book_name  like  CONCAT('%',#{name},'%')</if>" +
                "<if test=\"press != null\"> AND book_press like  CONCAT('%', #{press},'%') </if>" +
                "<if test=\"author != null\"> AND book_author like  CONCAT('%', #{author},'%')</if>" +
                "or book_status ='2'"+
                "<if test=\"name != null\"> AND  book_name  like  CONCAT('%',#{name},'%')</if>" +
                "<if test=\"press != null\"> AND book_press like  CONCAT('%', #{press},'%') </if>" +
                "<if test=\"author != null\"> AND book_author like  CONCAT('%', #{author},'%')</if>" +
                "order by book_borrowtime" +
                "</script>"})
@ResultMap("bookMap")
//查询预约但未离开的预约和待确认离开的预约
Page<Book> selectBorrowed(Book book);

@Select({"<script>"  +
        "SELECT * FROM book " +
        "where book_borrower=#{borrower}" +
        "AND book_status in('1','2')"+
        "<if test=\"name != null\"> AND  book_name  like  CONCAT('%',#{name},'%')</if>" +
        "<if test=\"press != null\"> AND book_press like  CONCAT('%', #{press},'%') </if>" +
        "<if test=\"author != null\"> AND book_author like  CONCAT('%', #{author},'%')</if>" +
        "order by book_borrowtime" +
        "</script>"})
@ResultMap("bookMap")
//查询预约但未离开的预约
Page<Book> selectMyBorrowed(Book book);

}
