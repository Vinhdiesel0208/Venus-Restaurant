package com.mytech.RestaurantsWeb.service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.restaurant.service.entities.Customer;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {
    PasswordResetToken findByToken(String token);
    void deleteByCustomer(Customer customer);
}
