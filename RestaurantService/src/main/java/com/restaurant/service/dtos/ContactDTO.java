package com.restaurant.service.dtos;

import java.time.LocalDateTime;

public class ContactDTO {
    private Long id;
    private String fullName;
    private String email;
    private String phone;
    private String message;
    private LocalDateTime createdTime;
    private String adminResponse;

    // Constructor without id and adminResponse
   

    // Default constructor
    public ContactDTO() {
    }

    public ContactDTO(String fullName, String email, String phone, String message, LocalDateTime createdTime,
			String adminResponse) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.phone = phone;
		this.message = message;
		this.createdTime = createdTime;
		this.adminResponse = adminResponse;
	}

	// Getters and Setters
    public LocalDateTime getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(LocalDateTime createdTime) {
        this.createdTime = createdTime;
    }
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getAdminResponse() {
        return adminResponse;
    }

    public void setAdminResponse(String adminResponse) {
        this.adminResponse = adminResponse;
    }

    // toString() method for debugging and logging purposes
    @Override
    public String toString() {
        return "ContactDTO{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", message='" + message + '\'' +
                ", adminResponse='" + adminResponse + '\'' +
                '}';
    }
}
