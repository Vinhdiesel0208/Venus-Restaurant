package com.mytech.RestaurantsWeb.service;

import java.time.LocalDateTime;

import com.restaurant.service.entities.Customer;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;

@Entity
public class PasswordResetToken {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String token;

	@OneToOne
	private Customer customer;

	private LocalDateTime expiryDate;

	// Constructors, getters, and setters
	public PasswordResetToken() {
	}

	public PasswordResetToken(String token, Customer customer, LocalDateTime expiryDate) {
		this.token = token;
		this.customer = customer;
		this.expiryDate = expiryDate;
	}
	
	public boolean isExpired() {
        return LocalDateTime.now().isAfter(this.expiryDate);
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public LocalDateTime getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(LocalDateTime expiryDate) {
		this.expiryDate = expiryDate;
	}

	// Getters and setters
}
