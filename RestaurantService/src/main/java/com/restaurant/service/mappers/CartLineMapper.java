package com.restaurant.service.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import com.restaurant.service.dtos.CartLineDTO;
import com.restaurant.service.entities.CartLine;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = "spring")
public interface CartLineMapper {
    CartLineMapper INSTANCE = Mappers.getMapper(CartLineMapper.class);

    @Mapping(source = "ingredient.id", target = "ingredientId")
    @Mapping(source = "restaurantTable.id", target = "restaurantTableId")
    CartLineDTO toDTO(CartLine cartLine);

    CartLine toEntity(CartLineDTO cartLineDTO);
}