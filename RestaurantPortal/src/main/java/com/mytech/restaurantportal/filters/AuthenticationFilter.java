package com.mytech.restaurantportal.filters;

import java.io.IOException;

import org.springframework.core.annotation.Order;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.mytech.restaurantportal.security.AppUserDetails;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
@Order(2)
public class AuthenticationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		String path = httpRequest.getRequestURI();

		if (!path.startsWith("/apis/")) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();

			if (auth != null && !path.contains("change_password") && !path.contains("logout")
					&& !path.contains("login")) {
				Object principal = auth.getPrincipal();

				if (principal instanceof AppUserDetails) {
					AppUserDetails userDetails = (AppUserDetails) principal;
					System.out.println("Change passoword:" + userDetails.isChangePassword());

					if (response instanceof HttpServletResponse && userDetails.isChangePassword()) {
						HttpServletResponse httpResponse = (HttpServletResponse) response;
						httpResponse.sendRedirect("/change_password/" + userDetails.getId());
						return;
					}
				}
			}
		}

		chain.doFilter(request, response);
	}

}
