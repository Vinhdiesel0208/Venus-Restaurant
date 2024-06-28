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
import com.restaurant.service.entities.TCategory;
import com.restaurant.service.services.FCategoryService;
import com.restaurant.service.services.TCategoryService;

@Controller
@RequestMapping("/tcategory")
public class TCategoryController {
	private String defaultRedirectURL = "redirect:/tcategory/page/1?sortField=email&sortDir=asc";
	
	 @Autowired
	    private TCategoryService tCategoryService;
	 
	

   
	    @GetMapping("")
	    public String getUnitList(Model model) {
	        List<TCategory> listCategories = tCategoryService.getAllCategory();

	        model.addAttribute("listCategories", listCategories);
	        model.addAttribute("currentPage", "1");
	        model.addAttribute("sortField", "categoryName");
	        model.addAttribute("sortDir", "asc");
	        model.addAttribute("reverseSortDir", "desc");
	        model.addAttribute("searchText", "");
	        model.addAttribute("moduleURL", "/category");

	        return "/apps/tcategory/list";
	    }

	    
	    @GetMapping("/add")
	    public String addCategory(Model model) {
	        FCategory fCategory = new FCategory();

	        model.addAttribute("fcategory",fCategory);

	        return "/apps/tcategory/add";
	    }

	    @PostMapping("/add")
	    public String saveCategory(TCategory tCategory, RedirectAttributes redirectAttributes) {
	       
	    	tCategoryService.createCategory(tCategory);

	        redirectAttributes.addFlashAttribute("message", "The role has been added successfully.");

	        return "redirect:/tcategory";
	    }
}
