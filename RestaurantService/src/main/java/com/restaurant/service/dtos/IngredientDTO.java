package com.restaurant.service.dtos;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.enums.IngredientStatus;

import java.math.BigDecimal;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class IngredientDTO {
	private Long id;
	private String ingredientName;
	private BigDecimal weight;
	private String description;

	private boolean halfPortionAvailable;

	public boolean isHalfPortionAvailable() {
		return halfPortionAvailable;
	}

	public void setHalfPortionAvailable(boolean halfPortionAvailable) {
		this.halfPortionAvailable = halfPortionAvailable;
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

	private IngredientStatus status;
	private String ingredientCode;
	private String categoryName;
	private Long categoryId;
	private BigDecimal quantityInStock;
	private BigDecimal defaultQuantity;
	private BigDecimal price;

	public void setDefaultQuantity(BigDecimal defaultQuantity) {
		this.defaultQuantity = defaultQuantity;
	}
	public BigDecimal getDefaultQuantity() {
		return defaultQuantity;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	private String photo;

	public IngredientDTO() {
		// TODO Auto-generated constructor stub
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIngredientName() {
		return this.ingredientName;
	}

	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}

	public String getCategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public BigDecimal getQuantityInStock() {
		return this.quantityInStock;
	}

	public void setQuantityInStock(BigDecimal quantityInStock) {
		this.quantityInStock = quantityInStock;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getIngredientCode() {
		return this.ingredientCode;
	}

	public void setIngredientCode(String ingredientCode) {
		this.ingredientCode = ingredientCode;
	}

	public IngredientDTO(Long id, String ingredientName, String ingredientCode, String categoryName,
			BigDecimal quantityInStock, BigDecimal defaultQuantity,BigDecimal price, String photo, IngredientStatus status) {
		super();
		this.id = id;
		this.ingredientName = ingredientName;
		this.ingredientCode = ingredientCode;
		this.categoryName = categoryName;
		this.quantityInStock = quantityInStock;
		this.defaultQuantity= defaultQuantity;
		this.price = price;
		this.photo = photo;
		this.status = status;
	
	}

	public IngredientDTO(Long id, String ingredientName, String description, String ingredientCode, String categoryName,
			Long categoryId, BigDecimal quantityInStock,BigDecimal defaultQuantity, BigDecimal price, String photo, boolean halfPortionAvailable,
			IngredientStatus status) {
		super();
		this.id = id;
		this.ingredientName = ingredientName;

		this.description = description;
		this.ingredientCode = ingredientCode;
		this.categoryName = categoryName;
		this.categoryId = categoryId;
		this.quantityInStock = quantityInStock;
		this.defaultQuantity= defaultQuantity;
		this.price = price;
		this.photo = photo;
		this.halfPortionAvailable = halfPortionAvailable;
		this.status = status;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public static IngredientDTO fromEntity(Ingredient ing) {
		return new IngredientDTO(ing.getId(), ing.getIngredientName(), ing.getDescription(), ing.getIngredientCode(),
				ing.getCategory().getCategoryName(), ing.getCategory().getId(), ing.getQuantityInStock(),ing.getDefaultQuantity(),
				ing.getPrice(), ing.getPhoto(), ing.isHalfPortionAvailable(), ing.getStatus());
	}

	public IngredientDTO(Long id, String ingredientName, BigDecimal weight, String description,
			boolean halfPortionAvailable, IngredientStatus status, String ingredientCode, String categoryName,
			Long categoryId, BigDecimal quantityInStock, BigDecimal defaultQuantity, BigDecimal price, String photo) {
		super();
		this.id = id;
		this.ingredientName = ingredientName;
		this.description = description;
		this.halfPortionAvailable = halfPortionAvailable;
		this.status = status;
		this.ingredientCode = ingredientCode;
		this.categoryName = categoryName;
		this.categoryId = categoryId;
		this.quantityInStock = quantityInStock;
		this.defaultQuantity= defaultQuantity;
		this.price = price;
		this.photo = photo;
	}

	public IngredientStatus getStatus() {
		return status;
	}

	public void setStatus(IngredientStatus status) {
		this.status = status;
	}

}
