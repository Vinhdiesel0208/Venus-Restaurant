package com.restaurant.service.dtos;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserDTO {

	private String email;
	private String password;
	private String firstName;
	private String lastName;
	private String photo;
	private boolean enabled;

	@Override
	public String toString() {
		return "UserDTO [email=" + email + ", password=" + password + ", firstName=" + firstName + ", lastName="
				+ lastName + "]";
	}

	public UserDTO() {
	}

	public UserDTO(String email, String password, String firstName, String lastName) {
		super();
		this.email = email;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
	}

	public UserDTO(String email, String firstName, String lastName, boolean enabled) {
		super();
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.enabled = enabled;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
}
