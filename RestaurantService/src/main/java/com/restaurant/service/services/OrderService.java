package com.restaurant.service.services;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.restaurant.service.dtos.UserDTO;
import com.restaurant.service.entities.Order;
import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.entities.User;
import com.restaurant.service.helpers.AppConstant;
import com.restaurant.service.mappers.UserMapper;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.repositories.OrderRepository;
import com.restaurant.service.repositories.RestaurantTableRespository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class OrderService {
	 @Autowired
	    private OrderRepository orderRepository;
	 @Autowired
	 private RestaurantTableRespository restaurantTableRespository;
	 
	 public void listOrderByPage(int pageNum, int pageCount, PagingAndSortingHelper helper) {
			helper.listEntities(pageNum, pageCount, orderRepository);
		}
		
	 public List<Order> getOrderPage(int pageNum) {
			Pageable pageable = PageRequest.of(pageNum, AppConstant.pageSize);
			return orderRepository.findAll(pageable).getContent();
		}
	 
	 public List<Order> getAllOrder() {
		    return orderRepository.findAll(Sort.by("ordertime").ascending())
		                          .stream()
		                          .filter(order -> order.getFullName() != null &&
		                                           order.getPaymentMethod() != null &&
		                                           order.getEmail() != null)
		                          .collect(Collectors.toList());
		}


		

	 public void createOrder(Order order) {
		    Long tableId = order.getRestaurantTable().getId();
		    RestaurantTable table =  restaurantTableRespository.findById(tableId)
		            .orElseThrow(() -> new EntityNotFoundException("RestaurantTable not found with id: " + tableId));
		    order.setRestaurantTable(table); 
		    order.setRestaurantTableId(tableId);
		    orderRepository.save(order);
		}
	 
	 public String getOrderFullNameByEmail(String email) {
	       
	        Order order = orderRepository.findByEmail(email);
	        if (order != null) {
	            return order.getFullName();
	        } else {
	            throw new EntityNotFoundException("Order not found with email: " + email);
	        }
	    }
	 
	 public Order findOrderByEmail(String email) {
		    return orderRepository.findByEmail(email);
		}
	 
	 public List<Order> getOrdersWithItems() {
	        return orderRepository.findAllWithItems();
	    }
	
}
 