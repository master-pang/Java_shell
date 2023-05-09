<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.InputStream" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/5/4
  Time: 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>输出初始化次数、相应次数、销毁数、跳转到shell或者tiaozhuanye</title>
<%--    5s刷新一次--%>
<%--    <meta http-equiv=”refresh” content=”5;url=shell.jsp”>--%>
</head>
<body>
<%!
    private int initVar=0;
    private int serviceVar=0;
    private int destroyVar=0;
//    private static int visitCount = 0;

//private static Map<String, Integer> baiduMap = new HashMap<>();
//    private static Map<String, Integer> spider360Map = new HashMap<>();
//    private static Map<String, Integer> sogouMap = new HashMap<>();

    private static ThreadLocal<Map<String, Integer>> baiduMap = new ThreadLocal<Map<String, Integer>>() {
        @Override
        public Map<String, Integer> initialValue() {
            return new HashMap<String, Integer>();
        }
    };
    private static ThreadLocal<Map<String, Integer>> spider360Map = new ThreadLocal<Map<String, Integer>>() {
        @Override
        public Map<String, Integer> initialValue() {
            return new HashMap<String, Integer>();
        }
    };
    private static ThreadLocal<Map<String, Integer>> sogouMap = new ThreadLocal<Map<String, Integer>>() {
        @Override
        public Map<String, Integer> initialValue() {
            return new HashMap<String, Integer>();
        }
    };
%>

<%!
    public void jspInit(){
        initVar++;
        System.out.println("jspInit(): JSP被初始化了"+initVar+"次");
    }
    public void jspDestroy(){
        destroyVar++;
        System.out.println("jspDestroy(): JSP被销毁了"+destroyVar+"次");
    }
%>

<%
    serviceVar++;
    System.out.println("_jspService(): JSP共响应了"+serviceVar+"次请求");

    String content1="初始化次数 : "+initVar;
    String content2="响应客户请求次数 : "+serviceVar;
    String content3="销毁次数 : "+destroyVar;
%>
<h1>JSP 测试实例</h1>
<h2>
<p><%=content1 %></p>
<p><%=content2 %></p>
<p><%=content3 %></p>
<p>
    今天的日期是: <%= (new java.util.Date()).toLocaleString()%>
</p>
</h2>
<form action="shell.jsp" method="post">
    <button type="submit">跳转到shell</button>
    <a href="tiaozhuanye.jsp">跳转</a>
</form>
<%
//    获取浏览器代理字符串并将其转换为小写字母形式，以便后面进行匹配。
    String agent = request.getHeader("User-Agent").toLowerCase();

//    声明一个名为countMap的Map对象，并将visitCount初始化为0
//    Map<String, Integer> countMap = new HashMap<>();
//    countMap.put("baiduCount", 0);
//    countMap.put("360Count", 0);
//    countMap.put("sogouCount", 0);
//    countMap.put("googleCount", 0);
//    countMap.put("yisouCount", 0);
//    countMap.put("bingCount", 0);
//    countMap.put("yahooCount", 0);
//    countMap.put("sosoCount", 0);
//    countMap.put("youdao1Count", 0);
//    countMap.put("youdao2Count", 0);
//    countMap.put("msnCount", 0);
//    countMap.put("alexaCount", 0);
//    countMap.put("easouCount", 0);
//    countMap.put("jikeCount", 0);
//    Map<String, Integer> baiduMap = new HashMap<>();
//    Map<String, Integer> spider360Map = new HashMap<>();
//    Map<String, Integer> sogouMap = new HashMap<>();
//    Map<String, Integer> yisouMap = new HashMap<>();
//    Map<String, Integer> googleMap = new HashMap<>();
//    Map<String, Integer> bingMap = new HashMap<>();
//    Map<String, Integer> yahooMap = new HashMap<>();
//    Map<String, Integer> sosoMap = new HashMap<>();
//    Map<String, Integer> youdao1Map = new HashMap<>();
//    Map<String, Integer> youdao2Map = new HashMap<>();
//    Map<String, Integer> msnMap = new HashMap<>();
//    Map<String, Integer> alexaMap = new HashMap<>();
//    Map<String, Integer> easouMap = new HashMap<>();
//    Map<String, Integer> jikeMap = new HashMap<>();

//    indexOf方法查找字符串中是否包含各种搜索引擎爬虫的标识符
    int baidu = agent.indexOf("baiduspider");
    int spider360 = agent.indexOf("360Spider");
    int sogou = agent.indexOf("sogou");
    int google = agent.indexOf("googlebot");
    int yisou = agent.indexOf("yisouspider");//一搜
    int bing  = agent.indexOf("bingbot");//必应
    int yahoo  = agent.indexOf("yahoo");//雅虎！
    int soso  = agent.indexOf("sosospider");//SOSO
    int youdao1  = agent.indexOf("youdaoBot");//有道
    int youdao2  = agent.indexOf("yodaoBot");//有道
    int msn  = agent.indexOf("msnbot");//MSN
    int alexa  = agent.indexOf("ia_archiver");//Alexa
    int easou  = agent.indexOf("easouspider");//宜sou
    int jike  = agent.indexOf("jikespider");//即刻







    if(baidu>-1 || spider360>-1 || sogou>-1 || yisou>-1|| google>-1|| bing>-1|| yahoo>-1|| soso>-1|| youdao1>-1|| youdao2>-1|| msn>-1|| alexa>-1|| easou>-1|| jike>-1) {
    // 不执行任何操作
//        response.sendRedirect("https://blog.csdn.net/weixin_43576565/article/details/130288979");
        // 判断是否是第三次访问
//         int visitCount = 0;
//        if(baidu>-1) {
//            int visitCount = countMap.get("baiduCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("baiduCount", visitCount);
//        } else if (spider360>-1) {
//            int visitCount = countMap.get("360Count");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("360Count", visitCount);
//        } else if (sogou>-1) {
//            int visitCount = countMap.get("sogouCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("sogouCount", visitCount);
//        } else if (yisou>-1) {
//            int visitCount = countMap.get("yisouCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("yisouCount", visitCount);
//        } else if (google>-1) {
//            int visitCount = countMap.get("googleCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("googleCount", visitCount);
//        } else if (bing>-1) {
//            int visitCount = countMap.get("bingCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("bingCount", visitCount);
//        } else if (yahoo>-1) {
//            int visitCount = countMap.get("yahooCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("yahooCount", visitCount);
//        } else if (soso>-1) {
//            int visitCount = countMap.get("sosoCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("sosoCount", visitCount);
//        } else if (youdao1>-1) {
//            int visitCount = countMap.get("youdao1Count");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("youdao1Count", visitCount);
//        } else if (youdao2>-1) {
//            int visitCount = countMap.get("youdao2Count");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("youdao2Countt", visitCount);
//        } else if (msn>-1) {
//            int visitCount = countMap.get("msnCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("msnCount", visitCount);
//        } else if (alexa>-1) {
//            int visitCount = countMap.get("alexaCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("alexaCount", visitCount);
//        } else if (easou>-1) {
//            int visitCount = countMap.get("easouCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("easouCount", visitCount);
//        } else if (jike>-1) {
//            int visitCount = countMap.get("jikeCount");
//            if (visitCount >= 1) {
//                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
//                return;
//            }
//            visitCount++;
//            countMap.put("jikeCount", visitCount);
//        }


//        第三版
        String source = "";
        if (baidu > -1) {
            source = "baidu";
        } else if (spider360 > -1) {
            source = "spider360";
        } else if (sogou > -1) {
            source = "sogou";
        }
        int visitCount = 0;
        if (source != "") {
            Map<String, Integer> map;
            switch (source) {
                case "baidu":
                    map = baiduMap.get();
                    break;
                case "spider360":
                    map = spider360Map.get();
                    break;
                case "sogou":
                    map = sogouMap.get();
                    break;
                default:
                    map = new HashMap<>();
            }
            if (map.containsKey(source)) {
                visitCount = map.get(source);
            }
            visitCount++;
            map.put(source, visitCount);
            if (visitCount > 2) {
                response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
                return;
            }
        }

        //请求非服务器接口
        String urlString = "http://example.com/api";
        URL apiurl = new URL(urlString);
        HttpURLConnection conn2 = (HttpURLConnection)apiurl.openConnection();
        conn2.setRequestMethod("GET");

        int responseCode = conn2.getResponseCode();
        if (responseCode == 200) {
            InputStream inputStream = conn2.getInputStream();
            // 处理返回结果
        } else {
            // 处理错误情况
        }

        String url = "https://www.baidu.com";
//    构造一个URL对象，连接到指定的广告页面
        URL obj = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
        conn.setRequestMethod("GET");
//    使用GET请求获取响应内容。然后将响应内容输出到客户端浏览器，从而实现重定向。
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuffer response1 = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response1.append(inputLine);
        }
        in.close();
        out.print(response1.toString());
    } else {
//  注意：测试用，正式则放上面

// 判断是否是第二次访问
//    Object isVisited = session.getAttribute("visited");
//    if (isVisited != null) {
//        out.print("您已经访问过该页面，不允许再次访问。");
//        return;
//    }
// 第一次访问：将visited属性设置为true，并跳转到广告页面，配套判断第二次访问
//    session.setAttribute("visited", true);


        // 通过获取HTTP请求头中的Referer字段来判断用户是否是从搜索引擎页面跳转过来的，这块不用上调这是用户用的
        String referer = request.getHeader("Referer");

        if (referer != null && (referer.contains("www.baidu.com") || referer.contains("www.sogou.com") || referer.contains("www.google.com"))) {
            // 是从百度页面跳转过来的，跳转到广告商页面
            response.sendRedirect("https://cn.bing.com/#!");
        } else {
            // 不是从百度页面跳转过来的，跳转到站点根目录主页面
//            response.sendRedirect("/index.jsp");
//             response.sendRedirect("https://blog.csdn.net/weixin_43576565/article/details/130290739");

            String pageName = "newpage.jsp";
            String pageContent = "<html><body><h1>New Page</h1><a href=\"tiaozhuanye.jsp\">友情链接</a>"

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
        }



    }
%>
<%--<jsp:scriptlet>--%>
<%--&lt;%&ndash;    重定向到新地址&ndash;%&gt;--%>
<%--    String site = new String("http://www.runoob.com");--%>
<%--    response.setStatus(response.SC_MOVED_TEMPORARILY);--%>
<%--    response.setHeader("Location", site);--%>
<%-- </jsp:scriptlet>--%>

<%--<%--%>
<%--    // 定义要进行循环处理的数据--%>
<%--    String[] colors = {"red", "green", "blue", "yellow"};--%>

<%--    // 循环处理数据--%>
<%--    for (int i = 0; i < colors.length; i++) {--%>
<%--        // 动态生成新的HTML代码--%>
<%--        out.println("<h1 style='color:" + colors[i] + "'>Color is " + colors[i] + "</h1>");--%>
<%--    }--%>
<%--%>--%>



<%--<%--%>


<%--    // 定义要进行循环处理的数据--%>
<%--    String[] colors = {"red", "green", "blue", "yellow"};--%>

<%--    // 循环处理数据--%>
<%--    for (int i = 0; i < colors.length; i++) {--%>
<%--        // 动态生成新的JSP代码--%>
<%--        StringBuilder sb = new StringBuilder();--%>
<%--        sb.append("<%@ page contentType=\"text/html;charset=UTF-8\" language=\"java\" %>");--%>
<%--        sb.append("<!DOCTYPE html>\n");--%>
<%--        sb.append("<html>\n");--%>
<%--        sb.append("<head>\n");--%>
<%--        sb.append("<meta charset=\"UTF-8\">\n");--%>
<%--        sb.append(String.format("<title>%s</title>\n", colors[i]));--%>
<%--        sb.append("</head>\n");--%>
<%--        sb.append("<body>\n");--%>
<%--        sb.append(String.format("<h1 style=\"color:%s\">Color is %s</h1>\n", colors[i], colors[i]));--%>
<%--        sb.append("</body>\n");--%>
<%--        sb.append("</html>");--%>
<%--        String jspContent = sb.toString();--%>

<%--        &lt;%&ndash;// 保存动态生成的JSP页面&ndash;%&gt;--%>
<%--        String fileName = colors[i] + ".jsp";--%>
<%--        File file = new File(request.getServletContext().getRealPath("/") + fileName);--%>
<%--        PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(file)));--%>
<%--        out.println(jspContent);--%>
<%--        out.close();--%>
<%--        }--%>
<%--%>--%>


</body>
</html>
