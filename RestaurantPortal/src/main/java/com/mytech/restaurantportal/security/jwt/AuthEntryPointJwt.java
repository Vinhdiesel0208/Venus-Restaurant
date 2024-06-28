package com.mytech.restaurantportal.security.jwt;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mytech.restaurantportal.security.jwt.AuthEntryPointJwt;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthEntryPointJwt implements AuthenticationEntryPoint {

	private static final Logger logger = LoggerFactory.getLogger(AuthEntryPointJwt.class);

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		logger.error("Unauthorized error: {}", authException.getMessage());

		String path = request.getServletPath();

		System.out.println("PATH: " + path);

		if (path.contains("apis")) {
			response.setContentType(MediaType.APPLICATION_JSON_VALUE);
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

			final Map<String, Object> body = new HashMap<>();
			body.put("status", HttpServletResponse.SC_UNAUTHORIZED);
			body.put("error", "Unauthorized");
			body.put("message", authException.getMessage());
			body.put("path", request.getServletPath());

			final ObjectMapper mapper = new ObjectMapper();
			mapper.writeValue(response.getOutputStream(), body);
		} else if (path.contains("error")) {
			response.setContentType(MediaType.APPLICATION_JSON_VALUE);
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

			final Map<String, Object> body = new HashMap<>();
			body.put("status", HttpServletResponse.SC_FORBIDDEN);
			body.put("error", "Forbidden");
			body.put("message", authException.getMessage());
			body.put("path", request.getServletPath());

			final ObjectMapper mapper = new ObjectMapper();
			mapper.writeValue(response.getOutputStream(), body);
		} else {
			response.sendRedirect("/login");
		}
	}
}