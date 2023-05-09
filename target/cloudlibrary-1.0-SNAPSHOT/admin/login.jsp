<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--登录--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>来访登记系统登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webbase.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pages-login-manage.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
    <script src="${pageContext.request.contextPath}/js/my.js"></script>
    <style>

        body {
            background: lightgrey;
            width: 100%;
            height: 300px;
            background-image: url("${pageContext.request.contextPath}/img/bg.jpg");
            background-size: 100% 100%;
        }

        #loginform {
            background-color: whitesmoke;
            /*边框高度*/
            height: 350px;
            /*边框宽度*/
            width: 500px;
            /*边框颜色*/
            border: #4d4d4d solid 1px;
            /*边框圆角*/
            border-radius: 4px;
            /*阴影 水平方向，竖直方向，模糊距离*/
            box-shadow: 5px 5px 5px #4d4d4d;
            /*上边界距离*/
            margin-top: 100px;
            /*左边界距离：自动*/
            margin-left: auto;
            /*右边界距离：自动*/
            margin-right: auto;
            /*用户名、密码间距*/
            padding: 20px 40px;

        }

        .mycenter mysign {
            width: 440px;
            margin-top: 5%;
            text-align: center;
        }

        .mycenter input, checkbox, button {
            margin-top: 10%;
            margin-left: 10%;
            margin-right: 10%;
        }

        .btn {
            margin-top: 10%;
            margin-left: 10%;
            margin-right: 10%;
        }

        .btn1 {
            margin-top: 10%;
            margin-left: 10%;
            margin-right: 10%;
        }

    </style>

</head>
<body>

<form id="loginform" class="sui-form" action="${pageContext.request.contextPath}/login" method="post">
    <div class="mycenter">
        <div class="mysign">
            <div class="col-lg-11 text-center text-info">
                <h2>来访登记系统</h2>
                <span style="color: red">${msg}</span>
            </div>
            <div class="col-lg-10">
                <input type="text" class="form-control" name="email" placeholder="请输入手机号码" required autofocus/>
            </div>
            <div class="col-lg-10">
            </div>
            <div class="col-lg-10">
                <input type="password" class="form-control" name="password" placeholder="请输入密码" required
                       autofocus/>
            </div>
            <div class="col-lg-10">
            </div>
            <div class="col-lg-5">
                <a class="btn btn-success col-lg-12" id="btn"
                   href='javascript:document:loginform.submit();' target="_self">登&nbsp;&nbsp;录</a>
            </div>
            <div class="col-lg-5">
                <a class=" btn btn-success col-lg-12" id="btn1" onclick="r()">注&nbsp;&nbsp;册</a>
            </div>
        </div>
    </div>
    </div>
</form>
<script>
    function r() {
        window.location.href = getProjectPath() + "/register1";
    }
</script>
</body>
<script type="text/javascript">
    /**
     * 登录超时 展示区跳出iframe
     */
    var _topWin = window;
    while (_topWin != _topWin.parent.window) {
        _topWin = _topWin.parent.window;
    }

</script>
</html>