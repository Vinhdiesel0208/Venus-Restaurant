package com.restaurant.service.entities;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;




@Data
@AllArgsConstructor
@EqualsAndHashCode(callSuper=false)
@Entity
@Table(name = "users")
public class User extends AbstractEntity {

	private static final long serialVersionUID = -3040936926883879912L;

	public User(String email, @NotNull String password, @NotNull String firstName, @NotNull String lastName) {
		super();
		this.email = email;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
	}
	

	public User() {
		
	}


	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public boolean isEnabled() {
		return this.enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean isChangePassword() {
		return this.changePassword;
	}

	public void setChangePassword(boolean changePassword) {
		this.changePassword = changePassword;
	}

	public String getResetPasswordToken() {
		return this.resetPasswordToken;
	}

	public void setResetPasswordToken(String resetPasswordToken) {
		this.resetPasswordToken = resetPasswordToken;
	}

	public Set<Role> getRoles() {
		return this.roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}


	@Column(length = 64, nullable = false, unique = true)
	@Email
	private String email;

	@Column(length = 128, nullable = false)
	@NotNull
	private String password;

	@Column(name = "first_name", length = 45, nullable = false)
	@NotNull
	private String firstName;

	@Column(name = "last_name", length = 45, nullable = false)
	@NotNull
	private String lastName;

	@Column(length = 1024)
	private String photo;

	@Column(columnDefinition = "tinyint(1) default 1")
	private boolean enabled;
	
	@Column(columnDefinition = "tinyint(1) default 1")
	private boolean changePassword;
	
	@Column(name = "reset_password_token", length = 128)
	private String resetPasswordToken;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "users_roles", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
	private Set<Role> roles = new HashSet<>();

	public void addRole(Role role) {
		this.roles.add(role);
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", roles=" + roles + "]";
	}

	@Transient
	public String getPhotosImagePath() {
		if (id == null || photo == null)
			return "/images/default-user.png";

		return "/user-photos/" + this.id + "/" + photo;
	}

	@Transient
	public String getFullName() {
		return firstName + " " + lastName;
	}

	
	

	@Transient
	public boolean hasRole(String roleName) {
		if (roleName == null) {
			return false;
		}
		for (Role role : roles) {
			if (roleName.equals(role.getName())) {
				return true;
			}
		}
		return false;
	}
	
	 @Transient
	    public String getRoleNames() {
	        return roles.stream().map(Role::getName).collect(Collectors.joining(", "));
	    }
}
