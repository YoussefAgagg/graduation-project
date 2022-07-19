package com.example.controlhomedevicesserver.config;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import java.util.List;
@EnableWebSecurity
public class SecurityConfig {

    @Bean
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
        UserDetails espClient1 = User.withDefaultPasswordEncoder()
                .username("esp1")
                .password("password")
                .roles("USER")
                .build();
        UserDetails espClient2 = User.withDefaultPasswordEncoder()
            .username("esp2")
            .password("password")
            .roles("USER")
            .build();
        return new InMemoryUserDetailsManager(List.of(mobileClient,espClient1,espClient2));
    }

}
