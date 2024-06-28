package com.restaurant.service.entities;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "orders")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
	private List<OrderItem> orderItems;

	private String paymentMethod;
	private String fullName;
	private String email;
	private double tips;
	private double total;
	private double discount;
	private double tax;
	private double total1;
	private String dishName;
	
	
	
	

	public double getTax() {
		return tax;
	}

	public Order(Long id, List<OrderItem> orderItems, String paymentMethod, String fullName, String email, double tips,
			double total, double discount, double tax, double total1, String dishName, Income income,
			LocalDateTime ordertime, RestaurantTable restaurantTable, Long restaurantTableId) {
		super();
		this.id = id;
		this.orderItems = orderItems;
		this.paymentMethod = paymentMethod;
		this.fullName = fullName;
		this.email = email;
		this.tips = tips;
		this.total = total;
		this.discount = discount;
		this.tax = tax;
		this.total1 = total1;
		this.dishName = dishName;
		this.income = income;
		this.ordertime = ordertime;
		this.restaurantTable = restaurantTable;
		this.restaurantTableId = restaurantTableId;
	}

	public void setTax(double tax) {
		this.tax = tax;
	}

	public double getTotal1() {
		return total1;
	}

	public void setTotal1(double total1) {
		this.total1 = total1;
	}

	public Order(Long id, List<OrderItem> orderItems, String paymentMethod, String fullName, String email, double tips,
			double total, double discount, LocalDateTime ordertime, RestaurantTable restaurantTable,
			Long restaurantTableId) {
		super();
		this.id = id;
		this.orderItems = orderItems;
		this.paymentMethod = paymentMethod;
		this.fullName = fullName;
		this.email = email;
		this.tips = tips;
		this.total = total;
		this.discount = discount;
		this.ordertime = ordertime;
		this.restaurantTable = restaurantTable;
		this.restaurantTableId = restaurantTableId;
	}

	public Order(Long id, List<OrderItem> orderItems, String paymentMethod, String fullName, String email, double tips,
			double total, double discount, String dishName, Income income, LocalDateTime ordertime,
			RestaurantTable restaurantTable, Long restaurantTableId) {
		super();
		this.id = id;
		this.orderItems = orderItems;
		this.paymentMethod = paymentMethod;
		this.fullName = fullName;
		this.email = email;
		this.tips = tips;
		this.total = total;
		this.discount = discount;
		this.dishName = dishName;
		this.income = income;
		this.ordertime = ordertime;
		this.restaurantTable = restaurantTable;
		this.restaurantTableId = restaurantTableId;
	}

//	public Order() {
//		// TODO Auto-generated constructor stub
//	}

	public String getDishName() {
		return dishName;
	}

	public void setDishName(String dishName) {
		this.dishName = dishName;
	}

	public Income getIncome() {
		return income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

	

	@OneToOne
	@JoinColumn(name = "income_id")
	private Income income;

	

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	private LocalDateTime ordertime;

	@ManyToOne
	@JoinColumn(name = "table_id")
	private RestaurantTable restaurantTable;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public double getTips() {
		return tips;
	}

	public void setTips(double tips) {
		this.tips = tips;
	}

	@Transient
	private Long restaurantTableId;

	public Long getRestaurantTableId() {
		return restaurantTableId;
	}

	public void setRestaurantTableId(Long restaurantTableId) {
		this.restaurantTableId = restaurantTableId;
	}

	public LocalDateTime getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(LocalDateTime ordertime) {
		this.ordertime = ordertime;
	}

	public RestaurantTable getRestaurantTable() {
		return restaurantTable;
	}

	public void setRestaurantTable(RestaurantTable restaurantTable) {
		this.restaurantTable = restaurantTable;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
