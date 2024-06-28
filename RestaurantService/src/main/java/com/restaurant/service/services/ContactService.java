package com.restaurant.service.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Contact;
import com.restaurant.service.entities.Customer;

import com.restaurant.service.enums.AuthenticationType;
import com.restaurant.service.exceptions.CustomerNotFoundException;
import com.restaurant.service.repositories.ContactRepository;
import com.restaurant.service.repositories.CustomerRepository;


import io.micrometer.common.lang.NonNull;
import jakarta.transaction.Transactional;
import net.bytebuddy.utility.RandomString;

@Service
@Transactional
public class ContactService {

	@Autowired
	private ContactRepository contactRepo;
	

	public Contact registerContact(Contact contact) {
		return contactRepo.save(contact);
	}
	public Contact sendResponse(Long contactId, String responseMessage) {
        Contact contact = contactRepo.findById(contactId).orElse(null);
        if (contact != null) {
            contact.setAdminResponse(responseMessage);
            return contactRepo.save(contact);
        }
        return null;
    }
	 public List<Contact> getAllContacts() {
	        return contactRepo.findAll();
	    }

	 
}
