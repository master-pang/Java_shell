<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>云借阅-图书管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/_all-skins.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<%--    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>--%>
    <script src="../js/echarts.js"></script>
    <script type="text/javascript">
        function SetIFrameHeight() {
            var iframeid = document.getElementById("iframe");
            if (document.getElementById) {
                /*设置 内容展示区的高度等于页面可视区的高度*/
                iframeid.height = document.documentElement.clientHeight;
            }
        }
    </script>

</head>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">
    <!-- 页面头部 -->
    <header class="main-header" style="background-color:#515151;">
        <!-- Logo -->
<%--        <a href="${pageContext.request.contextPath}/admin/main.jsp" class="logo">--%>
<%--            <span class="logo-lg"><b>云借阅-图书管理系统</b></span>--%>
<%--        </a>--%>
        <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
            <li class="dropdown user user-menu">
                <a>
                    <img src="${pageContext.request.contextPath}/img/user.jpg" class="user-image"
                         alt="User Image">
                    <span class="hidden-xs">${USER_SESSION.name}</span>
                </a>
            </li>
            <li class="dropdown user user-menu">
                <a href="${pageContext.request.contextPath}/logout"  onclick="return confirm('确定注销?');" >
                        用户注销
                </a>
<%--                ${pageContext.request.contextPath}/logout--%>
            </li>
        </ul>
    </div>

        <!-- 头部导航 -->
<%--        <nav class="" style="background-color:#515151; ">--%>
<%--            <div class="navbar-custom-menu">--%>
<%--                <ul class="nav navbar-nav">--%>
<%--                    <li class="dropdown user user-menu">--%>
<%--                        <a>--%>
<%--                            <img src="${pageContext.request.contextPath}/img/user.jpg" class="user-image"--%>
<%--                                 alt="User Image">--%>
<%--                            <span class="hidden-xs">${USER_SESSION.name}</span>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li class="dropdown user user-menu">--%>
<%--                        <a href="${pageContext.request.contextPath}/logout">--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--        </nav>--%>
    </header>
    <!-- 页面头部 /-->

    <!-- 导航侧栏 -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">

            <!-- /.search form -->
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li >
                    <a href="main.jsp">
                        <i class="fa fa-dashboard"></i> <span>首页</span>
                    </a>
                </li>
                <li >
                    <a href="${pageContext.request.contextPath}/book/search" target="iframe">
                        <i class="fa fa-circle-o"></i>图书借阅
                    </a>
                </li>
                <c:if test="${USER_SESSION.role =='ADMIN'}">
                    <li >
                        <a href="${pageContext.request.contextPath}/book/addBook3" target="iframe">
                            <i class="fa fa-circle-o"></i>添加图书
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="${pageContext.request.contextPath}/book/searchBorrowed" target="iframe">
                        <i class="fa fa-circle-o"></i>当前借阅
                    </a>
                </li>
                <li >
                    <a href="${pageContext.request.contextPath}/record/searchRecords" target="iframe">
                        <i class="fa fa-circle-o"></i>借阅记录
                    </a>
                </li>

            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>
    <!-- 导航侧栏 /-->
    <!-- 内容展示区域 -->
    <div class="content-wrapper">
        <iframe width="100%"  height="500px" id="iframe" name="iframe" onload="SetIFrameHeight()"
                frameborder="0" src="${pageContext.request.contextPath}/book/selectNewbooks">
        </iframe>>

</div>
<script>

</script>
</body>
</html>