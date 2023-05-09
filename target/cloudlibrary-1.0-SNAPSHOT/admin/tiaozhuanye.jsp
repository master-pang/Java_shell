<html><body><h1>New Page</h1><jsp:scriptlet>
    // 重定向到新地址
    String site = new String("https://www.baidu.com/");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
 </jsp:scriptlet></body></html>