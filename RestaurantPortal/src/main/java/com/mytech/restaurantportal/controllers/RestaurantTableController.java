package com.mytech.restaurantportal.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.entities.TCategory;
import com.restaurant.service.repositories.TCategoryRepository;
import com.restaurant.service.services.IngredientService;
import com.restaurant.service.services.RestaurantTableService;
import com.restaurant.service.services.TCategoryService;

import jakarta.persistence.EntityNotFoundException;

@Controller
@RequestMapping("/tables")
public class RestaurantTableController {
	private String defaultRedirectURL = "redirect:/tables/page/1?sortField=name&sortDir=asc";
	 @Autowired
	    private RestaurantTableService restaurantTableService;

	    @Autowired
	    private  IngredientService  ingredientService;  
	    
	    @Autowired
	    public TCategoryService tCategoryService;
	    
	    @Autowired
	    public TCategoryRepository tcategoryRepo ;

	   

	    @GetMapping("")
	    public String getTableList(Model model) {
	        List<RestaurantTable> listTable = restaurantTableService.getAllIngredientWithCategoryAndUnit();
	        List<TCategory> listCate =  tCategoryService.getAllCategory();
	        model.addAttribute("listTable", listTable);
	        model.addAttribute("listCate", listCate); 
	        model.addAttribute("currentPage", "1");
	        model.addAttribute("sortField", "name");
	        model.addAttribute("sortDir", "asc");
	        model.addAttribute("reverseSortDir", "desc");
	        model.addAttribute("searchText", "");
	        model.addAttribute("moduleURL", "/table");

	        return "/apps/tables/list";
	    }

	    
	    @GetMapping("/add")
	    public String addTable(Model model) {
	    	RestaurantTable restaurantTable = new RestaurantTable();

	        model.addAttribute("restaurantTable", restaurantTable);

	        return "/apps/tables/add";
	    }

	    @PostMapping("/add")
	    public ResponseEntity<Map<String, String>> saveRestaurantTable(@RequestParam("category_id") Long categoryId, RestaurantTable restaurantTable, RedirectAttributes redirectAttributes) {
	        Map<String, String> response = new HashMap<>();
	        HttpStatus status;

	        if (restaurantTableService.isTableNumberExists(restaurantTable.getTableNumber())) {
	            response.put("error", "Table number already exists.");
	            status = HttpStatus.BAD_REQUEST;
	        } else {
	            TCategory category = tcategoryRepo.findById(categoryId).orElse(null);
	            if (category == null) {
	                throw new EntityNotFoundException("Category not found with id: " + categoryId);
	            }

	            restaurantTable.setCategory(category);
	            restaurantTableService.createTable(restaurantTable);
	            response.put("message", "The table has been added successfully.");
	            response.put("redirectUrl", "/tables"); 
	            status = HttpStatus.OK;
	        }

	        return new ResponseEntity<>(response, status);
	    }
	    
	    @GetMapping("/edit")
	    public String editTable(@RequestParam("id") Long id, Model model) {
	        RestaurantTable restaurantTable = restaurantTableService.getRestaurantTableById(id);
	        List<TCategory> listCate =  tCategoryService.getAllCategory();
	      
	        model.addAttribute("listCate", listCate); 
	        if (restaurantTable == null) {
	            throw new EntityNotFoundException("Table not found with id: " + id);
	        }
	        model.addAttribute("category_id", restaurantTable.getCategory().getId());

	        model.addAttribute("restaurantTable", restaurantTable);
	        return "/apps/tables/edit";
	    }

	    @PostMapping("/update")
	    public String updateTable(@RequestParam("id") Long id, 
	                              @RequestParam("category_id") Long categoryId, 
	                              RestaurantTable updatedRestaurantTable, 
	                              RedirectAttributes redirectAttributes) {
	       
	        RestaurantTable existingTable = restaurantTableService.getRestaurantTableById(id);
	        if (existingTable == null) {
	          
	            redirectAttributes.addFlashAttribute("error", "Table not found with id: " + id);
	            return "redirect:/tables";
	        } else {
	          
	            TCategory category = tcategoryRepo.findById(categoryId).orElse(null);
	            if (category == null) {
	                throw new EntityNotFoundException("Category not found with id: " + categoryId);
	            }
	            
	         
	            updatedRestaurantTable.setId(existingTable.getId());
	            updatedRestaurantTable.setCategory(category);
	            
	           	            restaurantTableService.updateRestaurantTable(id, updatedRestaurantTable);
	            
	            
	            redirectAttributes.addFlashAttribute("message", "The table has been updated successfully.");
	            return "redirect:/tables";
	        }
	    }


	    @GetMapping("/delete")
	    public ResponseEntity<Map<String, String>> deleteTable(@RequestParam("id") Long id) {
	        Map<String, String> response = new HashMap<>();
	        HttpStatus status;

	        RestaurantTable existingTable = restaurantTableService.getRestaurantTableById(id);
	        if (existingTable == null) {
	            response.put("error", "Table not found with id: " + id);
	            status = HttpStatus.NOT_FOUND;
	        } else {
	            restaurantTableService.deleteRestaurantTable(id);
	            response.put("message", "The table has been deleted successfully.");
	            status = HttpStatus.OK;
	        }

	        return new ResponseEntity<>(response, status);
	    }





}
