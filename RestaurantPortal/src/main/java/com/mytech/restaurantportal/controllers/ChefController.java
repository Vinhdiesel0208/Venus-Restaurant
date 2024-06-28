package com.mytech.restaurantportal.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mytech.restaurantportal.security.AppUserDetails;
import com.nimbusds.jose.shaded.gson.Gson;

import com.restaurant.service.entities.CartLine;

import com.restaurant.service.enums.OrderStatus;

import com.restaurant.service.services.CartService;

@Controller
@RequestMapping("/chef")
public class ChefController {
    @Autowired
    private CartService cartService;
  
    
    
   
    

        
    @GetMapping("/list")
    public String viewMenuPage(Model model) {
        List<CartLine> cartLines = cartService.listAllCartLines();
        model.addAttribute("cartLines", cartLines); // Already sorted by recent orderTime
        return "/apps/chef/list";
    }

    
    @PostMapping("/serveDishes")
    @ResponseBody
    public ResponseEntity<String> serveDishes(@RequestParam("dishIds[]") List<Long> dishIds, @RequestParam("status") OrderStatus status) {
        try {
            for (Long dishId : dishIds) {
                cartService.updateCartLineStatus(dishId, status);
            }
            return new ResponseEntity<>("Dish status updated successfully.", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
   
    @PostMapping("/updateStatus")
    @ResponseBody
    public ResponseEntity<?> updateStatus(@RequestParam("cartLineId") Long cartLineId, @RequestParam("status") String status) {
        try {
            OrderStatus orderStatus = OrderStatus.valueOf(status); // Chuyển đổi String sang enum
            cartService.updateCartLineStatus(cartLineId, orderStatus);
            return ResponseEntity.ok(Map.of("message", "Dish status updated successfully."));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("message", "An error occurred: " + e.getMessage()));
        }
     
        
        
    }





    
   
    


    

}

