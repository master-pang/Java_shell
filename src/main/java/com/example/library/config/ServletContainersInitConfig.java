package com.example.library.config;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
//执行ServletContainersInitConfig类，初始化web容器
public class ServletContainersInitConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
    /*
    加载Spring配置类中的信息，
    初始化Spring容器
   */
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{SpringConfig.class};
    }
    /*
    加载Spring MVC配置类中的信息，
    初始化Spring MVC容器
     */
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{SpringMvcConfig.class};
    }
   //设置由springmvc控制器处理的请求映射路径
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
