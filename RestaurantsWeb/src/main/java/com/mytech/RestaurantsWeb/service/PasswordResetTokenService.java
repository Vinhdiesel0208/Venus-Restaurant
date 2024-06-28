package com.mytech.RestaurantsWeb.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Customer;

@Service
public class PasswordResetTokenService {

	@Autowired
	private PasswordResetTokenRepository passwordResetTokenRepository;

	public void createPasswordResetTokenForCustomer(Customer customer, String token) {
        PasswordResetToken passwordResetToken = new PasswordResetToken(token, customer, LocalDateTime.now().plusHours(24));
        passwordResetTokenRepository.save(passwordResetToken);
    }

    public PasswordResetToken findByToken(String token) {
        return passwordResetTokenRepository.findByToken(token);
    }

    public void delete(PasswordResetToken token) {
        passwordResetTokenRepository.delete(token);
    }

    public void deleteByCustomer(Customer customer) {
        passwordResetTokenRepository.deleteByCustomer(customer);
    }
}
