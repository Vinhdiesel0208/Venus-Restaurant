package com.mytech.restaurantportal.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.restaurant.service.entities.Role;
import com.restaurant.service.entities.User;

public class AppUserDetails implements UserDetails {

	private static final long serialVersionUID = 1791699434224222474L;

	private User user;

	public AppUserDetails(User user) {
		this.user = user;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Set<Role> roles = user.getRoles();

		List<SimpleGrantedAuthority> authories = new ArrayList<>();

		for (Role role : roles) {
			authories.add(new SimpleGrantedAuthority(role.getName()));
		}

		return authories;
	}

	@Override
	public String getPassword() {
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		return user.getEmail();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return user.isEnabled();
	}
	
	//Addition methods
	public String roles() {
		return user.getRoles().toString();
	}
	
	public Set<Role> getRoles() {
		return user.getRoles();
	}
	
	public boolean isChangePassword() {
		return user.isChangePassword();
	}
	
	public Long getId() {
		return user.getId();
	}
	
	public String getEmail() {
		return user.getEmail();
	}
	
	public String getPhoto() {
		return user.getPhoto();
	}
	
	public String getFullname() {
		return this.user.getFirstName() + " " + this.user.getLastName();
	}
	
	public void setFirstName(String firstName) {
		this.user.setFirstName(firstName);
	}

	public void setLastName(String lastName) {
		this.user.setLastName(lastName);
	}	
	
	public boolean hasRole(String roleName) {
		return user.hasRole(roleName);
	}
}
