<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.FileWriter" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/5/4
  Time: 18:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String fileName = application.getRealPath("/") + "pages.txt";
    BufferedReader br = new BufferedReader(new FileReader(fileName));
    String line;
    while ((line = br.readLine()) != null) {
        String[] parts = line.split(",");
        String pageName = parts[0] + ".jsp";
        String pageContent = parts[1];
        FileWriter fw = new FileWriter(application.getRealPath("/") + pageName);
        fw.write(pageContent);
        fw.close();
    }
    br.close();
%>
</body>
</html>
