package com.restaurant.service.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import com.restaurant.service.dtos.IngredientDTO;
import com.restaurant.service.dtos.UserDTO;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.entities.User;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = "spring")
public interface  IngredientMapper {
	 IngredientMapper MAPPER = Mappers.getMapper(IngredientMapper.class);
	
	    @Mapping(target = "categoryName", source = "category.categoryName")
	IngredientDTO ingredienttoingredientDTO(Ingredient ingredient);
		Ingredient  ingredientDTOtoingredient(IngredientDTO ingredientDTO); 
		
		
	
}
