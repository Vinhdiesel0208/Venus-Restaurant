package com.restaurant.service.dtos;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.restaurant.service.enums.OrderStatus;

public class CartLineDTO {
	//vinh
	private LocalDateTime orderTime;
	private OrderStatus status;
	private Long cartLineId;
	//end vinh
	private String tableName;
	private Long ingredientId;
	private Long restaurantTableId;
	private BigDecimal quantity;
	private String ingredientName;
	private BigDecimal price;
	private String ingredientPhoto;
	private boolean halfPortion;
	private Long orderId; // Add this field

	public boolean isHalfPortion() {
		return halfPortion;
	}

	

	public void setHalfPortion(boolean halfPortion) {
		this.halfPortion = halfPortion;
	}
//vinh
	
	public Long getCartLineId() {
		return cartLineId;
	}

	public Long getOrderId() {
		return orderId;
	}



	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}



	public void setCartLineId(Long cartLineId) {
		this.cartLineId = cartLineId;
	}

	public OrderStatus getStatus() {
		return status;
	}

	public void setStatus(OrderStatus status) {
		this.status = status;
	}
	public LocalDateTime getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(LocalDateTime orderTime) {
		this.orderTime = orderTime;
	}
	//endvinh
	public String getIngredientName() {
		return ingredientName;
	}

	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}

	

	public CartLineDTO() {
	}

	

	public CartLineDTO(LocalDateTime orderTime, OrderStatus status, Long cartLineId, String tableName,
			Long ingredientId, Long restaurantTableId, BigDecimal quantity, String ingredientName, BigDecimal price,
			String ingredientPhoto, boolean halfPortion) {
		super();
		this.orderTime = orderTime;
		this.status = status;
		this.cartLineId = cartLineId;
		this.tableName = tableName;
		this.ingredientId = ingredientId;
		this.restaurantTableId = restaurantTableId;
		this.quantity = quantity;
		this.ingredientName = ingredientName;
		this.price = price;
		this.ingredientPhoto = ingredientPhoto;
		this.halfPortion = halfPortion;
	}



	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public Long getIngredientId() {
		return ingredientId;
	}

	public void setIngredientId(Long ingredientId) {
		this.ingredientId = ingredientId;
	}

	public Long getRestaurantTableId() {
		return restaurantTableId;
	}

	public void setRestaurantTableId(Long restaurantTableId) {
		this.restaurantTableId = restaurantTableId;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getIngredientPhoto() {
		return ingredientPhoto;
	}

	public void setIngredientPhoto(String ingredientPhoto) {
		this.ingredientPhoto = ingredientPhoto;
	}
}