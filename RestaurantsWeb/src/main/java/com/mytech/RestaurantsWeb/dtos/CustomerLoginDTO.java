package com.mytech.RestaurantsWeb.dtos;

import jakarta.validation.constraints.NotBlank;

public class CustomerLoginDTO {
	@NotBlank
	private String email;

	@NotBlank
	private String password;

	public String getEmail() {
		return email;
	}

	public void getEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}