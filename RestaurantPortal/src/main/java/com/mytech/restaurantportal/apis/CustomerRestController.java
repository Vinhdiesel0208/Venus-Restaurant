package com.mytech.restaurantportal.apis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mytech.restaurantportal.mailer.EmailService;
import com.restaurant.service.dtos.CartLineDTO;
import com.restaurant.service.dtos.CustomerDTO;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.services.CartService;
import com.restaurant.service.services.CustomerService;

@RestController
@RequestMapping("/apis/v1/customer")
@CrossOrigin(origins = "http://localhost:8083")
public class CustomerRestController {

    @Autowired
    private CustomerService customerService;
    @Autowired
    private EmailService emailService;
    @Autowired
    private CartService cartService;

    @GetMapping("/get")
    public ResponseEntity<CustomerDTO> getCustomerByEmail(@RequestParam("email") String email) {
        Customer customer = customerService.findByEmail(email);
        if (customer == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        CustomerDTO customerDTO = new CustomerDTO();
        customerDTO.setFullName(customer.getFullName());
        customerDTO.setEmail(customer.getEmail());
        customerDTO.setPoints(customer.getPoints());

        return ResponseEntity.ok(customerDTO);
    }
    @PostMapping("/redeem-points")
    public ResponseEntity<String> redeemPoints(@RequestParam("email") String email, @RequestParam("totalAmount") double totalAmount, @RequestParam("tableId") Long tableId) {
        try {
            Customer customer = customerService.findByEmail(email);
            double discountAmount = customer.getPoints() / 10.0; // calculate discount based on current points
            double finalAmount = totalAmount - discountAmount;

            if (finalAmount < 0) finalAmount = 0;

            // Redeem points after calculating discount
            customerService.redeemPoints(email, finalAmount); // Redeem points based on finalAmount

            List<CartLineDTO> orderItems = cartService.getCartLinesByTableId(tableId).stream().map(cartLine -> {
                CartLineDTO dto = new CartLineDTO();
                dto.setCartLineId(cartLine.getId());
                dto.setOrderId(cartLine.getOrder().getId());
                dto.setTableName(cartLine.getTableName());
                dto.setIngredientId(cartLine.getIngredient().getId());
                dto.setIngredientName(cartLine.getIngredient().getIngredientName());
                dto.setQuantity(cartLine.getQuantity());
                dto.setPrice(cartLine.getPrice());
                dto.setStatus(cartLine.getStatus());
                dto.setIngredientPhoto(cartLine.getIngredientPhoto());
                dto.setHalfPortion(cartLine.isHalfPortion());
                return dto;
            }).collect(Collectors.toList());

            // Debug thông tin orderItems
            System.out.println("Order Items:");
            for (CartLineDTO item : orderItems) {
                System.out.println("Item: " + item.getIngredientName() + ", Quantity: " + item.getQuantity() + ", Price: " + item.getPrice());
            }

            // Round finalAmount to 2 decimal places
            finalAmount = Math.round(finalAmount * 100.0) / 100.0;

            sendPointsInfoEmail(customer.getEmail(), customer.getPoints(), totalAmount, discountAmount, finalAmount, orderItems);

            return ResponseEntity.ok("Points redeemed successfully. Final amount: " + finalAmount + ". New points: " + customer.getPoints());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to redeem points: " + e.getMessage());
        }
    }



    // Phương thức gửi email thông báo điểm thưởng và hóa đơn
    private void sendPointsInfoEmail(String email, int customerPoints, double orderTotal, double orderDiscount, double finalAmount, List<CartLineDTO> orderItems) {
        String subject = "Your Reward Points Information and Order Invoice";

        Map<String, Object> templateModel = new HashMap<>();
        templateModel.put("points", customerPoints);
        templateModel.put("orderTotal", orderTotal);
        templateModel.put("orderDiscount", orderDiscount);
        templateModel.put("finalAmount", finalAmount);
        templateModel.put("orderItems", orderItems);

        // Debug: Print orderItems to console
        System.out.println("Order Items in sendPointsInfoEmail:");
        for (CartLineDTO item : orderItems) {
            System.out.println("Item: " + item.getIngredientName() + ", Quantity: " + item.getQuantity() + ", Price: " + item.getPrice());
        }

        try {
            System.out.println("Sending email to: " + email);
            emailService.sendHtmlMessage(email, subject, templateModel, "apps/emails/points-info-template");
            System.out.println("Email sent successfully to: " + email);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to send email to: " + email + " - " + e.getMessage());
        }
    }


    @PostMapping("/update-points")
    public ResponseEntity<String> updatePoints(@RequestParam("email") String email, @RequestParam("totalAmount") double totalAmount, @RequestParam("tableId") Long tableId) {
        try {
            System.out.println("Update Points: email = " + email + ", totalAmount = " + totalAmount + ", tableId = " + tableId); // Debug info
            customerService.updatePointsByEmail(email, totalAmount);
            Customer customer = customerService.findByEmail(email);
            double discountAmount = 0; // no discount when just updating points
            double finalAmount = totalAmount;
            customerService.updatePointsByEmail(email, totalAmount);
            // Lấy thông tin món ăn trong giỏ hàng
            List<CartLineDTO> orderItems = cartService.getCartLinesByTableId(tableId).stream().map(cartLine -> {
                CartLineDTO dto = new CartLineDTO();
                dto.setCartLineId(cartLine.getId());
                dto.setOrderId(cartLine.getOrder().getId());
                dto.setTableName(cartLine.getTableName());
                dto.setIngredientId(cartLine.getIngredient().getId());
                dto.setIngredientName(cartLine.getIngredient().getIngredientName());
                dto.setQuantity(cartLine.getQuantity());
                dto.setPrice(cartLine.getPrice());
                dto.setStatus(cartLine.getStatus());
                dto.setIngredientPhoto(cartLine.getIngredientPhoto());
                dto.setHalfPortion(cartLine.isHalfPortion());
                return dto;
            }).collect(Collectors.toList());

            // Gửi email thông báo
            sendPointsInfoEmail(customer.getEmail(), customer.getPoints(), totalAmount, 0, totalAmount, orderItems);

            return ResponseEntity.ok("Points updated successfully.");
        } catch (Exception e) {
            e.printStackTrace(); // Thêm log lỗi
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update points: " + e.getMessage());
        }
    }


    @ExceptionHandler({ MissingServletRequestParameterException.class })
    public ResponseEntity<String> handleMissingParams(MissingServletRequestParameterException ex) {
        String name = ex.getParameterName();
        System.out.println(name + " parameter is missing");
        ex.printStackTrace();
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(name + " parameter is missing");
    }
}
