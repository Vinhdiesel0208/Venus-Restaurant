
package com.mytech.restaurantportal.controllers;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.mytech.restaurantportal.helpers.AppHelper;
import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.dtos.IngredientDTO;
import com.restaurant.service.entities.FCategory;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.enums.IngredientStatus;
import com.restaurant.service.exceptions.ProductNotFoundException;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.paging.PagingAndSortingParam;
import com.restaurant.service.services.FCategoryService;
import com.restaurant.service.services.IngredientService;

@Controller
@RequestMapping("/dishes")
public class IngredientController {

	private String defaultRedirectURL = "redirect:/dishes/page/1?sortField=ingredientName&sortDir=asc";

	@Autowired
	private IngredientService ingredientService;

	@Autowired
	public FCategoryService fCategoryService;

	private final StorageService storageService;

	public IngredientController(StorageService storageService) {
		this.storageService = storageService;
	}

	@GetMapping("")
	public String getIngredientList(Model model) {
		model.addAttribute("moduleURL", "/dishes"); // Adjust according to your mapping
		return listByPage(model, 1, "ingredientName", "asc","");
	}

	@GetMapping("/page")
	public String listByPage() {
		return "redirect:/dishes/page/1";
	}

	@GetMapping("/page/{pageNum}")
	public String listByPage(Model model, @PathVariable(name = "pageNum") int pageNum,
			@RequestParam(name = "sortField", defaultValue = "ingredientCode", required = false) String sortField,
			@RequestParam(name = "sortDir", defaultValue = "asc", required = false) String sortDir,
			@RequestParam(name = "searchText", defaultValue = "", required = false) String searchText){

		// Ensure the sortField is a valid attribute of the entity
		String validSortField = validateSortField(sortField);
		PagingAndSortingHelper helper = new PagingAndSortingHelper(model, "listIng", validSortField, sortDir, searchText);
		ingredientService.listIngByPage(pageNum, 5, helper);

		List<FCategory> listCate = fCategoryService.getAllCategory();
		model.addAttribute("listCate", listCate);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("sortField", validSortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("moduleURL", "/dishes");
		model.addAttribute("searchText", searchText);

		return "/apps/dishes/list";
	}

	private String validateSortField(String sortField) {
		// Replace this with the actual validation logic for your entity
		if ("ingredientCode".equals(sortField) || "ingredientName".equals(sortField)|| "price".equals(sortField)) {
			return sortField;
		}
		return "ingredientName"; // default sort field
	}
	 @PostMapping("/search")
	    public String search(@RequestParam(name = "searchText") String searchText, Model model) {
	        return listByPage(model, 1, "ingredientName", "asc", searchText);
	 }
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, Model model) throws ProductNotFoundException {

		List<FCategory> listCate = fCategoryService.getAllCategory();
		Optional<Ingredient> ingredientOptional = ingredientService.get(id);

		if (ingredientOptional.isPresent()) {
			Ingredient ingredient = ingredientOptional.get();
			model.addAttribute("ingredient", ingredient);
		}
		model.addAttribute("listCate", listCate);
		return "/apps/dishes/edit";
	}

	@PostMapping("/update")
	public String updateIngredient(@RequestParam("ingredientName") String ingredientName,
			@RequestParam("price") BigDecimal price, @RequestParam("photo") MultipartFile photo,
			@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
		Ingredient ingredient = ingredientService.findById(id);
		if (!photo.isEmpty()) {
			String fileName = AppHelper.encode(ingredient.getIngredientName());
			ingredient.setPhoto(fileName);
			storageService.store(photo, fileName);

			List<String> files = storageService.loadAll()
					.map(path -> MvcUriComponentsBuilder
							.fromMethodName(PortalController.class, "serveFile", path.getFileName().toString()).build()
							.toUri().toString())
					.collect(Collectors.toList());

			for (String filename : files) {
				System.out.println("Uploaded file: " + filename);
			}
		}
		ingredientService.updateIngredient(ingredientName, price, id);
		redirectAttributes.addFlashAttribute("message", "The ingredient has been updated successfully.");
		return "redirect:/dishes";
	}

	@GetMapping("/add")
	public String add(Model model) {

		List<FCategory> listCate = fCategoryService.getAllCategory();

		Ingredient ingredient = new Ingredient();

		model.addAttribute("ingredient", ingredient);

		model.addAttribute("listCate", listCate);

		return "/apps/dishes/add";
	}

	@PostMapping("/add")
	public String saveIngredient(@RequestParam(name = "ingredientName") String ingredientName,
			@RequestParam(name = "ingredientCode", required = false) String ingredientCode,
			@RequestParam("avatar") MultipartFile file,
			@RequestParam(name = "description", required = false) String description,
			@RequestParam(name = "halfPortionAvailable", required = false, defaultValue = "false") boolean halfPortionAvailable,
			@RequestParam(name = "categoryId") Long categoryId,
			@RequestParam(name = "quantityInStock", required = false) BigDecimal quantityInStock,
			@RequestParam(name = "price", required = false) BigDecimal price,
			@RequestParam(name = "status", required = false, defaultValue = "Available") IngredientStatus status) {
		System.out.println(
				"Ingredient save: " + ingredientName + " -- " + ingredientCode + " -- CategoryId: " + categoryId);

		IngredientDTO ingredientDTO = new IngredientDTO();
		ingredientDTO.setIngredientName(ingredientName);
		ingredientDTO.setIngredientCode(ingredientCode);
		if (!file.isEmpty()) {
			String fileName = AppHelper.encode(ingredientDTO.getIngredientName());
			ingredientDTO.setPhoto(fileName);
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
		ingredientDTO.setHalfPortionAvailable(halfPortionAvailable);
		ingredientDTO.setDescription(description);
		ingredientDTO.setCategoryId(categoryId);
		ingredientDTO.setQuantityInStock(quantityInStock);
		ingredientDTO.setDefaultQuantity(quantityInStock);
		ingredientDTO.setPrice(price);
		ingredientDTO.setStatus(status);
		ingredientService.saveIngredient(ingredientDTO);

		return "redirect:/dishes";
	}

	// tien
	@PostMapping("/updateQuantity")
	public String updateQuantity(@RequestParam("ingredientId") Long ingredientId,
			@RequestParam("quantity") BigDecimal quantity) {

		System.out.println("Ingredient ID: " + ingredientId);
		ingredientService.updateQuantity(ingredientId, quantity);
		return "redirect:/dishes";
	}

	@GetMapping("/delete/{id}")
	public String deleteDish(@PathVariable("id") Long id) throws ProductNotFoundException {
		ingredientService.delete(id);
		return "redirect:/dishes";
	}

	@PostMapping("/updateStatus")
	@ResponseBody
	public ResponseEntity<?> updateStatus(@RequestParam("id") Long id, @RequestParam("status") String status,
	        @RequestParam(value = "force", defaultValue = "false") boolean force) {
	    try {
	        // Chuyển đổi chuỗi status thành Enum
	        IngredientStatus ingStatus = IngredientStatus.valueOf(status);

	        Ingredient ingredient = ingredientService.findById(id);

	        if (ingStatus == IngredientStatus.NotAvailable && !force
	                && ingredient.getQuantityInStock().compareTo(BigDecimal.ZERO) > 0) {
	            return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of("message",
	                    "The quantity still remains. Do you want to continue?", "status", "conflict"));
	        }

	        // Gọi service để cập nhật trạng thái
	        ingredient.setStatus(ingStatus); // Sử dụng setter của Ingredient để thiết lập trạng thái
	        ingredientService.save(ingredient); // Lưu lại nguyên liệu sau khi cập nhật trạng thái

	        return ResponseEntity.ok(Map.of("message", "Updated Success"));
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(Map.of("message", "Updated Failed: " + e.getMessage()));
	    }
	}
	
}
