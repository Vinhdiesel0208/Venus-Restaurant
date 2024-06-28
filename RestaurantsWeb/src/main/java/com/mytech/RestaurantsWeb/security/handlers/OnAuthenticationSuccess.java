package com.mytech.RestaurantsWeb.security.handlers;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.mytech.RestaurantsWeb.security.CustomerOAuth2User;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.enums.AuthenticationType;
import com.restaurant.service.services.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class OnAuthenticationSuccess extends SimpleUrlAuthenticationSuccessHandler {

	@Autowired
	private CustomerService customerService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		CustomerOAuth2User oauth2User = (CustomerOAuth2User) authentication.getPrincipal();
		
		String name = oauth2User.getName();
		String email = oauth2User.getEmail();
		String clientName = oauth2User.getClientName();
		
		AuthenticationType authenticationType = getAuthenticationType(clientName);
		
		Customer customer = customerService.getCustomerByEmail(email);
		if (customer == null) {
			customerService.registerCustomerOAuth2(name, email, authenticationType);
		} else {
			oauth2User.setFullName(customer.getFullName());
			customerService.updateAuthenticationType(customer, authenticationType);
		}
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
	private AuthenticationType getAuthenticationType(String clientName) {
		if (clientName.equals("Google")) {
			return AuthenticationType.GOOGLE;
		} else if (clientName.equals("Facebook")) {
			return AuthenticationType.FACEBOOK;
		} else {
			return AuthenticationType.DATABASE;
		}
	}
}
