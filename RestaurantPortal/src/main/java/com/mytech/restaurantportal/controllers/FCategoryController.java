package com.mytech.restaurantportal.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.entities.FCategory;
import com.restaurant.service.services.FCategoryService;

@Controller
@RequestMapping("/category")
public class FCategoryController {
	private String defaultRedirectURL = "redirect:/unit/page/1?sortField=email&sortDir=asc";
	
	 @Autowired
	    private FCategoryService fCategoryService;
	 
	 private final StorageService storageService;

	    @Autowired
	    public FCategoryController(StorageService storageService) {
	        this.storageService = storageService;
	    }

    
	    @GetMapping("")
	    public String getUnitList(Model model) {
	        List<FCategory> listCategories = fCategoryService.getAllCategory();

	        model.addAttribute("listCategories", listCategories);
	        model.addAttribute("currentPage", "1");
	        model.addAttribute("sortField", "categoryName");
	        model.addAttribute("sortDir", "asc");
	        model.addAttribute("reverseSortDir", "desc");
	        model.addAttribute("searchText", "");
	        model.addAttribute("moduleURL", "/category");

	        return "/apps/category/list";
	    }

	    
	    @GetMapping("/add")
	    public String addCategory(Model model) {
	        FCategory fCategory = new FCategory();

	        model.addAttribute("fcategory",fCategory);

	        return "/apps/category/add";
	    }

	    @PostMapping("/add")
	    public String saveCategory(FCategory fCategory, RedirectAttributes redirectAttributes) {
	       
	    	fCategoryService.createCategory(fCategory);

	        redirectAttributes.addFlashAttribute("message", "The role has been added successfully.");

	        return "redirect:/category";
	    }

	    

}
