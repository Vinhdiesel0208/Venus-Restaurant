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
@Table(name = "category_f")
public class FCategory extends AbstractEntity {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "category_name", length = 45, nullable = false)
	@NotNull
	 private String categoryName;
	
	@OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
	private List<Ingredient> ingredient;
	
	public FCategory() {
		// TODO Auto-generated constructor stub
	}

	public String getCategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public FCategory(@NotNull String categoryName) {
		super();
		this.categoryName = categoryName;
	}
	
	
	 
	 

}
