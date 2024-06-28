package com.restaurant.service.exceptions;

public class ProductNotFoundException extends Exception {

	private static final long serialVersionUID = 2663300101809429144L;

	public ProductNotFoundException(String message) {
		super(message);
	}

}