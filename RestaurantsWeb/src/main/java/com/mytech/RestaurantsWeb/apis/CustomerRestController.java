package com.mytech.RestaurantsWeb.apis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.RestaurantsWeb.dtos.CustomerLoginDTO;
import com.restaurant.service.dtos.CustomerDTO;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.services.CustomerService;
import com.mytech.RestaurantsWeb.service.PasswordResetToken;
import com.mytech.RestaurantsWeb.service.PasswordResetTokenService;
import com.restaurant.service.repositories.CustomerRepository;
import com.mytech.RestaurantsWeb.mailer.EmailService;
import com.mytech.RestaurantsWeb.mailer.ResetEmailService;
import com.mytech.RestaurantsWeb.security.AppUserDetails;

import jakarta.validation.Valid;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/apis/v1/customers")
@CrossOrigin(origins = "http://localhost:8082")
public class CustomerRestController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private PasswordResetTokenService passwordResetTokenService;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ResetEmailService resetEmailService;

    @GetMapping("/register")
    public ResponseEntity<?> viewRegisterPage() {
        return ResponseEntity.ok(new Customer());
    }

    @PostMapping("/register")
    public ResponseEntity<?> createCustomer(@Valid @RequestBody Customer customer, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        }
        customerService.registerCustomer(customer);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping("/forgot-password")
    public ResponseEntity<?> viewForgotPasswordPage() {
        return ResponseEntity.ok().build();
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<?> processForgotPassword(@RequestParam("email") String email) {
        Customer customer = customerRepository.findByEmail(email);
        if (customer == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Không tìm thấy tài khoản với địa chỉ email đó.");
        }

        String token = UUID.randomUUID().toString();
        passwordResetTokenService.createPasswordResetTokenForCustomer(customer, token);

        String resetUrl = "http://localhost:8082/reset-password?token=" + token;
        resetEmailService.sendPasswordResetEmail(customer.getEmail(), resetUrl);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/reset-password")
    public ResponseEntity<?> showResetPasswordPage(@RequestParam("token") String token) {
        PasswordResetToken resetToken = passwordResetTokenService.findByToken(token);
        if (resetToken == null || resetToken.isExpired()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Token không hợp lệ hoặc đã hết hạn.");
        }
        return ResponseEntity.ok(token);
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> handlePasswordReset(@RequestParam("token") String token,
                                                 @RequestParam("newPassword") String newPassword,
                                                 @RequestParam("confirmPassword") String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Mật khẩu xác nhận không khớp.");
        }

        PasswordResetToken resetToken = passwordResetTokenService.findByToken(token);
        if (resetToken == null || resetToken.isExpired()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Token không hợp lệ hoặc đã hết hạn.");
        }

        Customer customer = resetToken.getCustomer();
        customerService.updatePassword(customer, newPassword);
        passwordResetTokenService.delete(resetToken);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/user_detail")
    public ResponseEntity<?> viewUserDetail(@AuthenticationPrincipal AppUserDetails loggedUser) {
        Long cusId = loggedUser.getId();
        Optional<Customer> cus = customerRepository.findById(cusId);

        if (cus.isPresent()) {
            return ResponseEntity.ok(cus.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Customer not found");
        }
    }

    @PostMapping("/update_user")
    public ResponseEntity<?> updateUser(@RequestParam("email") String email, @RequestParam("fullName") String fullName, @RequestParam("phoneNumber") String phoneNumber) {
        Optional<Customer> optionalCustomer = Optional.ofNullable(customerRepository.findByEmail(email));
        if (optionalCustomer.isPresent()) {
            Customer customer = optionalCustomer.get();
            customer.setFullName(fullName);
            customer.setPhoneNumber(phoneNumber);
            customerRepository.save(customer);
            return ResponseEntity.ok(customer);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Customer not found");
        }
    }

    @PostMapping("/change_password")
    public ResponseEntity<?> changePassword(@RequestParam("currentPassword") String currentPassword,
                                            @RequestParam("newPassword") String newPassword,
                                            Principal principal) {
        Customer customer = customerService.getCustomerByEmail(principal.getName());

        if (!passwordEncoder.matches(currentPassword, customer.getPassword())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Current password is incorrect.");
        }

        String encodedNewPassword = passwordEncoder.encode(newPassword);
        customer.setPassword(encodedNewPassword);
        customerService.updateCustomer(customer);

        return ResponseEntity.ok("Password updated successfully.");
    }

    @GetMapping("/customer")
    public ResponseEntity<List<CustomerDTO>> getAllCustomers() {
        List<CustomerDTO> customers = customerService.getAllCustomers().stream().map(customer -> {
            CustomerDTO dto = new CustomerDTO();
            dto.setId(customer.getId());
            dto.setFullName(customer.getFullName());
            dto.setEmail(customer.getEmail());
            dto.setPhoneNumber(customer.getPhoneNumber());
            return dto;
        }).collect(Collectors.toList());
        return ResponseEntity.ok(customers);
    }

    @PostMapping
    public ResponseEntity<Customer> createCustomer(@RequestBody CustomerDTO customerDTO) {
        Customer createdCustomer = customerService.createCustomer(customerDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCustomer);
    }

    @DeleteMapping("/{customerId}")
    public ResponseEntity<?> deleteCustomer(@PathVariable("customerId") Long customerId) {
        try {
            customerService.deleteCustomer(customerId);
            return ResponseEntity.ok(Map.of("message", "Khách hàng đã được xóa thành công."));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("message", "Lỗi khi xóa khách hàng: " + e.getMessage()));
        }
    }

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUserPhone(@RequestBody CustomerLoginDTO loginDto) {
        Customer customer = customerService.getCustomerByEmail(loginDto.getEmail());

        if (customer == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Customer not found");
        }

        if (!passwordEncoder.matches(loginDto.getPassword(), customer.getPassword())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid password");
        }

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginDto.getEmail(),
                        loginDto.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        return ResponseEntity.ok(customer);
    }
}




