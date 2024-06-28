package com.restaurant.service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.restaurant.service.entities.Contact;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.enums.AuthenticationType;



public interface ContactRepository extends JpaRepository<Contact, Long> {
	
}
