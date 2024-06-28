package com.restaurant.service.entities;

import java.math.BigDecimal;
import java.util.List;

import com.restaurant.service.enums.IngredientStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "ingredient")
public class Ingredient extends AbstractEntity {

	private static final long serialVersionUID = 1L;

	@Column(name = "ingredient_name", length = 45, nullable = false)
	@NotNull
	private String ingredientName;
	@Column(name = "ingredient_code", length = 45, nullable = false)
	@NotNull
	private String ingredientCode;

	@ManyToOne
	@JoinColumn(name = "category_id")
	private FCategory category;
	
	private List<OrderItem> orderItems;

	public Ingredient(@NotNull String ingredientName, @NotNull String ingredientCode, FCategory category,
			List<OrderItem> orderItems, IngredientStatus status, boolean halfPortionAvailable,
			BigDecimal quantityInStock, BigDecimal weight, String description, BigDecimal price, String photo) {
		super();
		this.ingredientName = ingredientName;
		this.ingredientCode = ingredientCode;
		this.category = category;
		this.orderItems = orderItems;
		this.status = status;
		this.halfPortionAvailable = halfPortionAvailable;
		this.quantityInStock = quantityInStock;
		this.weight = weight;
		this.description = description;
		this.price = price;
		this.photo = photo;
	}

	public IngredientStatus getStatus() {
		return status;
	}

	public void setStatus(IngredientStatus status) {
		this.status = status;
	}

	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}
	@Enumerated(EnumType.STRING)
	@Column(name = "status")
	private IngredientStatus status;
	
	@Column(columnDefinition = "tinyint(1) default 1")
	private boolean halfPortionAvailable;
	
	

	public boolean isHalfPortionAvailable() {
		return halfPortionAvailable;
	}

	public void setHalfPortionAvailable(boolean halfPortionAvailable) {
		this.halfPortionAvailable = halfPortionAvailable;
	}

	@Column(name = "quantity_in_stock", precision = 10, scale = 2)
	private BigDecimal quantityInStock;
	@Column(name = "default_quantity", precision = 10, scale = 2)
	private BigDecimal defaultQuantity;
	public BigDecimal getDefaultQuantity() {
		return this.defaultQuantity;
	}

	public void setDefaultQuantity(BigDecimal defaultQuantity) {
		this.defaultQuantity = defaultQuantity;
	}

	@Column(name = "weight", precision = 10, scale = 2)
	private BigDecimal weight;

	@Column(name = "description", length = 50)
	private String description;

	@Column(name = "price", precision = 10, scale = 2)
	private BigDecimal price;

	@Column(length = 1024)
	private String photo;

	public Ingredient() {

	}

	@Transient
	public String getPhotosImagePath() {
		if (id == null || photo == null)
			return "/images/default-user.png";

		return "/user-photos/" + this.id + "/" + photo;
	}

	public Ingredient(@NotNull String ingredientName, @NotNull String ingredientCode, FCategory category,
			BigDecimal quantityInStock, BigDecimal price, String photo,IngredientStatus status, BigDecimal defaultQuantity) {
		super();
		this.ingredientName = ingredientName;
		this.ingredientCode = ingredientCode;
		this.category = category;
		this.quantityInStock = quantityInStock;
		this.price = price;
		this.photo = photo;
		this.status = status;
		this.defaultQuantity = defaultQuantity;
	}

	public Ingredient(String ingredientName, String ingredientCode, FCategory category, BigDecimal quantityInStock,
			BigDecimal weight, String description, BigDecimal price, String photo, boolean halfPortionAvailable,IngredientStatus status,BigDecimal defaultQuantity) {
		
		super();
		this.ingredientName = ingredientName;
		this.ingredientCode = ingredientCode;
		this.category = category;
		this.quantityInStock = quantityInStock;
		this.weight = weight;
		this.description = description;
		this.price = price;
		this.photo = photo;
		this.halfPortionAvailable = halfPortionAvailable;
		this.status = status;
		this.defaultQuantity = defaultQuantity;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIngredientCode() {
		return this.ingredientCode;
	}

	public void setIngredientCode(String ingredientCode) {
		this.ingredientCode = ingredientCode;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getIngredientName() {
		return this.ingredientName;
	}

	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}

	public FCategory getCategory() {
		return this.category;
	}

	public void setCategory(FCategory category) {
		this.category = category;
	}

	public BigDecimal getQuantityInStock() {
		return this.quantityInStock;
	}

	public void setQuantityInStock(BigDecimal quantityInStock) {
		this.quantityInStock = quantityInStock;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

}
