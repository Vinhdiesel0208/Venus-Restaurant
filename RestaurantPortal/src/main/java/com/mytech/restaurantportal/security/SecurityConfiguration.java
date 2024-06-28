package com.mytech.restaurantportal.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.mytech.restaurantportal.filters.AuthTokenFilter;
import com.mytech.restaurantportal.helpers.AppConstant;
import com.mytech.restaurantportal.security.handlers.OnAuthenticationFailedHandler;
import com.mytech.restaurantportal.security.handlers.OnAuthenticationSuccessHandler;
import com.mytech.restaurantportal.security.jwt.AuthEntryPointJwt;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(jsr250Enabled = true)
public class SecurityConfiguration {

    @Autowired
    private AuthEntryPointJwt unauthorizedHandler;

    @Autowired
    private AppUserDetailsService userDetailsService;

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    AuthTokenFilter authenticationJwtTokenFilter() {
        return new AuthTokenFilter();
    }

    @Bean
    DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.addFilterBefore(authenticationJwtTokenFilter(), UsernamePasswordAuthenticationFilter.class);

        http.authorizeHttpRequests((authorize) -> authorize
        		.requestMatchers("/apis/v1/customer/get").permitAll() // Cho phép truy cập công khai
                .requestMatchers("/apis/v1/customer/redeem-points").permitAll()
                .requestMatchers("/apis/v1/customer/update-points").permitAll() 
                .requestMatchers("/apis/v1/customer/update-points-and-send-email").permitAll() // Thêm dòng này
                .requestMatchers("/apis/v1/ingredients/**").permitAll() //
                .requestMatchers("/apis/v1/tables/list").permitAll()
                .requestMatchers("/apis/v1/chef/checkout/**").permitAll()  
                .requestMatchers("/apis/v1/payment/**").permitAll() // 
                .requestMatchers("/apis/v1/chef/updateCartLineQuantity/**").permitAll()
                .requestMatchers("/apis/v1/ingredients/search").permitAll()
                
                .requestMatchers("/apis/v1/tables/{tableId}/checkin").hasAuthority(AppConstant.STAFF)
                .requestMatchers("/apis/v1/tables/{tableId}/checkout").hasAuthority(AppConstant.STAFF)
                .requestMatchers("/apis/v1/chef/dishes").hasAnyAuthority(AppConstant.ADMIN, AppConstant.CHEF,AppConstant.STAFF)
                .requestMatchers("/apis/v1/chef/updateStatus").hasAnyAuthority(AppConstant.CHEF)
                .requestMatchers("/apis/v1/chef/addToCart").hasAuthority(AppConstant.STAFF) // Thêm dòng này
                .requestMatchers("/apis/v1/chef/cartLines/{tableId}").hasAuthority(AppConstant.STAFF) // Updated line)
                .requestMatchers("/apis/v1/chef/cartLine/{cartLineId}").hasAuthority(AppConstant.STAFF)
                
                
                .requestMatchers("/chef/**").hasAuthority(AppConstant.CHEF)
                .requestMatchers("/apis/v1/signin", "/apis/test/**", "/files/**", "/forgot_password", "/reset_password", "/apis/v1/users",
                        "/apis/v1/ingredients", "/apis/v1/ingredients/**","/apis/v1/workschedules/**",
                        "/apis/v1/posts/search", "/apis/v1/posts/**", "/apis/v1/contacts/**","/apis/v1/bookingtable/**","/apis/v1/order/**","/apis/v1/staffchedules/**").permitAll()
                .anyRequest().authenticated())
            .formLogin(login -> login.permitAll().loginPage("/login").usernameParameter("email")
                    .passwordParameter("password").loginProcessingUrl("/dologin")
                    .successHandler(new OnAuthenticationSuccessHandler())
                    .failureHandler(new OnAuthenticationFailedHandler()))
            .logout(logout -> logout.permitAll()).exceptionHandling(handling -> handling.accessDeniedPage("/403"))
            .rememberMe(config -> config.key("asdfghjklmnbvcxz").tokenValiditySeconds(7 * 24 * 60 * 60))
            .exceptionHandling(exception -> {
                exception.authenticationEntryPoint(unauthorizedHandler);
            }).csrf(csrf -> csrf.disable());

        http.authenticationProvider(authenticationProvider());

        return http.build();
    }


    @Bean
    AuthenticationManager authenticationManager() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return new ProviderManager(authProvider);
    }

    @Bean
    WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers("/assets/**","/files/**");     
    }
}
