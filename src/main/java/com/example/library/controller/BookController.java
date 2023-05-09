package com.example.library.controller;

import com.example.library.domain.Book;
import com.example.library.domain.User;
import com.example.library.service.BookService;
import entity.PageResult;
import entity.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/book")
public class BookController {
    //注入BookService对象
    @Autowired
    private BookService bookService;

    @RequestMapping("/selectNewbooks")
    public ModelAndView selectNewbooks() {
        //查询最新上架的100个的预约信息
        int pageNum = 1;
        int pageSize =100;
        PageResult pageResult = bookService.selectNewBooks(pageNum, pageSize);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("books_new");
        modelAndView.addObject("pageResult", pageResult);
        return modelAndView;
    }

    @RequestMapping("/findAll")
    @ResponseBody
    public List<Book> findAll(HttpSession session) {


        List<Book> books = bookService.findAll();


        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
        String time=dateFormat.format(date);
        for(Book book :books) {
            if (book.getReturnTime().equals(time)) {
                System.out.println(book.getReturnTime());
                book.setStatus("4");
//                好像可以不要
//                Book b=new Book();
//                b.setId(book.getId());
//                b.setStatus(book.getStatus());
//                System.out.println(b.toString());

                int i=bookService.editBook(book);
                if(i>0){
                    System.out.println("修改成功");
                }
            }
        }

//            System.out.println("--->>>" + books.get(i).getBorrowTime());
//            System.out.println("--->>>" + books.get(i));



        return books;
    }

//根据id查询
    @ResponseBody
    @RequestMapping("/findById")
    public Result<Book> findById(String id) {
        try {
            Book book = bookService.findById(id);
            if (book == null) {
                return new Result(false, "查询失败！");
            }
            return new Result(true, "查询成功", book);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "查询失败！");
        }
    }

//    @ResponseBody
//    @RequestMapping("/findById2")
//    public String findById2(String id) {
//        Book book = bookService.findById(id);
//        if (book == null) {
//            return "";
//        }
//        return "";
//
//    }

    @ResponseBody
    @RequestMapping("/borrowBook")
    public Result borrowBook(Book book, HttpSession session) {
        String pname = ((User) session.getAttribute("USER_SESSION")).getName();//获取当前登录的用户姓名
        book.setBorrower(pname);
        try {
            Integer count = bookService.borrowBook(book);            //根据预约的id和用户进行场所预约
            if (count != 1) {
                return new Result(false, "预约场所失败!");
            }
            return new Result(true, "预约成功，请到场所入口处签到!");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "预约场所失败!");
        }
    }

    @RequestMapping("/search")
    public ModelAndView search(Book book, Integer pageNum, Integer pageSize, HttpServletRequest request) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        //查询到的预约信息
        PageResult pageResult = bookService.search(book, pageNum, pageSize);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("books");
        //将查询到的数据存放在 ModelAndView的对象中
        modelAndView.addObject("pageResult", pageResult);
        //将查询的参数返回到页面，用于回显到查询的输入框中
        modelAndView.addObject("search", book);
        //将当前页码返回到页面，用于分页插件的分页显示
        modelAndView.addObject("pageNum", pageNum);
        //将当前查询的控制器路径返回到页面，页码变化时继续向该路径发送请求
        modelAndView.addObject("gourl", request.getRequestURI());
        return modelAndView;
    }


    @ResponseBody
    @RequestMapping("/addBook")
    public Result addBook(Book book) {
        try {
            Integer count = bookService.addBook(book);
            if (count != 1) {
                return new Result(false, "新增场所失败!");
            }
            return new Result(true, "新增场所成功!");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "新增场所失败!");
        }
    }

    @RequestMapping("/addBook2")
    public ModelAndView addBook2(Book book) {
        Integer count = bookService.addBook(book);
        System.out.println(count);
        System.out.println("添加成功");
        ModelAndView modelAndView = new ModelAndView();
        if (count == 1) {
            modelAndView.setViewName("redirect:/book/search");
            return modelAndView;
        } else {
            modelAndView.setViewName("book_edit");
            return modelAndView;
        }


    }

    @RequestMapping("/addBook3")
    public ModelAndView addBook3() {

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("book_edit");
        System.out.println("添加成功");

        return modelAndView;

    }

    /**
     * 编辑预约信息
     */
    @ResponseBody
    @RequestMapping("/editBook")
    public Result editBook(Book book) {
        try {
            Integer count = bookService.editBook(book);
            if (count != 1) {
                return new Result(false, "编辑失败!");
            }
            return new Result(true, "编辑成功!");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "编辑失败!");
        }
    }

    /*未离开的场所信息 */
    @RequestMapping("/searchBorrowed")
    public ModelAndView searchBorrowed(Book book, Integer pageNum, Integer pageSize, HttpServletRequest request) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        //获取当前登录的用户
        User user = (User) request.getSession().getAttribute("USER_SESSION");
        PageResult pageResult = bookService.searchBorrowed(book, user, pageNum, pageSize);




        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("book_borrowed");
        //将查询到的数据存放在 ModelAndView的对象中
        modelAndView.addObject("pageResult", pageResult);
        //将查询的参数返回到页面，用于回显到查询的输入框中
        modelAndView.addObject("search", book);
        //将当前页码返回到页面，用于分页插件的分页显示
        modelAndView.addObject("pageNum", pageNum);
        //将当前查询的控制器路径返回到页面，页码变化时继续向该路径发送请求
        modelAndView.addObject("gourl", request.getRequestURI());
        return modelAndView;
    }

    /*离开场所d*/
    @ResponseBody
    @RequestMapping("/returnBook")
    public Result returnBook(String id, HttpSession session) {
        //获取当前登录的用户信息
        User user = (User) session.getAttribute("USER_SESSION");
        try {
            boolean flag = bookService.returnBook(id, user);
            if (!flag) {
                return new Result(false, "申请离开失败!");
            }
            return new Result(true, "离开确认中，请先到场所出口处签到!");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "申请离开失败!");
        }
    }

    /**
     * 确认离开场所
     *
     * @param id 确认离开场所的id
     */
    @ResponseBody
    @RequestMapping("/returnConfirm")
    public Result returnConfirm(String id) {
        try {
            Integer count = bookService.returnConfirm(id);
            if (count != 1) {
                return new Result(false, "确认失败!");
            }
            return new Result(true, "确认成功!");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "确认失败!");
        }
    }

}

