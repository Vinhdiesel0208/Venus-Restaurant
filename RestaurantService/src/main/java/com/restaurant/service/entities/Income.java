package com.restaurant.service.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "income")
public class Income extends AbstractEntity {

	private static final long serialVersionUID = 4524626445941717470L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "day")
	private LocalDateTime day;
	
	@OneToOne(mappedBy = "income")
	private Order order;
	
	@OneToMany(mappedBy = "income", cascade = CascadeType.ALL)
	private List<IncomeItem> incomeItems = new ArrayList<>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public LocalDateTime getDay() {
		return day;
	}

	
	
	public void setDay(LocalDateTime day) {
		this.day = day;
		updateSoldQuantity();
		//updateTotalPrice();
		
	}

	public List<IncomeItem> getIncomeItems() {
		return incomeItems;
	}

	public void setIncomeItems(List<IncomeItem> incomeItems) {
		this.incomeItems = incomeItems;
	}

	private void updateSoldQuantity() {
		for (IncomeItem item : incomeItems) {
			item.calculateSoldQuantity();
		}
	}
	
	@Transient
	public BigDecimal getTotalIncome() {
		BigDecimal totalIncome = BigDecimal.ZERO;
		for (IncomeItem item : incomeItems) {
			totalIncome = totalIncome.add(item.getTotalPrice());
		}
		return totalIncome;
	}

//	private void updateTotalPrice() {
//		for (IncomeItem item : incomeItems) {
//			item.calculateTotalPrice();
//		}
//	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}
	
}
