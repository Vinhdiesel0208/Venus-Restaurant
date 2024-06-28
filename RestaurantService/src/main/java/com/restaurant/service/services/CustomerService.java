package com.restaurant.service.services;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.restaurant.service.dtos.CustomerDTO;
import com.restaurant.service.entities.Customer;

import com.restaurant.service.enums.AuthenticationType;
import com.restaurant.service.exceptions.CustomerNotFoundException;
import com.restaurant.service.exceptions.UserNotFoundException;
import com.restaurant.service.repositories.CustomerRepository;


import io.micrometer.common.lang.NonNull;
import jakarta.transaction.Transactional;
import net.bytebuddy.utility.RandomString;

@Service
@Transactional
public class CustomerService {

	@Autowired
	private CustomerRepository customerRepo;


	@Autowired
	PasswordEncoder passwordEncoder;
//vinh

    // Hàm cập nhật logic điểm thưởng
    public void redeemPoints(String email, double totalAmount) {
        Customer customer = customerRepo.findByEmail(email);
        if (customer != null) {
            int points = customer.getPoints();
            double discountAmount = points/10; // 50 points = 5 USD
            double finalAmount = totalAmount - discountAmount;
            if (finalAmount < 0) finalAmount = 0;

            // Logic cập nhật điểm
            int pointsToUse = (int) (discountAmount * 10);
            int remainingPoints = points - pointsToUse;

            // Cập nhật điểm mới sau khi thanh toán
            int newPoints = (int) (0.05 * totalAmount);

            customer.setPoints(remainingPoints + newPoints); // Cập nhật điểm sau khi trừ và cộng thêm điểm mới
            customerRepo.save(customer);
        }
    }

    // Hàm mới để cập nhật điểm thưởng sau khi thanh toán
    public void processPoints(String email, double totalAmount, boolean usePoints) {
        Customer customer = customerRepo.findByEmail(email);
        if (customer != null) {
            int currentPoints = customer.getPoints() != null ? customer.getPoints() : 0;
            int pointsUsed = 0;
            int newPoints = (int) (0.05 * totalAmount); // 5% của tổng số tiền

            if (usePoints) {
                double discountAmount = currentPoints / 10.0;
                pointsUsed = (int) (discountAmount * 10);
                int remainingPoints = currentPoints - pointsUsed;
                newPoints += remainingPoints;
            } else {
                newPoints += currentPoints;
            }

            customer.setPoints(newPoints);
            customerRepo.save(customer);
            
        }
    }

    // Hàm cập nhật điểm dựa trên email và tổng số tiền
    public void updatePointsByEmail(String email, double total) {
        Customer customer = customerRepo.findByEmail(email);
        if (customer != null) {
            int newPoints = (int) (0.05 * total); // Cập nhật điểm mới (0.05 * total amount)

            Integer currentPoints = customer.getPoints();
            if (currentPoints == null) {
                currentPoints = 0;
            }

            customer.setPoints(currentPoints + newPoints);
            customerRepo.save(customer);
        }
    }
	public int calculateCustomerPoints(String email) {
        Customer customer = customerRepo.findByEmail(email);
        if (customer != null) {
            return customer.getPoints(); 
        }
        return 0; 
    }
//end vinh
	
	//hao
	public boolean isEmailUnique(String email) {
		Customer customer = customerRepo.findByEmail(email);
		return customer == null;
	}
	
	public Customer findByEmail(String email) {
        return customerRepo.findByEmail(email);
    }
	
	public void updateCustomer(Customer customer) {
	 
		customerRepo.save(customer);
	}
	
	public Customer CreateStaff(CustomerDTO customerDTO) {
		String encodedPassword = passwordEncoder.encode(customerDTO.getPassword());
	   Customer customer = new Customer();
	   customer.setFullName(customerDTO.getFullName());
	   customer.setPassword(encodedPassword);
	   customer.setEmail(customerDTO.getEmail());
	   customer.setEnabled(customerDTO.isEnabled());
	   customer.setPhoto(customerDTO.getPhoto());
	   customer.setGender(customerDTO.getGender());
	   customer.setStaff(customerDTO.isStaff());
	   customer.setPhoneNumber(customerDTO.getPhoneNumber());
	   customer.setAddress(customerDTO.getAddress());
	   
	  return customerRepo.save(customer);
	}
	
	public Customer get(Long id) throws UserNotFoundException {
		try {
			return customerRepo.findById(id).get();
		} catch (NoSuchElementException ex) {
			throw new UserNotFoundException("Could not find any user with ID " + id);
		}
	}
	
	

	public Customer createCustomer(Customer customer) {
		
		String encodedPassword = passwordEncoder.encode(customer.getPassword());
		customer.setPassword(encodedPassword);
		customer.setEnabled(true);
		customer.setEmailVerified(false);
		customer.setPhoneVerified(false);
		customer.setAuthenticationType(AuthenticationType.DATABASE);

		String randomCode = RandomString.make(64);
		customer.setVerificationCode(randomCode);

		return customerRepo.save(customer);
	}
	
	public Customer registerCustomer(Customer customer) {
		String encodedPassword = passwordEncoder.encode(customer.getPassword());
		customer.setPassword(encodedPassword);
		customer.setEnabled(true);
		customer.setEmailVerified(false);
		customer.setPhoneVerified(false);
		customer.setAuthenticationType(AuthenticationType.DATABASE);

		String randomCode = RandomString.make(64);
		customer.setVerificationCode(randomCode);

		return customerRepo.save(customer);
	}

	
	//TODO: Verifying
	public void registerCustomerOAuth2(String name, String email,
			AuthenticationType authenticationType) {
		Customer customer = new Customer();
		customer.setEmail(email);
		customer.setFullName(name);

		customer.setEnabled(true);
		customer.setAuthenticationType(authenticationType);
		customer.setPassword("");

		customerRepo.save(customer);
	}
	
	public List<Customer> findAllStaffCustomers() {
        return customerRepo.findAllStaffCustomers();
    }
	
	

	public Customer getCustomerByEmail(String email) {
		return customerRepo.findByEmail(email);
	}
	


	public boolean verify(String verificationCode) {
		Customer customer = customerRepo.findByVerificationCode(verificationCode);

		if (customer == null || customer.isEnabled()) {
			return false;
		} else {
			customerRepo.enable(customer.getId());
			return true;
		}
	}

	public void updateAuthenticationType(Customer customer, AuthenticationType type) {
		if (!customer.getAuthenticationType().equals(type)) {
			customerRepo.updateAuthenticationType(customer.getId(), type);
		}
	}

	public void update(@NonNull Customer customerForm) {
		Customer customer = customerRepo.findById(customerForm.getId()).get();

		if (customer.getAuthenticationType().equals(AuthenticationType.DATABASE)) {
			if (!customerForm.getPassword().isEmpty()) {
				// String encodedPassword = passwordEncoder.encode(customerForm.getPassword());
				// customerForm.setPassword(encodedPassword);
			} else {
				customerForm.setPassword(customer.getPassword());
			}
		} else {
			customerForm.setPassword(customer.getPassword());
		}

		customerForm.setEnabled(customer.isEnabled());
		customerForm.setVerificationCode(customer.getVerificationCode());
		customerForm.setAuthenticationType(customer.getAuthenticationType());
		customerForm.setResetPasswordToken(customer.getResetPasswordToken());

		customerRepo.save(customerForm);
	}

	public String updateResetPasswordToken(String email) throws CustomerNotFoundException {
		Customer customer = customerRepo.findByEmail(email);
		if (customer != null) {
			String token = RandomString.make(30);
			customer.setResetPasswordToken(token);
			customerRepo.save(customer);

			return token;
		} else {
			throw new CustomerNotFoundException("Could not find any customer with the email " + email);
		}
	}

	public Customer getByResetPasswordToken(String token) {
		return customerRepo.findByResetPasswordToken(token);
	}

	public void updatePassword(String token, String newPassword) throws CustomerNotFoundException {
		Customer customer = customerRepo.findByResetPasswordToken(token);
		if (customer == null) {
			throw new CustomerNotFoundException("No customer found: invalid token");
		}

		customer.setPassword(newPassword);
		customer.setResetPasswordToken(null);
		// encodePassword(customer);

		customerRepo.save(customer);
	}

	public void updatePassword(Customer customer, String newPassword) {
        customer.setPassword(passwordEncoder.encode(newPassword));
        customerRepo.save(customer);
    }
	
	public List<Customer> getAllCustomers() {
        return customerRepo.findAll();
    }
	
	public Customer createCustomer(CustomerDTO customerDTO) {
	    Customer customer = new Customer();
	    // Thiết lập các thuộc tính của customer từ customerDTO
	    customer.setFullName(customerDTO.getFullName());
	    customer.setEmail(customerDTO.getEmail());
	    customer.setPhoneNumber(customerDTO.getPhoneNumber());
	    customer.setPassword(customerDTO.getPassword());
	    // ...

	    // Tiến hành tạo customer và lưu vào cơ sở dữ liệu
	    return customerRepo.save(customer);
	}
	
	public void deleteCustomer(Long customerId) {
        customerRepo.deleteById(customerId);
    }
}
