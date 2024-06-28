package com.restaurant.service.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.restaurant.service.enums.OrderStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "cart_lines")
public class CartLine extends AbstractEntity {

	private static final long serialVersionUID = -715335026423418837L;

	private String tableName;

	@ManyToOne
	@JoinColumn(name = "ingredient_id")
	private Ingredient ingredient;

	@ManyToOne
	@JoinColumn(name = "table_id")
	private RestaurantTable restaurantTable;

	@ManyToOne
	@JoinColumn(name = "order_id") // Add this line
	private Order order; // Add this line

	private BigDecimal quantity;

	@Enumerated(EnumType.STRING)
	@Column(name = "status", nullable = false)
	private OrderStatus status;

	private boolean halfPortion;

	public boolean isHalfPortion() {
		return halfPortion;
	}

	public void setHalfPortion(boolean halfPortion) {
		this.halfPortion = halfPortion;
	}

	@Column(name = "order_time")
	private LocalDateTime orderTime;

	public LocalDateTime getOrderTime() {
		return orderTime;
	}

	private BigDecimal price;

	public void setOrderTime(LocalDateTime orderTime) {
		this.orderTime = orderTime;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	@Transient
	public String getIngredientPhoto() {
		return ingredient.getPhoto();
	}

	public OrderStatus getStatus() {
		return status;
	}

	public void setStatus(OrderStatus status) {
		this.status = status;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public Ingredient getIngredient() {
		return ingredient;
	}

	public void setIngredient(Ingredient ingredient) {
		this.ingredient = ingredient;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	// Getters and setters for the new order field
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public CartLine(String tableName, Ingredient ingredient, RestaurantTable restaurantTable, Order order, BigDecimal quantity,
			OrderStatus status, boolean halfPortion, LocalDateTime orderTime, BigDecimal price) {
		super();
		this.tableName = tableName;
		this.ingredient = ingredient;
		this.restaurantTable = restaurantTable;
		this.order = order;
		this.quantity = quantity;
		this.status = status;
		this.halfPortion = halfPortion;
		this.orderTime = orderTime;
		this.price = price;
	}

	public CartLine(Ingredient ingredient, BigDecimal quantity) {
		super();

		this.ingredient = ingredient;
		this.quantity = quantity;
	}

	public CartLine() {
		super();

	}

	public RestaurantTable getRestaurantTable() {
		return restaurantTable;
	}

	public void setRestaurantTable(RestaurantTable restaurantTable) {
		this.restaurantTable = restaurantTable;
	}
	

}
