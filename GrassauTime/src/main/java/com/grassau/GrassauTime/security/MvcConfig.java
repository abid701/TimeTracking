package com.grassau.GrassauTime.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Configuration class for mapping view controllers to specific URLs.
 *
 * This is used to directly map URLs to views without requiring explicit controller methods.
 * It is useful for static pages that do not require backend logic, such as login and welcome pages.
 * This improves performance and reduces boilerplate code for simple view resolution.
 */
@Configuration
public class MvcConfig implements WebMvcConfigurer {

    /**
     * Adds view controllers to the registry for direct mapping without requiring a controller.
     * This is beneficial for static pages that do not require any backend processing.
     * @param registry ViewControllerRegistry instance.
     */
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/welcome").setViewName("view/welcome");
        registry.addViewController("/").setViewName("view/welcome");
        registry.addViewController("/home").setViewName("view/home");
        registry.addViewController("/login").setViewName("view/login");
        registry.addViewController("/employee").setViewName("view/employee");
    }

}
