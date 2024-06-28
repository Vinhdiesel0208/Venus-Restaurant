package com.restaurant.service.dtos;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.restaurant.service.enums.Gender;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class CustomerDTO {

    private String fullName;
    private String email;
    private String phoneNumber;
    private String password;
    private String photo;
    private String address;
    private boolean enabled;
    private boolean staff;
    private String gender; 
    //vinh
    private Integer points;

 // Constructor không tham số
    public CustomerDTO() {
    }

    public CustomerDTO(String fullName, String email, String phoneNumber, String password, String photo, String address,
			boolean enabled, boolean staff, String gender, Integer points) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
		this.photo = photo;
		this.address = address;
		this.enabled = enabled;
		this.staff = staff;
		this.gender = gender;
		this.points = points;
	}
  //vinh
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
    
    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }
    //end vinh
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isStaff() {
        return staff;
    }

    public void setStaff(boolean staff) {
        this.staff = staff;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

	public void setId(Long id) {
		// TODO Auto-generated method stub
		
	}
}