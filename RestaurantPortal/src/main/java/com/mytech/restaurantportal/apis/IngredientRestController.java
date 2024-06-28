package com.mytech.restaurantportal.apis;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.restaurant.service.dtos.IngredientDTO;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.exceptions.ProductNotFoundException;
import com.restaurant.service.services.IngredientService;

@RestController
@RequestMapping("/apis/v1/ingredients")
@CrossOrigin(origins = "http://localhost:8083")
public class IngredientRestController {
	@Autowired
	private IngredientService ingredientService;
	
	@GetMapping
	public ResponseEntity<List<IngredientDTO>> getAllIngredients() {
		List<Ingredient> ings = ingredientService.getAllIngredientWithCategoryAndUnit();
		List<IngredientDTO> ingDto = ings.stream().map(ing -> {
			IngredientDTO postDTO = IngredientDTO.fromEntity(ing);
			postDTO.setPhoto(AppConstant.imageUrl + ing.getPhoto());
			return postDTO;
		}).collect(Collectors.toList());
		return ResponseEntity.ok(ingDto);
	}
    @GetMapping("/{id}")
    public ResponseEntity<IngredientDTO> getIngredientById(@PathVariable Long id) throws ProductNotFoundException {
        Optional<Ingredient> optionalIngredient = ingredientService.get(id);
        if (optionalIngredient.isPresent()) {
            Ingredient ingredient = optionalIngredient.get();
            IngredientDTO ingredientDTO = IngredientDTO.fromEntity(ingredient);
            ingredientDTO.setPhoto(AppConstant.imageUrl + ingredient.getPhoto());
            return ResponseEntity.ok(ingredientDTO);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
  //vinh
    @GetMapping("/search")
    public ResponseEntity<List<IngredientDTO>> searchIngredients(@RequestParam("keyword") String keyword) {
        List<Ingredient> ingredients = ingredientService.searchByKeyword(keyword);
        List<IngredientDTO> ingredientDTOs = ingredients.stream().map(ingredient -> {
            IngredientDTO ingredientDTO = IngredientDTO.fromEntity(ingredient);
            ingredientDTO.setPhoto(AppConstant.imageUrl + ingredient.getPhoto()); // Ensure correct URL for photos
            return ingredientDTO;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(ingredientDTOs);
    }
}
