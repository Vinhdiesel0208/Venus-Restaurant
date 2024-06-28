package com.restaurant.service.exceptions;

public class CustomerNotFoundException extends Exception {

	private static final long serialVersionUID = 3885075290788873924L;

	public CustomerNotFoundException(String message) {
		super(message);
	}

}