package com.mytech.RestaurantsWeb.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.restaurant.service.entities.Customer;

public class AppUserDetails implements UserDetails {

    private static final long serialVersionUID = 1791699434224222474L;
    private final String ROLE_CUSTOMER = "CUSTOMER";
    private final String ROLE_STAFF = "STAFF";

    private Customer customer;

    public AppUserDetails(Customer user) {
        this.customer = user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("CUSTOMER"));

        if (customer.isStaff()) {
            authorities.add(new SimpleGrantedAuthority("STAFF"));
            System.out.println("Assigned STAFF authority to user: " + customer.getEmail());
        }

        return authorities;
    }




    @Override
    public String getPassword() {
        return customer.getPassword();
    }

    @Override
    public String getUsername() {
        return customer.getEmail();
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
        return customer.isEnabled();
    }

    // Addition methods
    public String roles() {
        return ROLE_CUSTOMER;
    }

    public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getROLE_CUSTOMER() {
		return ROLE_CUSTOMER;
	}

	public String getROLE_STAFF() {
		return ROLE_STAFF;
	}

	public Long getId() {
        return customer.getId();
    }

    public String getEmail() {
        return customer.getEmail();
    }

    public String getPhoto() {
        return customer.getPhoto();
    }

    public String getFullname() {
        return this.customer.getFullName();
    }
}
