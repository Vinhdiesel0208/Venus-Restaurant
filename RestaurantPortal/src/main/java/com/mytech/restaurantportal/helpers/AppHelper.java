package com.mytech.restaurantportal.helpers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import jakarta.servlet.http.HttpServletRequest;

public class AppHelper {
	
	public static String getSiteURL(HttpServletRequest request) {
		String siteURL = request.getRequestURL().toString();
		
		return siteURL.replace(request.getServletPath(), "");
	}
	
	public static String encode(String text) {
		return Base64.getEncoder().encodeToString(text.getBytes());
	}
	
	public static String encodeUrlValue(String value) {
        try {
            return URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
        } catch (UnsupportedEncodingException ex) {
            throw new RuntimeException(ex.getCause());
        }
    }
}