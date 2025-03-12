package com.grassau.GrassauTime.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;


/**
 * Configuration class for Spring Security.
 * Defines security rules, authentication, and authorization settings.
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    private final UserDetailsService userDetailsService;

    /**
     * Constructor-based dependency injection for CustomUserDetailsService.
     * @param userDetailsService Custom implementation of UserDetailsService.
     */
    public WebSecurityConfig(CustomUserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    /**
     * Configures security rules for HTTP requests, login, logout, and error handling.
     * @param http HttpSecurity object to configure security settings.
     * @return SecurityFilterChain instance with defined security configurations.
     * @throws Exception If any configuration error occurs.
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/", "/welcome", "/scan", "/styles/**", "/js/**", "/images/**",
                                "web/controllers/WelcomeController",
                                "/createAccount", "web/controllers/CreateAccountController",
                                "error/**",
                                "/createAccount/add").permitAll() // Allow these paths without login
                        .requestMatchers("/admin/**").hasRole("ADMINISTRATOR") // Only accessible by ADMINISTRATOR role
                        .requestMatchers("/employee/**").hasRole("USER") // Only accessible by USER role
                        .anyRequest().authenticated() // Everything else requires authentication
                )
                .formLogin(login -> login
                        .loginPage("/login") // Custom login page
                        .defaultSuccessUrl("/home", true)
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout") // logout endpoint
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()
                )
                .exceptionHandling(exception -> exception
                        .accessDeniedPage("/error/403") // Custom access denied page
                );

        return http.build();
    }

    /**
     * Defines a password encoder using BCrypt hashing algorithm.
     * @return BCryptPasswordEncoder instance.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * Provides an AuthenticationManager bean.
     * @param authenticationConfiguration Authentication configuration object.
     * @return AuthenticationManager instance.
     * @throws Exception If any error occurs during configuration.
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }
}
