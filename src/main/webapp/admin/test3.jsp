<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.FileWriter" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/5/4
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--在原始JSP页面中构建一个名为pages的哈希表，其中包含要生成的JSP页面的名称和内容。--%>
<%--对于每个要创建的页面，将其名称和内容添加到哈希表中。--%>
<%
  HashMap<String, String> pages = new HashMap<String, String>();
  pages.put("page1", "<html><body><h1>Page 1</h1></body></html>");
  pages.put("page2", "<html><body><h1>Page 2</h1></body></html>");
  pages.put("page3", "<html><body><h1>Page 3</h1></body></html>");
%>
<%
  for (Map.Entry<String, String> entry : pages.entrySet()) {
    String pageName = entry.getKey() + ".jsp";
    String pageContent = entry.getValue();
    FileWriter fw = new FileWriter(application.getRealPath("/") + pageName);
    fw.write(pageContent);
    fw.close();
  }
%>
</body>
</html>
