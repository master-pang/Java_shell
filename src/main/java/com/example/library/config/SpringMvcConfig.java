package com.example.library.config;


import com.example.library.interceptor.ResourcesInterceptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;

import java.util.List;

@Configuration
//加载指定的配置文件ignoreUrl.properties登录后用户可以放行路径 //等同于<context:component-scan base-package="com.itheima.controller"/>
@PropertySource("classpath:ignoreUrl.properties")

//扫描的路径从中找出标识了需要装配的类自动装配到spring的bean容器中 扫描controller包
@ComponentScan({"com.example.library.controller"})
/*@Import({MyWebMvcConfig.class})*/
@EnableWebMvc
public class SpringMvcConfig  implements WebMvcConfigurer {
//    split根据“,”号进行分开
  @Value("#{'${ignoreUrl}'.split(',')}")
    private List<String> ignoreUrl;

    @Bean
    public ResourcesInterceptor resourcesInterceptor(){
        return new ResourcesInterceptor(ignoreUrl);
    }
    /*
     * 在注册的拦截器类中添加自定义拦截器
     * addPathPatterns()方法设置拦截的路径
     * excludePathPatterns()方法设置不拦截的路径
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(resourcesInterceptor())//自定义好的拦截器处理类进行注册
                //拦截所有请求
                .addPathPatterns("/n")
//不拦截
                .excludePathPatterns("/css/**","/js/**","/img/**");
    }

    /*
     *开启对静态资源的访问
     * 类似在Spring MVC的配置文件中设置<mvc:default-servlet-handler/>元素
     */
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/admin/",".jsp");
    }
//请求视图文件的前缀地址admin 后缀.jsp
}




