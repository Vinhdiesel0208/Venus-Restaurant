package com.restaurant.service.repositories;


import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.restaurant.service.entities.Customer;
import com.restaurant.service.enums.AuthenticationType;



public interface CustomerRepository extends JpaRepository<Customer, Long> {
	//vinh
		@Modifying
		@Query("UPDATE Customer c SET c.points = c.points + :newPoints WHERE c.email = :email")
		void updatePointsByEmail(@Param("email") String email, @Param("newPoints") int newPoints);
	//endvinh
	@Modifying
	@Query("UPDATE Customer c SET c.enabled = true, c.verificationCode = null WHERE c.id = ?1")
	public void enable(Long id);
	
	@Modifying
	@Query("UPDATE Customer c SET c.authenticationType = ?2 WHERE c.id = ?1")
	public void updateAuthenticationType(Long customerId, AuthenticationType type);
	
	 @Query("SELECT c FROM Customer c WHERE c.staff = true")
	    List<Customer> findAllStaffCustomers();
		
	public Customer findByEmail(String email);
	public Customer findByVerificationCode(String code);
	public Customer findByResetPasswordToken(String token);
	
	public Optional<Customer> findById(Long id);
	
	
	

}
