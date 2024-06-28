package com.restaurant.service.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import com.restaurant.service.dtos.IngredientDTO;
import com.restaurant.service.dtos.UserDTO;

import com.restaurant.service.entities.User;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = "spring")
public interface UserMapper {
	UserMapper MAPPER = Mappers.getMapper(UserMapper.class);
	
	UserDTO userToUserDTO(User user);
	User userDTOToUser(UserDTO userDTO);
	
	
}