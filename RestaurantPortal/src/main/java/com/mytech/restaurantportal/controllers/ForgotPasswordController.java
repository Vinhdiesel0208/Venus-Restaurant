package com.mytech.restaurantportal.controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mytech.restaurantportal.helpers.AppHelper;
import com.mytech.restaurantportal.mailer.EmailService;
import com.restaurant.service.entities.User;
import com.restaurant.service.exceptions.UserNotFoundException;
import com.restaurant.service.services.UserService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ForgotPasswordController {
	
	@Autowired 
	private UserService userService;
	
	@Autowired
  public EmailService emailService;
	
	
	@GetMapping("/forgot_password")
	public String showRequestForm() {
		return "authentication/reset-password";
	}
	
	@PostMapping("/forgot_password")
	public String processRequestForm(HttpServletRequest request, Model model) {
		String email = request.getParameter("email");
		try {
			String token = userService.updateResetPasswordToken(email);
			String link = AppHelper.getSiteURL(request) + "/reset_password?token=" + token;
			sendEmail(link, email);
		} catch (UnsupportedEncodingException | MessagingException e) {
			model.addAttribute("error", "Could not send email");
		} catch (UserNotFoundException e) {
			e.printStackTrace();
		}
		
		return "authentication/reset-password-sent";
	}
	
	private void sendEmail(String link, String email) throws UnsupportedEncodingException, MessagingException {

		String subject = "[The Bags] link to reset your password";
		
		try {
			Map<String, Object> templateModel = new HashMap<>();
	        templateModel.put("recipientName", email);
	        templateModel.put("text", "Click on the link below to reset your password: \n" + link);
	        templateModel.put("senderName", "noreply@thebags.com");
			emailService.sendMessageUsingThymeleafTemplate("ngocanhbui121093@gmail.com", subject, templateModel);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/reset_password")
	public String showResetForm(@RequestParam(name = "token") String token, Model model) {
		User user = userService.getByResetPasswordToken(token);
		if (user != null) {
			model.addAttribute("token", token);
		} else {
			model.addAttribute("message", "Invalid or expired Token");
			return "authentication/reset-password-failed";
		}
		
		return "authentication/new-password";
	}
	
	@PostMapping("/reset_password")
	public String processResetForm(@RequestParam(name = "token") String token, @RequestParam(name = "password") String password, Model model) {
		userService.updatePassword(token, password);
		
		return "authentication/password-confirmation";		
	}
	
	@GetMapping("/change_password/{id}")
	public String showChangeForm(@PathVariable(name = "id") int id, Model model) {
		model.addAttribute("id", id);
		return "authentication/change-password";
	}
	
	@PostMapping("/change_password")
	public String processChangeForm(@RequestParam(name = "id") int id, @RequestParam(name = "password") String password, Model model) {
		userService.updatePassword(id, password);
		
		return "authentication/password-confirmation";		
	}
}