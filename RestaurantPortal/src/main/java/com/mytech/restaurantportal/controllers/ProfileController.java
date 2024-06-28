package com.mytech.restaurantportal.controllers;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.restaurantportal.helpers.AppHelper;
import com.mytech.restaurantportal.security.AppUserDetails;
import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.entities.User;
import com.restaurant.service.exceptions.UserNotFoundException;
import com.restaurant.service.services.UserService;

@Controller
@RequestMapping("/profile")
public class ProfileController {
	
	@Autowired
	private UserService userService;
	
	private final StorageService storageService;

	public ProfileController(StorageService storageService) {
		this.storageService = storageService;
	}

	@GetMapping
	public String getUserInfo(@AuthenticationPrincipal AppUserDetails loggedUser, Model model) throws UserNotFoundException {
		User user = userService.get(loggedUser.getId());
		
		model.addAttribute("user", user);

		return "/profile/index";
	}
	
	@PostMapping
	public String updateUserInfo(@RequestParam("avatar") MultipartFile file, User user, RedirectAttributes redirectAttributes) {
		System.out.println("User save: " + user.getFirstName() + " -- " + user.getLastName() + " -- " + user.getEmail()
				+ " -- " + user.isEnabled());

		if (!file.isEmpty()) {
			String fileName = AppHelper.encode(user.getEmail());
			user.setPhoto(fileName);
			storageService.store(file, fileName);

			List<String> files = storageService.loadAll()
					.map(path -> MvcUriComponentsBuilder
							.fromMethodName(PortalController.class, "serveFile", path.getFileName().toString()).build()
							.toUri().toString())
					.collect(Collectors.toList());

			for (String filename : files) {
				System.out.println("Uploaded file: " + filename);
			}
		}

//		User findUser = userService.getByEmail(user.getEmail());
		userService.save(user);
		
		redirectAttributes.addFlashAttribute("message", "The user has been saved successfully.");

		return "redirect:/profile";
	}
}
