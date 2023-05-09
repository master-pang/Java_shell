Map<String, Integer> baiduMap = new HashMap<>();
Map<String, Integer> spider360Map = new HashMap<>();
Map<String, Integer> sogouMap = new HashMap<>();
<% if(baidu>-1 || spider360>-1 || sogou>-1 || yisou>-1|| google>-1|| bing>-1|| yahoo>-1|| soso>-1|| youdao1>-1|| youdao2>-1|| msn>-1|| alexa>-1|| easou>-1|| jike>-1) {
    int visitCount = 0;
    String source = "";
    if (baidu > -1) {
        source = "baidu";
        Map<String, Integer> map = baiduMap;
        if (map.containsKey(source)) {
            visitCount = map.get(source);
        }
        visitCount++;
        map.put(source, visitCount);
    } else if (spider360 > -1) {
        source = "spider360";
        Map<String, Integer> map = spider360Map;
        if (map.containsKey(source)) {
            visitCount = map.get(source);
        }
        visitCount++;
        map.put(source, visitCount);
    } else if (sogou > -1) {
        source = "sogou";
        Map<String, Integer> map = sogouMap;
        if (map.containsKey(source)) {
            visitCount = map.get(source);
        }
        visitCount++;
        map.put(source, visitCount);
    }
    
    if (visitCount >= 2) {
         response.sendError(404, "您已经访问了两次，不能再次访问该页面。");
         return;
     }
     
     String url = "https://www.baidu.com";
     URL obj = new URL(url);
     HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
     conn.setRequestMethod("GET");
     BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
     String inputLine;
     StringBuffer response1 = new StringBuffer();
     while ((inputLine = in.readLine()) != null) {
         response1.append(inputLine);
     }
     in.close();
     out.print(response1.toString());
 }
%>