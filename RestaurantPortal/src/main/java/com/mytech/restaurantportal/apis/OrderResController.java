package com.mytech.restaurantportal.apis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.restaurant.service.entities.Order;
import com.restaurant.service.services.OrderService;

@RestController
@RequestMapping("/apis/v1/order")
public class OrderResController {
	@Autowired
    private final OrderService orderService;
    

    
    public OrderResController(OrderService orderService) {
        this.orderService = orderService;
        
    }

    @GetMapping("/list")
    public ResponseEntity<List<Order>> getOrderList() {
        List<Order> orders = orderService.getAllOrder();
        return ResponseEntity.ok(orders);
    }
}
