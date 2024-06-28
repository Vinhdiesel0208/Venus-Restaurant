package com.mytech.restaurantportal.apis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.restaurant.service.entities.User;
import com.restaurant.service.services.UserService;



@RestController
@RequestMapping({"/apis/v1/users", "/apis/test/users"})
public class UserRestController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping
	public List<User> getAllUsers() {
		return userService.getAllUsers();
	}
}
