package com.restaurant.service.entities;


import java.util.HashSet;
import java.util.Set;

import com.restaurant.service.enums.AuthenticationType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Entity
@Table(name = "customers")
public class Customer extends AbstractEntity {

	private static final long serialVersionUID = -7437655422342271820L;
	
	public Customer(String name, String email, String phoneNumber, String password) {
		this.fullName = name;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
	}
	

	public Customer(String fullName, String email, String phoneNumber, String password, String photo, String address,
			String postalCode, String ward, String district, String city, String gender,
			AuthenticationType authenticationType, String verificationCode, String resetPasswordToken, boolean enabled,
			boolean emailVerified, boolean phoneVerified, boolean staff) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
		this.photo = photo;
		this.address = address;
		this.postalCode = postalCode;
		this.ward = ward;
		this.district = district;
		this.city = city;
		
		this.gender = gender;
		this.authenticationType = authenticationType;
		this.verificationCode = verificationCode;
		this.resetPasswordToken = resetPasswordToken;
		this.enabled = enabled;
		this.emailVerified = emailVerified;
		this.phoneVerified = phoneVerified;
		this.staff = staff;
	}


	public Customer() {
		// TODO Auto-generated constructor stub
	}
	@Column(name = "full_name", length = 64)
	@NotBlank(message = "Full name is required")
	private String fullName;
	
	
	@Column(nullable = true, unique = true, length = 45)
	@Email(message = "Invalid email address")
	@NotBlank(message = "Email is required")
	private String email;
	
	@Column(name = "phone_number", length = 12)
	@Pattern(regexp="^[0-9]{10}$", message="Invalid phone number")
	private String phoneNumber;

	@Column(nullable = true, length = 64)
	private String password;
	
	
	@Column(name = "points")
	private Integer points;

	
	public Integer getPoints() {
	    return points;
	}

	public void setPoints(Integer points) {
	    this.points = points;
	}


	
	@Column(length = 1024)
	private String photo;
	
	private String address;
	

	


	

	

	public Customer(String fullName, String email, String phoneNumber, String password, Integer points, String photo,
			String address, String postalCode, String ward, String district, String city, String gender, AuthenticationType authenticationType,
			String verificationCode, String resetPasswordToken, boolean enabled, boolean emailVerified,
			boolean phoneVerified, boolean staff) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
		this.points = points;
		this.photo = photo;
		this.address = address;
		this.postalCode = postalCode;
		this.ward = ward;
		this.district = district;
		this.city = city;
		this.gender = gender;
		this.authenticationType = authenticationType;
		this.verificationCode = verificationCode;
		this.resetPasswordToken = resetPasswordToken;
		this.enabled = enabled;
		this.emailVerified = emailVerified;
		this.phoneVerified = phoneVerified;
		this.staff = staff;
	}

	private String postalCode;
	private String ward;
	private String district;
	private String city;
	
	
	
	private String gender;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "authentication_type", length = 10)
	private AuthenticationType authenticationType;
	
	@Column(name = "verification_code", length = 64)
	private String verificationCode;	
	
	@Column(name = "reset_password_token", length = 30)
	private String resetPasswordToken;
	
	@Column(columnDefinition = "tinyint(1) default 1")
	private boolean enabled;
	
	@Column(columnDefinition = "tinyint(1) default 1")
	private boolean emailVerified;
	
	@Column(columnDefinition = "tinyint(1) default 1")
	private boolean phoneVerified;
	
	@Column(columnDefinition = "tinyint(1) default 0")
	private boolean staff;
	
	public boolean isStaff() {
		return staff;
	}

	public void setStaff(boolean staff) {
		this.staff = staff;
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

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getWard() {
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}



	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public AuthenticationType getAuthenticationType() {
		return authenticationType;
	}

	public void setAuthenticationType(AuthenticationType authenticationType) {
		this.authenticationType = authenticationType;
	}

	public String getVerificationCode() {
		return verificationCode;
	}

	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}

	public String getResetPasswordToken() {
		return resetPasswordToken;
	}

	public void setResetPasswordToken(String resetPasswordToken) {
		this.resetPasswordToken = resetPasswordToken;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean isEmailVerified() {
		return emailVerified;
	}

	public void setEmailVerified(boolean emailVerified) {
		this.emailVerified = emailVerified;
	}

	public boolean isPhoneVerified() {
		return phoneVerified;
	}

	public void setPhoneVerified(boolean phoneVerified) {
		this.phoneVerified = phoneVerified;
	}
	
}