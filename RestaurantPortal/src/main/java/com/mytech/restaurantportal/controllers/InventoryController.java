
package com.mytech.restaurantportal.controllers;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.restaurant.service.entities.FCategory;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.paging.PagingAndSortingParam;
import com.restaurant.service.services.FCategoryService;
import com.restaurant.service.services.IncomeService;
import com.restaurant.service.services.IngredientService;

@Controller
@RequestMapping("/inventory")
public class InventoryController {

	
	@Autowired
    private IncomeService incomeService;
	@Autowired
	private IngredientService ingredientService;

	@Autowired
	public FCategoryService fCategoryService;

	@GetMapping("")
	public String getInventoryList(Model model) {
		model.addAttribute("moduleURL", "/inventory");
		return listByPage(model, 1, "ingredientName", "asc", "");
	}

	@PostMapping("/search")
	public String search(@RequestParam(name = "searchText") String searchText, Model model) {
		return listByPage(model, 1, "ingredientName", "asc", searchText);
	}

	@GetMapping("/storage")
	public String getStorageList(Model model) {
		model.addAttribute("moduleURL", "/inventory");
		return listByPage(model, 1, "ingredientName", "asc", "");
	}

	@GetMapping("/page")
	public String listByPage() {
		return "redirect:/inventory/page/1";
	}

	@GetMapping("/page/{pageNum}")
	public String listByPage(Model model, @PathVariable(name = "pageNum") int pageNum,
			@RequestParam(name = "sortField", defaultValue = "ingredientName", required = false) String sortField,
			@RequestParam(name = "sortDir", defaultValue = "asc", required = false) String sortDir,
			@RequestParam(name = "searchText", defaultValue = "", required = false) String searchText) {

		// Ensure the sortField is a valid attribute of the entity
		String validSortField = validateSortField(sortField);
		PagingAndSortingHelper helper = new PagingAndSortingHelper(model, "listIng", validSortField, sortDir,
				searchText);
		ingredientService.listIngByPage(pageNum, 5, helper);

		List<FCategory> listCate = fCategoryService.getAllCategory();
		model.addAttribute("listCate", listCate);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("sortField", validSortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("moduleURL", "/inventory");
		model.addAttribute("searchText", searchText);
        

		return "/apps/inventory/list";
	}

	private String validateSortField(String sortField) {
		// Replace this with the actual validation logic for your entity
		if ("ingredientName".equals(sortField) || "price".equals(sortField)) {
			return sortField;
		}
		return "ingredientName"; // default sort field
	}

	@PostMapping("/updateQuantity")
	public String updateQuantity(@RequestParam("ingredientId") Long ingredientId,
			@RequestParam("quantity") BigDecimal quantity) {

		System.out.println("Ingredient ID: " + ingredientId);
		ingredientService.updateQuantity(ingredientId, quantity);
		return "redirect:/inventory";
	}
	 @GetMapping("/updateDailyQuantities")
	    public String updateDailyQuantities(Model model) {
	        ingredientService.updateDailyQuantities();
	        return "redirect:/inventory";  // Redirect back to the inventory page
	    }

}
