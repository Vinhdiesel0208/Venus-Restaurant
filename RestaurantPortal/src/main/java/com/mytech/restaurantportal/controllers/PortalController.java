package com.mytech.restaurantportal.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.mytech.restaurantportal.security.AppUserDetails;
import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.entities.User;
import com.restaurant.service.services.UserService;

import jakarta.validation.Valid;

@Controller
public class PortalController {

	@Autowired
	private UserService userService;
	
	private final StorageService storageService;
	
	public PortalController(StorageService storageService) {
		this.storageService = storageService;
	}
	
	@GetMapping("/files/{filename:.+}")
	@ResponseBody
	public ResponseEntity<Resource> serveFile(@PathVariable("filename") String filename) {

		Resource file = storageService.loadAsResource(filename);
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
				.body(file);
	}
	

	@GetMapping("/")
	public String getHome(@AuthenticationPrincipal AppUserDetails loggedUser) {
		
		if (loggedUser.hasRole(AppConstant.ADMIN)) {
			return "/dashboards/ecommerce";
		} else {
			return "index";
		}
	}

	@GetMapping("/dashboard")
	public String getDashboard(Model model) {
		return "/dashboards/ecommerce";
	}

	@GetMapping("/lang")
	public String getLang(Model model) {
		return "/index";
	}

	@GetMapping("/login")
	public String getLogin(Model model) {
		model.addAttribute("user", new User());

		return "/authentication/sign-in";
	}

	@GetMapping("/register")
	public String getRegister(Model model) {
		model.addAttribute("user", new User());

		return "/authentication/sign-up";
	}

	@PostMapping("/register")
	public String createCustomer(@Valid User user, BindingResult bindingResult, Model model) {
		System.out.println("User: " + user.getFirstName() + " -- " + user.getLastName());
		if (bindingResult.hasErrors()) {
			return "/authentication/sign-up";
		}
		userService.save(user);

		return "redirect:/login";
	}
}