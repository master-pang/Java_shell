<%@ page import="java.io.FileWriter" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/5/4
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>生成新页面</title>
    <script type="text/javascript">
        function goToNewPage() {
            window.location.href = "file:///C:/JavaWorkPath/Visitor%20registration%20system/target/cloudlibrary-1.0-SNAPSHOT/newpage.jsp";
        }
    </script>
</head>
<body>
<%
    String pageName = "newpage.jsp";
    String pageContent = "<html><body><h1>New Page</h1>"
            +"<jsp:scriptlet>\n" +
    "    // 重定向到新地址\n"
    +
    "    String site = new String(\"https://www.baidu.com\");\n"
    +
    "    response.setStatus(response.SC_MOVED_TEMPORARILY);\n"
    +
    "    response.setHeader(\"Location\", site);\n"
    +
    " </jsp:scriptlet></body></html>"; // 替换成您自己的JSP内容或从其他位置获取
    String filePath = application.getRealPath("/") + pageName;
    FileWriter fw = new FileWriter(filePath);
    fw.write(pageContent);
//    断点测试
    out.println(pageContent+"</br>");
    out.println(application.getRealPath("/") + pageName);

    fw.close();
    // 将用户重定向到生成的JSP页面
//    response.sendRedirect(pageName);

%>
<%--<%--%>
<%--    String absolutePath = "C:/JavaWorkPath/Visitor%20registration%20system/target/cloudlibrary-1.0-SNAPSHOT/newpage.jsp";--%>
<%--    response.sendRedirect(absolutePath);--%>
<%--    if (request.getParameter("goToNewPage") != null) {--%>
<%--        response.sendRedirect("newpage.jsp");--%>
<%--    }--%>
<%--%>--%>

<%--<form method="post" action="">--%>
<%--    <button type="submit" name="goToNewPage">Go to New Page</button>--%>
<%--</form>--%>

<form action="shell.jsp" method="post">
    <button type="submit">跳转到shell</button>
</form>

<%--<button type="submit" name="goToNewPage">Go to New Page</button>--%>
<button onclick="goToNewPage()">Go to New Page</button>

<%--<a href="target/cloudlibrary-1.0-SNAPSHOT/newpage.jsp">跳转</a>--%>


</body>
</html>
