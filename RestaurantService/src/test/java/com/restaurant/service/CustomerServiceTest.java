package com.restaurant.service;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.amqp.RabbitConnectionDetails.Address;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;

import com.restaurant.service.entities.Customer;

import com.restaurant.service.services.CustomerService;


@DataJpaTest(showSql = true)
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(false)
public class CustomerServiceTest {

	@Autowired
	private TestEntityManager entityManager;
	
	@Autowired
	private CustomerService customerService;
	
	@Test
	public void testRegisterCustomer() {
		Customer customer = new Customer("Customer 4", "cus4@ymail.com", "0987665332", "123");
		
		Customer savedCustomer = customerService.registerCustomer(customer);

		if (savedCustomer != null) {
			System.out.println("Saved: " + savedCustomer.getId());
		} else {
			System.out.println("Saved failed. Can not register customer!");
		}

		assertThat(savedCustomer).isNotNull();
	}
	
	@Test
	public void testCreaateCustomerWithShipAddress() {
		Customer customer = new Customer("Customer Ship", "cusship@ymail.com", "0987665332", "123");
	
		
		Customer savedCustomer = customerService.createCustomer(customer);

		if (savedCustomer != null) {
			System.out.println("Saved: " + savedCustomer.getId());
		} else {
			System.out.println("Saved failed. Can not register customer!");
		}

		assertThat(savedCustomer).isNotNull();
	}
}
