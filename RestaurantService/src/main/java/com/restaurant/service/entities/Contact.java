package com.restaurant.service.entities;

import java.io.Serializable;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "contacts")
public class Contact implements Serializable {
    private static final long serialVersionUID = -7437655422342271820L;

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "full_name", length = 64)
    private String fullName;

    @Column(nullable = true, length = 45)
    private String email;

    @Column(name = "phone", length = 1024)
    private String phone;

    @Column(name = "message", length = 1024)
    private String message;
    @Column(name = "created_time")
    private LocalDateTime createdTime;

    @Column(name = "admin_response", length = 1024)
    private String adminResponse;

    public Contact() {
    }

    public Contact(String fullName, String email, String phone, String message, LocalDateTime createdTime,
			String adminResponse) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.phone = phone;
		this.message = message;
		this.createdTime = createdTime;
		this.adminResponse = adminResponse;
	}

    // Getters and setters
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
    public LocalDateTime getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(LocalDateTime createdTime) {
        this.createdTime = createdTime;
    }



	

	
}
