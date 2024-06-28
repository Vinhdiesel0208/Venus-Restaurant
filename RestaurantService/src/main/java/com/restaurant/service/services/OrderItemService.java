package com.restaurant.service.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.entities.OrderItem;
import com.restaurant.service.repositories.IngredientRepository;
import com.restaurant.service.repositories.OrderItemRepository;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class OrderItemService {
	@Autowired
	private OrderItemRepository orderItemRepository;

	@Autowired
	private IngredientRepository ingredientRepository;
	@Autowired
	CartService cartService;

	public void createOrderItem(OrderItem orderItem) {

		Long ingredientId = orderItem.getIngredient().getId();

		Ingredient ingredient = ingredientRepository.findById(ingredientId)
				.orElseThrow(() -> new EntityNotFoundException("Ingredient not found with id: " + ingredientId));

		orderItem.setIngredient(ingredient);

		orderItemRepository.save(orderItem);
		   String tableName = orderItem.getOrder().getRestaurantTable().getTableNumber();

	        cartService.clearOrderHistoryByTableName(tableName);
	}

	public List<OrderItem> getOrderItemsByOrderId(Long orderId) {
		return orderItemRepository.findByOrderId(orderId);
	}
}