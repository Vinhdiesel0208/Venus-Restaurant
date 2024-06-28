package com.restaurant.service.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import com.restaurant.service.dtos.CustomerDTO;
import com.restaurant.service.entities.Customer;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = "spring")
public interface CustomerMapper {
	  CustomerMapper MAPPER = Mappers.getMapper(CustomerMapper.class);

	    
	    CustomerDTO customerToCustomerDTO(Customer customer);

	   
	    Customer customerDTOToCustomer(CustomerDTO customerDTO);
}
