package com.mytech.restaurantportal.storage;


	public class StorageException extends RuntimeException {

		private static final long serialVersionUID = -4554063415435452568L;

		public StorageException(String message) {
			super(message);
		}

		public StorageException(String message, Throwable cause) {
			super(message, cause);
		}
	}
