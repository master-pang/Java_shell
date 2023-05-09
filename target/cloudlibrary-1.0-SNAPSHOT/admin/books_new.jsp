<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--首页--%>
<html>
<head>
    <meta charset="utf-8">
    <title>来访登记系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">

</head>
<body class="hold-transition skin-red sidebar-mini">
<!--数据展示头部-->
<div class="box-header with-border">
    <h3 class="box-title">当日预约情况</h3>
</div>
<!--数据展示头部-->
<!--数据展示内容区-->
<!-- 数据表格 /-->

<%--<div id="census" style="width:100%; height:300px;position: relative;background-color: rgb(188, 227, 236);text-align: center;" class="box"></div>--%>
<div id="census" style="width:100%; height:300px;position: relative;background-color: rgb(188, 227, 236);text-align: center;" class="box"></div>
<div class="box-body">
    <!-- 数据表格 id="test" border="1"-->
    <table id="dataList" class="table table-bordered table-striped table-hover dataTable text-center" >
        <thead>
        <tr>
            <th class="sorting_asc">场所名称</th>
<%--            <th class="sorting">核酸情况</th>--%>
<%--            <th class="sorting">粤康码</th>--%>
<%--            <th class="sorting">手机号码</th>--%>
            <th class="sorting">预约状态</th>
<%--            <th class="sorting">预约人</th>--%>
            <th class="sorting">预约时间</th>
            <th class="sorting">预计离开时间</th>
            <th class="text-center">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageResult.rows}" var="book">
            <tr>
                <td> ${book.name}</td>
<%--                <td>${book.author}</td>--%>
<%--                <td>${book.press}</td>--%>
<%--                <td>${book.isbn}</td>--%>
                <td>
                    <c:if test="${book.status ==0}">可预约</c:if>
                    <c:if test="${book.status ==1 || book.status == 4}">来访中</c:if>
                    <c:if test="${book.status ==2}">离开中</c:if>

                </td>
<%--                <td>${book.borrower}</td>--%>
                <td>${book.borrowTime}</td>
                <td>${book.returnTime}</td>
                <td class="text-center">
                    <c:if test="${book.status ==0}">
                        <button type="button" class="btn bg-olive btn-xs" data-toggle="modal" data-target="#borrowModal"
                                onclick="findBookById(${book.id},'borrow')"> 预约
                        </button>
                    </c:if>
                    <c:if test="${book.status ==1 ||book.status ==2 || book.status== 4}">
                        <button type="button" class="btn bg-olive btn-xs" disabled="true">已被预约</button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

<%--    <div id="census1" style="width:600px; height:300px;position: relative;"></div>--%>
</div>

<%--<input type="button" onclick="show22()"  value="查看"/>--%>

<!-- 数据展示内容区/ -->
<%--引入存放模态窗口的页面--%>
<jsp:include page="/admin/book_modal.jsp"></jsp:include>
</body>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination.js"></script>
<script src="${pageContext.request.contextPath}/js/my.js"></script>
<script>
    //3.初始化实例对象 echarts.init(dom容器)
    // var chart = echarts.init(dom, 'dark');
    var myChart = echarts.init(document.querySelector(".box"));
    //4.指定配置项和数据
    var option = {
        title: {
            text: '当日可预约场所数'
        },
        tooltip: {},
        legend: {
            data:['数量']
        },
        xAxis: {
            data: ["场所总数","阅览室","党员中心","研修室","健身房","报告厅","人事中心"]
        },
        yAxis: {},
        series: [{
            name: '数量',
            type: 'bar',
            data: [20, 8, 2, 3, 2, 2, 3]
        }]
    };
    //5.将配置项设置给echarts实例对象，使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

</script>

<%--<script>--%>

<%--    window.onload = function () {--%>
<%--        var myChart = echarts.init(document.querySelector(".box"));--%>
<%--        // var myChart = echarts.init(document.getElementById('census1'));--%>
<%--        console.log('hello world')--%>
<%--        $.ajax({--%>
<%--            url: getProjectPath() + "/findAll",--%>
<%--            type: 'POST',--%>
<%--            dataType: 'json',--%>
<%--            contentType: "application/json; charset=utf-8",--%>
<%--            success: function (data) {--%>
<%--                console.log({data})--%>

<%--                var book = data;--%>
<%--                option.series = [{--%>
<%--                    name: '书本总数量',--%>
<%--                    data: [book.length],--%>
<%--                    type: 'bar', //折线line 柱形bar--%>
<%--                }];--%>
<%--                option.legend={data: ['图书']--%>
<%--                }--%>
<%--                option.xAxis={data: ['图书总量'],--%>
<%--                }--%>
<%--                option.title={text:'图书总数量'}--%>
<%--                var myChart = echarts.init(document.querySelector(".box"));--%>
<%--                option.series.data = [occupiedBeds.length, unoccupiedBeds.length];--%>
<%--                // var myChart = echarts.init(document.getElementById('census'));--%>
<%--                myChart.setOption(option);--%>
<%--            }--%>
<%--        })--%>
<%--        // var option = {--%>
<%--        //     title: {--%>
<%--        //--%>
<%--        //     },--%>
<%--        //     tooltip: {},--%>
<%--        //     legend: {--%>
<%--        //--%>
<%--        //     },--%>
<%--        //     xAxis: {--%>
<%--        //--%>
<%--        //     },--%>
<%--        //     yAxis: {},--%>
<%--        //     series: [{}]--%>
<%--        // };--%>
<%--        var option = {--%>
<%--            title: {--%>
<%--                text: '图书总数量'--%>
<%--            },--%>
<%--            tooltip: {},--%>
<%--            legend: {--%>
<%--                data: ['图书']--%>
<%--            },--%>
<%--            xAxis: {--%>
<%--                data: ['图书总量'],--%>
<%--            },--%>
<%--            yAxis: {},--%>
<%--            series: [{}]--%>
<%--        };--%>
<%--        var option1 = {--%>
<%--            title: {--%>
<%--                text: '借阅统计'--%>
<%--            },--%>
<%--            tooltip: {},--%>
<%--            legend: {--%>
<%--                data: ['图书']--%>
<%--            },--%>
<%--            xAxis: {--%>
<%--                data: ['未借阅书籍','已借阅书籍'],--%>
<%--            },--%>
<%--            yAxis: {},--%>
<%--            series: [{}]--%>
<%--        };--%>
<%--        $.ajax({--%>
<%--            url: getProjectPath() + "/findAll",--%>
<%--            type: 'POST',--%>
<%--            dataType: 'json',--%>
<%--            contentType: "application/json; charset=utf-8",--%>
<%--            success: function (data) {--%>
<%--                var myChart = echarts.init(document.querySelector(".box2"));--%>
<%--                var unborrow = data.filter(item => item.status == '0'  )--%>
<%--                var borrowing = data.filter(item => item.status == '1'  )--%>
<%--                console.log({borrowing})--%>
<%--                var book = data;--%>
<%--                option1.series = [{--%>
<%--                    name: '借阅图书数量统计',--%>
<%--                    data: [unborrow.length,borrowing.length],--%>
<%--                    type: 'bar', //折线line 柱形bar--%>
<%--                }]--%>
<%--                option.series.data = [occupiedBeds.length, unoccupiedBeds.length];--%>
<%--                // var myChart = echarts.init(document.getElementById('census1'));--%>
<%--                myChart.setOption(option1);--%>
<%--            }--%>

<%--        })--%>

<%--    }--%>
<%--</script>--%>
</html>
