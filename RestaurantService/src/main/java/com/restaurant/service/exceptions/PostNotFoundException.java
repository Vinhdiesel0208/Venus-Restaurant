package com.restaurant.service.exceptions;

public class PostNotFoundException extends Exception {

	private static final long serialVersionUID = 2418461416327882550L;

	public PostNotFoundException(String message) {
		super(message);
	}
}
