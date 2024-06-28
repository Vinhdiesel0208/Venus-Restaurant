package com.mytech.RestaurantsWeb.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Customer;
import com.restaurant.service.repositories.CustomerRepository;



@Service
public class AppUserDetailsService implements UserDetailsService {
	
	@Autowired
	private CustomerRepository userRepo;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		Customer customer = userRepo.findByEmail(email);
		if (customer != null) {
			return new AppUserDetails(customer);
		}
		
		throw new UsernameNotFoundException("Could not find user with email: " + email);
	}

}