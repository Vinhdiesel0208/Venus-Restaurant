package com.restaurant.service.exceptions;

public class UserNotFoundException extends Exception {

	private static final long serialVersionUID = 2418461416327882550L;

	public UserNotFoundException(String message) {
		super(message);
	}
}
