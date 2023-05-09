package com.example.library.service.impl;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.example.library.domain.Book;
import com.example.library.domain.Record;
import com.example.library.domain.User;
import com.example.library.mapper.BookMapper;
import com.example.library.service.BookService;
import com.example.library.service.RecordService;
import entity.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class BookServiceImpl implements BookService {
    @Autowired
    private BookMapper bookMapper;

    /**
     * 根据当前页码和每页需要展示的数据条数，查询最新上架的预约信息
     * @param pageNum 当前页码
     * @param pageSize 每页显示数量
     */
    @Override
    public PageResult selectNewBooks(Integer pageNum, Integer pageSize) {
        // 设置分页查询的参数，开始分页
        PageHelper.startPage(pageNum, pageSize);
        Page<Book> page=bookMapper.selectNewBooks();
        return new PageResult(page.getTotal(),page.getResult());
    }
/**
 * 根据id查询预约信息
 * @param id 预约id
 */
public Book findById(String id) {
    return bookMapper.findById(id);
}

/*预约场所*/
@Override
public Integer borrowBook(Book book) {
    //根据id查询出需要预约的完整场所信息
    Book b = this.findById(book.getId()+"");
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//自定义时间格式
    //处理完数据直接更新数据进数据库 而不是sql语句来更新
    book.setBorrowTime(dateFormat.format(new Date()));   //获取当天为预约时间
    book.setStatus("1");//1已经借阅
    book.setPrice(b.getPrice());
    book.setUploadTime(b.getUploadTime()); //将场所的上架设置在book对象中
    return bookMapper.editBook(book);
}

/**
 * @param book 封装查询条件的对象
 * @param pageNum 当前页码
 * @param pageSize 每页显示数量
 */
@Override
public PageResult search(Book book, Integer pageNum, Integer pageSize) {
    // 设置分页查询的参数，开始分页
    PageHelper.startPage(pageNum, pageSize);
    Page<Book> page=bookMapper.searchBooks(book);
    return new PageResult(page.getTotal(),page.getResult());
}

/*新增场所*/
public Integer addBook(Book book) {
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    //设置新增场所的上架时间
    book.setUploadTime(dateFormat.format(new Date()));
    return  bookMapper.addBook(book);
}
    public List<Book> findAll() {
        return bookMapper.findAll();
    }
/*编辑场所信息*/
public Integer editBook(Book book) {
    return bookMapper.editBook(book);
}

@Override
public PageResult searchBorrowed(Book book, User user, Integer pageNum, Integer pageSize) {
    // 设置分页查询的参数，开始分页
    PageHelper.startPage(pageNum, pageSize);
    Page<Book> page;
    //将当前登录的用户放入查询条件中
    book.setBorrower(user.getName());
    //如果是管理员，查询自己预约但未离开的场所和所有待确认离开的场所
    if("ADMIN".equals(user.getRole())){
        page= bookMapper.selectBorrowed(book);
    }else {
        //如果是普通用户，查询自己预约但未离开的场所
        page= bookMapper.selectMyBorrowed(book);
    }
    return new PageResult(page.getTotal(),page.getResult());
}

/**
 * 离开场所
 * @param id 离开的场所的id
 * @param user 离开的人员，也就是当前场所的预约人
 */
@Override
public boolean returnBook(String id,User user) {
    //根据预约id查询出预约的完整信息
    Book book = this.findById(id);
    //再次核验当前登录人员和场所预约人是不是同一个人
    boolean rb=book.getBorrower().equals(user.getName());
    //如果是同一个人，允许离开
    if(rb){
        //将场所预约状态修改为离开中
        book.setStatus("2");
        bookMapper.editBook(book);
    }
    return rb;
}
@Autowired
//注入RecordService对象
private RecordService recordService;
/**
 * 确认离开
 * @param id 待离开确认的预约id
 */
@Override
public Integer returnConfirm(String id) {
    //根据预约id查询场所的完整信息
    Book book = this.findById(id);
    //根据确认离开的场所信息，设置预约记录
    Record record = this.setRecord(book);
    //将场所的预约状态修改为可预约
    book.setStatus("0");
    //清除当前场所的预约人信息
    book.setBorrower("");
    //清除当前场所的预约时间信息
    book.setBorrowTime("");
    //清除当前场所的预计离开时间信息
    book.setReturnTime("");
    Integer count= bookMapper.editBook(book);
    //如果确认离开成功，则新增预约记录
    if(count==1){
        return  recordService.addRecord(record);
    }
    return 0;
}
/**
 * 根据预约信息设置预约记录的信息
 * @param book 预约的场所信息
 */
private Record setRecord(Book book){
    Record record=new Record();
    //设置预约记录的场所名称
    record.setBookname(book.getName());
    //设置预约记录的手机号码
    record.setBookisbn(book.getIsbn());
    //设置预约记录的预约人
    record.setBorrower(book.getBorrower());
    //设置预约记录的预约时间
    record.setBorrowTime(book.getBorrowTime());
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    //设置场所离开确认的当天为场所离开时间
    record.setRemandTime(dateFormat.format(new Date()));
    return record;
}
}
