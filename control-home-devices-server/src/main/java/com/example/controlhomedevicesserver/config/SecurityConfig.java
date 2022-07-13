package com.example.controlhomedevicesserver.config;

import org.springframework.context.annotation.Bean;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import java.util.List;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@EnableWebSecurity
public class SecurityConfig {

    @Bean
    @Order(Ordered.HIGHEST_PRECEDENCE)
    public SecurityFilterChain httpBaiskWebSecurityConfig(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.httpBasic().and()
            .authorizeRequests()
            .antMatchers("/login").permitAll()
            .anyRequest()
            .authenticated();
        return http.build();

    }

    @Bean
    @SuppressWarnings( "deprecation" )
    public InMemoryUserDetailsManager  userDetailsService() {
        UserDetails mobileClient = User.withDefaultPasswordEncoder()
                .username("android")
                .password("password")
                .roles("USER")
                .build();
        UserDetails espClient = User.withDefaultPasswordEncoder()
                .username("esp")
                .password("password")
                .roles("USER")
                .build();
        return new InMemoryUserDetailsManager(List.of(mobileClient,espClient));
    }

}
