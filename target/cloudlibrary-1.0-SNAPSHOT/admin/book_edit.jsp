<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--添加场所--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加场所</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webbase.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pages-login-manage.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

</head>
<body>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="myModalLabel">添加场所</h3>
            </div>
            <div class="modal-body">
                <form id="addOrEditBook" action="${pageContext.request.contextPath}/book/addBook2">
                    <span><input type="hidden" id="ebid" name="id"></span>
                    <table id="addOrEditTab" class="table table-bordered table-striped" width="800px">
                        <%--预约的id,不展示在页面--%>
                        <tr>
                            <td>场所名称</td>
                            <td><input class="form-control" placeholder="场所名称" name="name" id="ebname"></td>
                            <td>手机号码</td>
                            <td><input class="form-control" placeholder="手机号码" name="isbn" id="ebisbn"></td>
                        </tr>
                        <tr>
                            <td>行李数</td>
                            <td><input class="form-control" placeholder="行李数" name="press" id="ebpress"></td>
                            <td>来访人数</td>
                            <td><input class="form-control" placeholder="来访人数" name="author" id="ebauthor"></td>
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
                    <div class="modal-footer">
                        <button class="btn btn-success"  aria-hidden="true" id="aoe"  >添加
                        </button>
                        <button class="btn btn-default"  aria-hidden="true">关闭</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
<script>


</script>

</body>

</html>