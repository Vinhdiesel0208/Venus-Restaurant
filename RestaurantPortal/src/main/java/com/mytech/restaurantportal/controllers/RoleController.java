package com.mytech.restaurantportal.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itextpdf.text.DocumentException;
import java.util.List;
import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.entities.Role;
import com.restaurant.service.services.RoleService;
import com.restaurant.service.services.UserService;

import io.jsonwebtoken.io.IOException;

@Controller
@RequestMapping("/roles")
public class RoleController {
	private String defaultRedirectURL = "redirect:/roles/page/1?sortField=name&sortDir=asc";
	 @Autowired
	    private RoleService roleService;

	    @Autowired
	    private UserService userService;  // Assuming you have a UserService for user-related operations

	    private final StorageService storageService;

	    @Autowired
	    public RoleController(StorageService storageService) {
	        this.storageService = storageService;
	    }

	    @GetMapping("")
	    public String getRoleList(Model model) {
	        List<Role> listRoles = roleService.getAllRoles();

	        model.addAttribute("listRoles", listRoles);
	        model.addAttribute("currentPage", "1");
	        model.addAttribute("sortField", "name");
	        model.addAttribute("sortDir", "asc");
	        model.addAttribute("reverseSortDir", "desc");
	        model.addAttribute("searchText", "");
	        model.addAttribute("moduleURL", "/roles");

	        return "/apps/roles/list";
	    }

	    
	    @GetMapping("/add")
	    public String addRole(Model model) {
	        Role role = new Role();

	        model.addAttribute("role", role);

	        return "/apps/roles/add";
	    }

	    @PostMapping("/add")
	    public String saveRole(Role role, RedirectAttributes redirectAttributes) {
	        // Add validation or business logic as needed
	        roleService.createRole(role);

	        redirectAttributes.addFlashAttribute("message", "The role has been added successfully.");

	        return "redirect:/roles";
	    }



	   
	}