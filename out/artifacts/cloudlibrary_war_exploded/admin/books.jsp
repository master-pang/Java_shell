<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>图书管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
    <script src="${pageContext.request.contextPath}/js/my.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>
<style>
    #c1{

        margin: 0 auto;

    }


</style>
<body class="hold-transition skin-red sidebar-mini">
<!-- .box-body -->
<div class="box-header with-border">
    <h3 class="box-title">图书借阅</h3>
</div>
<div class="box-body">
    <%--新增按钮：如果当前登录用户是管理员，页面展示新增按钮--%>
    <c:if test="${USER_SESSION.role =='ADMIN'}">
        <div class="pull-left">
            <div class="form-group form-inline">
                <div class="btn-group">
<%--                    <button type="button" class="btn btn-default" title="新建" data-toggle="modal"--%>
<%--                            data-target="#addOrEditModal" onclick="resetFrom()"> 新增1--%>
<%--                    </button>--%>
<%--                    <button type="button" class="updateEdit2 btn btn-default" title="新建"  > 新增--%>
<%--                    </button>--%>
<%--                    <a title="新增" class="updateEdit btn btn-default"  href="#">新增3--%>

<%--                    </a>--%>
                </div>
            </div>
        </div>
    </c:if>
        <div class="modal-body">
            <%--    <div id="census" style="width:600px; height:300px;position: relative;float:left;margin-left: 15px"></div>--%>
            <div id="census" style="width:600px; height:300px;position: relative;float:left;margin-left: 15px"></div>
            <div id="census1" style="width:600px; height:300px;position: relative;float:left;"></div>
        </div>
    <%--新增按钮 /--%>
    <!--工具栏 数据搜索 -->
        <div class="box-tools pull-left" style="padding: 10px; margin-left: 10%;text-align: center;">
            <div class="has-feedback">
                <form action="${pageContext.request.contextPath}/book/search" method="post">
                    图书名称：<input name="name" value="${search.name}">&nbsp&nbsp&nbsp&nbsp
                    图书作者：<input name="author" value="${search.author}">&nbsp&nbsp&nbsp&nbsp
                    出版社：<input name="press" value="${search.press}">&nbsp&nbsp&nbsp&nbsp
                    <button class="btn btn-success" type="submit">查询</button>
                    <button class="btn btn-danger" type="reset">重置</button>
                </form>
            </div>
        </div>
    <!--工具栏 数据搜索 /-->
    <!-- 数据列表 -->
    <div class="table-box">
        <!-- 数据表格 -->
        <table id="dataList" class="table table-bordered table-striped table-hover dataTable text-center">
            <thead>
            <tr>
                <th class="sorting_asc">图书名称</th>
                <th class="sorting">图书作者</th>
                <th class="sorting">出版社</th>
                <th class="sorting">标准ISBN</th>
                <th class="sorting">书籍状态</th>
                <th class="sorting">借阅人</th>
                <th class="sorting">借阅时间</th>
                <th class="sorting">预计归还时间</th>
                <th class="text-center">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageResult.rows}" var="book">
                <tr>
                    <td> ${book.name}</td>
                    <td>${book.author}</td>
                    <td>${book.press}</td>
                    <td>${book.isbn}</td>
                    <td>
                        <c:if test="${book.status ==0}">可借阅</c:if>
                        <c:if test="${book.status ==1}">借阅中</c:if>
                        <c:if test="${book.status ==2}">归还中</c:if>
                        <c:if test="${book.status ==4}">已逾期</c:if>
                    </td>
                    <td>${book.borrower }</td>
                    <td>${book.borrowTime}</td>
                    <td>${book.returnTime}</td>
                    <td class="text-center">
                        <c:if test="${book.status ==0}">
                            <button type="button" class="btn bg-olive btn-xs" data-toggle="modal"
                                    data-target="#borrowModal" onclick="findBookById(${book.id},'borrow')"> 借阅
                            </button>
                            <c:if test="${USER_SESSION.role =='ADMIN'}">
                                <button type="button" class="btn bg-olive btn-xs" data-toggle="modal"
                                        data-target="#addOrEditModal" onclick="findBookById(${book.id},'edit')"> 编辑
                                </button>
                            </c:if>
                        </c:if>
                        <c:if test="${book.status ==1 || book.status ==2 || book.status == 4}">
                            <button type="button" class="btn bg-olive btn-xs" disabled="true">已被借阅</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!--数据表格/-->
        <%--分页插件--%>
        <div id="pagination" class="pagination"></div>
    </div>
    <!--数据列表/-->
</div>
<!-- /.box-body -->
<%--引入存放模态窗口的页面--%>
<jsp:include page="/admin/book_modal.jsp"></jsp:include>

<!-- 添加和编辑图书的模态窗口 -->
<div class="modal fade" id="addOrEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="myModalLabel">图书信息</h3>
            </div>
            <div class="modal-body">
                <form id="addOrEditBook">
                    <span><input type="hidden" id="ebid" name="id"></span>
                    <table id="addOrEditTab" class="table table-bordered table-striped" width="800px">
                        <%--图书的id,不展示在页面--%>
                        <tr>
                            <td>图书名称</td>
                            <td><input class="form-control" placeholder="图书名称" name="name" id="ebname"></td>
                            <td>标准ISBN</td>
                            <td><input class="form-control" placeholder="标准ISBN" name="isbn" id="ebisbn"></td>
                        </tr>
                        <tr>
                            <td>出版社</td>
                            <td><input class="form-control" placeholder="出版社" name="press" id="ebpress"></td>
                            <td>作者</td>
                            <td><input class="form-control" placeholder="作者" name="author" id="ebauthor"></td>
                        </tr>
                        <tr>
                            <td>书籍页数</td>
                            <td><input class="form-control" placeholder="书籍页数" name="pagination" id="ebpagination"></td>
                            <td>书籍价格<br/></td>
                            <td><input class="form-control" placeholder="书籍价格" name="price" id="ebprice"></td>
                        </tr>
                            <tr>
                                <td>上架状态</td>
                                <td>
                                    <select class="form-control" id="ebstatus" name="status" >
                                        <option value="0">上架</option>
                                        <option value="3">下架</option>
                                    </select>
                                </td>
                            </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success" data-dismiss="modal" aria-hidden="true" id="aoe" disabled onclick="addOrEdit()">保存
                </button>
                <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">关闭</button>
            </div>
        </div>
    </div>
</div>





<%--$("#savemsg").attr("disabled", false);--%>



</body>

<script>
    // $(".updateEdit2").click(function () {
    //     window.location.href =getProjectPath()+"/addBook3";
    // });
    /*分页插件展示的总页数*/
    //Math.ceil上取整
    pageargs.total = Math.ceil(${pageResult.total}/pageargs.pagesize);
    /*分页插件当前的页码*/
    pageargs.cur = ${pageNum}
    /*分页插件页码变化时将跳转到的服务器端的路径*/
    pageargs.gourl = "${gourl}"
    /*保存搜索框中的搜索条件，页码变化时携带之前的搜索条件*/
    bookVO.name = "${search.name}"
    bookVO.author = "${search.author}"
    bookVO.press = "${search.press}"
    /*分页效果*/
    pagination(pageargs);
//图表
    window.onload = function () {
        $.ajax({
            url: getProjectPath() + "/book/findAll",
            type: 'POST',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                console.log({data})

                var book = data;
                option.series = [{
                    name: '书本总数量',
                    data: [book.length],
                    type: 'bar', //折线line 柱形bar
                }];
                option.legend={data: ['图书']
                }
                option.xAxis={data: ['图书总量'],
                }
                option.title={text:'图书总数量'}

                // option.series.data = [occupiedBeds.length, unoccupiedBeds.length];
                var myChart = echarts.init(document.getElementById('census'));
                myChart.setOption(option);
            }
        })
        var option = {
            title: {

            },



            tooltip: {},
            legend: {

            },
            xAxis: {

            },
            yAxis: {},
            series: [{}]
        };
        // var option = {
        //     title: {
        //         text: '图书总数量'
        //     },
        //     tooltip: {},
        //     legend: {
        //         data: ['图书']
        //     },
        //     xAxis: {
        //         data: ['图书总量'],
        //     },
        //     yAxis: {},
        //     series: [{}]
        // };
        var option1 = {
            title: {
                text: '借阅统计'
            },
            color: [
                {
                    type: 'linear',
                    x: 0,
                    y: 0,
                    x2: 0,
                    y2: 1,
                    colorStops: [
                        { offset: 0, color: '#00DCFB' }, // 设置颜色渐变
                        { offset: 1, color: '#14566B' }
                    ]
                },
                {
                    type: 'linear',
                    x: 0,
                    y: 0,
                    x2: 0,
                    y2: 1,
                    colorStops: [
                        { offset: 0, color: '#FF515A' },
                        { offset: 1, color: '#FFDD53' }
                    ]
                },

            ],


            tooltip: {},
            legend: {
                data: ['图书']
            },
            xAxis: {
                data: ['未借阅书籍','已借阅书籍','已逾期图书'],
            },
            yAxis: {},
            series: [{}]
        };
        $.ajax({
            url: getProjectPath() + "/book/findAll",
            type: 'POST',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                var unborrow = data.filter(item => item.status == '0'  )
                var borrowing = data.filter(item => item.status == '1'  )
                var fulltime = data.filter(item => item.status == '4'  )
                console.log({borrowing})
                var book = data;
                option1.series = [{
                    name: '借阅图书数量统计',
                    data: [unborrow.length,borrowing.length,fulltime.length],
                    type: 'bar', //折线line 柱形bar
                }]
                // option.series.data = [occupiedBeds.length, unoccupiedBeds.length];
                var myChart = echarts.init(document.getElementById('census1'));
                myChart.setOption(option1);
            }

        })

    }
</script>
</html>