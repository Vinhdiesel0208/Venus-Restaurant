package com.restaurant.service.entities;

import java.math.BigDecimal;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data

@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "order_item")
public class OrderItem extends AbstractEntity {
	private static final long serialVersionUID = 4996062225815546413L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "order_id")
	private Order order;

	@ManyToOne
	@JoinColumn(name = "ingredient_id")
	private Ingredient ingredient;

	private BigDecimal quantity;
	private BigDecimal price;

	public Long getId() {
		return id;
	}
	
	private boolean halfPortion;

	public OrderItem(Long id, Order order, Ingredient ingredient, BigDecimal quantity, BigDecimal price,
			boolean halfPortion) {
		super();
		this.id = id;
		this.order = order;
		this.ingredient = ingredient;
		this.quantity = quantity;
		this.price = price;
		this.halfPortion = halfPortion;
	}

	public boolean isHalfPortion() {
		return halfPortion;
	}

	public void setHalfPortion(boolean halfPortion) {
		this.halfPortion = halfPortion;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
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

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public OrderItem(Long id, Order order, Ingredient ingredient, BigDecimal quantity, BigDecimal price) {
		super();
		this.id = id;
		this.order = order;
		this.ingredient = ingredient;
		this.quantity = quantity;
		this.price = price;
	}

	public OrderItem() {
		super();
		// TODO Auto-generated constructor stub
	}

}
