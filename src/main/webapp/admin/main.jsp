<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--导航栏--%>
<html>
<head>
    <meta charset="utf-8">
    <title>来访登记系统</title>
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
            </li>
        </ul>
    </div>

    </header>

    <!-- 导航侧栏 -->
    <aside class="main-sidebar">
        <section class="sidebar">
            <ul class="sidebar-menu">
                <li >
                    <a href="main.jsp">
                        <i class="fa fa-dashboard"></i> <span>来访预约</span>
                    </a>
                </li>
                <c:if test="${USER_SESSION.role =='ADMIN'}">
                <li >
                    <a href="${pageContext.request.contextPath}/book/search" target="iframe">
                        <i class="fa fa-circle-o"></i>预约信息
                    </a>
                </li>
                </c:if>
                <c:if test="${USER_SESSION.role =='ADMIN'}">
                    <li >
                        <a href="${pageContext.request.contextPath}/book/addBook3" target="iframe">
                            <i class="fa fa-circle-o"></i>添加场所
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="${pageContext.request.contextPath}/book/searchBorrowed" target="iframe">
                        <i class="fa fa-circle-o"></i>当前预约
                    </a>
                </li>
                <li >
                    <a href="${pageContext.request.contextPath}/record/searchRecords" target="iframe">
                        <i class="fa fa-circle-o"></i>预约记录
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