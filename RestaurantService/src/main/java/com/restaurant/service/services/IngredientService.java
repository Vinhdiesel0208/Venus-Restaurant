package com.restaurant.service.services;

import java.math.BigDecimal;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.restaurant.service.dtos.IngredientDTO;
import com.restaurant.service.entities.FCategory;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.enums.IngredientStatus;
import com.restaurant.service.exceptions.ProductNotFoundException;
import com.restaurant.service.helpers.AppConstant;
import com.restaurant.service.mappers.IngredientMapper;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.repositories.FCategoryRepository;
import com.restaurant.service.repositories.IngredientRepository;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class IngredientService {
	@Autowired
	private IngredientRepository ingredientRepo;

	@Autowired
	private FCategoryRepository fcategoryRepo;

	@Autowired
	private IngredientMapper ingredientMapper;

	public void listIngByPage(int pageNum, int pageCount, PagingAndSortingHelper helper) {
		helper.listEntities(pageNum, pageCount, ingredientRepo);
	}

	public List<Ingredient> getAllIngredient() {
		return ingredientRepo.findAll();
	}

	public List<Ingredient> Ingredient(int pageNum) {
		Pageable pageable = PageRequest.of(pageNum, AppConstant.pageSize);
		return ingredientRepo.findAll(pageable).getContent();
	}

	public List<FCategory> listCategory() {
		return (List<FCategory>) fcategoryRepo.findAll();
	}

	
	public List<Ingredient> search(String searchText) {
		return ingredientRepo.search(searchText);
	}
	
	public Ingredient findById(Long id) {
		return ingredientRepo.findById(id).orElse(null);
	}
	
	public void updateIngredient(String ingredientName, BigDecimal price, Long id) {
		ingredientRepo.updateIngredient(ingredientName, price, id);
	}

	public Ingredient save(Ingredient ingredient) {

		return ingredientRepo.save(ingredient);
	}

	public List<Ingredient> getAllIngredientWithCategoryAndUnit() {
		return ingredientRepo.findAllWithCategoryAndUnit();
	}

	@Transactional
	public void saveIngredient(IngredientDTO ingredientDTO) {

		FCategory category = fcategoryRepo.findById(ingredientDTO.getCategoryId()).orElseThrow(
				() -> new EntityNotFoundException("Category not found with id: " + ingredientDTO.getCategoryId()));

		Ingredient ingredient = new Ingredient();
		ingredient.setIngredientName(ingredientDTO.getIngredientName());
		ingredient.setIngredientCode(ingredientDTO.getIngredientCode());
		ingredient.setCategory(category);
		ingredient.setWeight(ingredientDTO.getWeight());
		ingredient.setHalfPortionAvailable(ingredientDTO.isHalfPortionAvailable());
		ingredient.setDescription(ingredientDTO.getDescription());
		ingredient.setQuantityInStock(ingredientDTO.getQuantityInStock());
		ingredient.setDefaultQuantity(ingredientDTO.getDefaultQuantity());
		ingredient.setPrice(ingredientDTO.getPrice());
		ingredient.setPhoto(ingredientDTO.getPhoto());
		ingredient.setStatus(ingredientDTO.getStatus());
		ingredientRepo.save(ingredient);
	}
	//tien
	public Optional<Ingredient> get(Long id) throws ProductNotFoundException {
	    try {
	        return ingredientRepo.findById(id);
	    } catch (NoSuchElementException e) {
	        throw new ProductNotFoundException("Could not find any product with ID " + id);
	    }
	}

	public void updateQuantity(Long ingId, BigDecimal quantity) {
		Ingredient ing = ingredientRepo.findById(ingId)
				.orElseThrow(() -> new EntityNotFoundException("ing not found with id: " + ingId));
		if (ing != null) {
			BigDecimal newQuantity = ing.getQuantityInStock().add(quantity);
			ing.setQuantityInStock(newQuantity);
			ing.setStatus(IngredientStatus.Available);
			ingredientRepo.save(ing);
		}
	}

	public void delete(Long id) throws ProductNotFoundException {
		Long countById = ingredientRepo.countById(id);
		if (countById == null || countById == 0) {
			throw new ProductNotFoundException("Could not find any product with ID " + id);
		}
		ingredientRepo.deleteById(id);
	}
	public void updateIngredientStatus(Long id, IngredientStatus status) {
	    try {
	        Ingredient ing = ingredientRepo.findById(id).orElseThrow(() -> new EntityNotFoundException("Ingredient not found with id: " + id));
	        ing.setStatus(status);
	        ingredientRepo.save(ing);
	        System.out.println("Updated Ingredient ID: " + id + " to status: " + status);
	    } catch (Exception e) {
	        System.out.println("Error updating Ingredient status: " + e.getMessage());
	        throw e;
	    }
	}
	public Page<Ingredient> searchByIngredientName(String ingredientName, int pageNum, int pageSize, String sortField,
			String sortDir) {
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize,
				sortDir.equals("asc") ? Sort.by(sortField).ascending() : Sort.by(sortField).descending());

		return ingredientRepo.findByIngredientNameContainingIgnoreCase(ingredientName, pageable);
	}
	@Transactional
    public void updateDailyQuantities() {
        List<Ingredient> ingredients = ingredientRepo.findAll();
        for (Ingredient ingredient : ingredients) {
        
        	if(ingredient.getStatus().equals(IngredientStatus.NotAvailable)) {
        		continue;
        	}
            ingredient.setQuantityInStock(ingredient.getDefaultQuantity());
            ingredient.setStatus(IngredientStatus.Available);
        }
        ingredientRepo.saveAll(ingredients);
    }
	//vinh
		 public List<Ingredient> searchIngredients(String keyword, Long categoryId) {
		        if (keyword != null && !keyword.isEmpty() && categoryId != null) {
		            return ingredientRepo.findByCategoryAndNameLike(categoryId, keyword.toLowerCase());
		        } else if (keyword != null && !keyword.isEmpty()) {
		            return ingredientRepo.findByNameLike(keyword.toLowerCase());
		        } else if (categoryId != null) {
		            return ingredientRepo.findByCategory(categoryId);
		        } else {
		            return ingredientRepo.findAll();
		        }
		    }
		 public List<Ingredient> searchByKeyword(String keyword) {
		        // Using method in IngredientRepository to perform the search
		        return ingredientRepo.findByIngredientNameContainingIgnoreCase(keyword);
		    }
		 public Page<Ingredient> getAllIngredientsWithPagination(Pageable pageable) {
			    return ingredientRepo.findAll(pageable);
			}


}
