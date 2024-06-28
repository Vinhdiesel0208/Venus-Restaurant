package com.restaurant.service.entities;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Entity
@Table(name = "category_t")
public class TCategory  extends AbstractEntity {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "category_name", length = 45, nullable = false)
	@NotNull
	 private String categoryName;
	
	@OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
	private List<RestaurantTable> restaurantTable;

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public List<RestaurantTable> getRestaurantTable() {
		return restaurantTable;
	}

	public void setRestaurantTable(List<RestaurantTable> restaurantTable) {
		this.restaurantTable = restaurantTable;
	}

	public TCategory(@NotNull String categoryName, List<RestaurantTable> restaurantTable) {
		super();
		this.categoryName = categoryName;
		this.restaurantTable = restaurantTable;
	}
	
	public TCategory(@NotNull String categoryName) {
		super();
		this.categoryName = categoryName;
		
	}

	public TCategory() {
		super();
		
	}
	
	

}
