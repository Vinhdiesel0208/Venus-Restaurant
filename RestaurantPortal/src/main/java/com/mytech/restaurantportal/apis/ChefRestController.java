package com.mytech.restaurantportal.apis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.restaurant.service.dtos.CartLineDTO;
import com.restaurant.service.entities.CartLine;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.enums.OrderStatus;
import com.restaurant.service.services.CartService;


import java.math.BigDecimal;
import java.util.List;

import java.util.stream.Collectors;

@RestController
@RequestMapping("/apis/v1/chef")
@CrossOrigin(origins = "http://localhost:8083") 
public class ChefRestController {
	@Autowired
	private CartService cartService;


	@GetMapping("/dishes")
	public ResponseEntity<List<CartLineDTO>> getAllCartLines() {
	    List<CartLineDTO> cartLines = cartService.listAllCartLines().stream().map(cartLine -> {
	        CartLineDTO dto = new CartLineDTO();
	        dto.setCartLineId(cartLine.getId());
	        dto.setOrderId(cartLine.getOrder().getId()); // Add this line
	        dto.setTableName(cartLine.getTableName());
	        dto.setIngredientId(cartLine.getIngredient().getId());
	        dto.setIngredientName(cartLine.getIngredient().getIngredientName());
	        dto.setOrderTime(cartLine.getOrderTime());
	        dto.setQuantity(cartLine.getQuantity());
	        dto.setPrice(cartLine.getPrice());
	        dto.setStatus(cartLine.getStatus());
	        dto.setIngredientPhoto(AppConstant.imageUrl + cartLine.getIngredientPhoto());
	        dto.setHalfPortion(cartLine.isHalfPortion());
	        return dto;
	    }).collect(Collectors.toList());
	    return ResponseEntity.ok(cartLines);
	}
	
	@PatchMapping("/updateCartLineQuantity/{cartLineId}")
	public ResponseEntity<String> updateCartLineQuantity(
	        @PathVariable("cartLineId") Long cartLineId,
	        @RequestParam("quantity") BigDecimal quantity) {
	    try {
	        CartLine cartLine = cartService.getCartLineById(cartLineId);
	        Ingredient ingredient = cartLine.getIngredient();

	        BigDecimal currentCartLineQuantity = cartLine.getQuantity();
	        BigDecimal quantityDifference = quantity.subtract(currentCartLineQuantity);
	        BigDecimal updatedStockQuantity = ingredient.getQuantityInStock().subtract(quantityDifference);

	        if (updatedStockQuantity.compareTo(BigDecimal.ZERO) < 0) {
	            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	                    .body("Not enough stock available");
	        }

	        cartService.updateQuantity(cartLineId, quantity);
	        return ResponseEntity.ok("Quantity updated successfully");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body("Failed to update quantity: " + e.getMessage());
	    }
	}



	


    @PostMapping("/checkout/{tableId}")
    public ResponseEntity<String> checkoutTable(@PathVariable("tableId") Long tableId) {
        System.out.println("Checkout endpoint hit for table ID: " + tableId);
        boolean result = cartService.checkoutTable(tableId);
        if (result) {
            return ResponseEntity.ok("Checkout completed successfully for table ID: " + tableId);
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to checkout table ID: " + tableId);
        }
    }

	@PreAuthorize("hasAuthority('CHEF')")
	@PostMapping("/updateStatus")
	public ResponseEntity<String> updateCartLineStatus(@RequestBody CartLineDTO cartLineDTO) {
		Long cartLineId = cartLineDTO.getCartLineId(); 
		OrderStatus status = cartLineDTO.getStatus();

		if (cartLineId == null || status == null) {
			return ResponseEntity.badRequest().body("Missing cartLineId or status");
		}

		try {
			cartService.updateCartLineStatus(cartLineId, status);
			return ResponseEntity.ok("Status updated successfully");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Failed to update status: " + e.getMessage());
		}
	}



	 @PreAuthorize("hasAuthority('STAFF')")
	    @GetMapping("/cartLines/{tableId}")
	    public ResponseEntity<List<CartLineDTO>> getCartLinesForTable(@PathVariable("tableId") Long tableId) {
	        List<CartLineDTO> cartLines = cartService.getCartLinesByTableId(tableId).stream().map(cartLine -> {
	            CartLineDTO dto = new CartLineDTO();
	            dto.setCartLineId(cartLine.getId());
	            dto.setOrderId(cartLine.getOrder().getId());
	            dto.setTableName(cartLine.getTableName());
	            dto.setRestaurantTableId(cartLine.getRestaurantTable().getId());
	            dto.setIngredientId(cartLine.getIngredient().getId());
	            dto.setIngredientName(cartLine.getIngredient().getIngredientName());
	            dto.setQuantity(cartLine.getQuantity());
	            dto.setPrice(cartLine.getPrice());
	            dto.setStatus(cartLine.getStatus());
	            dto.setIngredientPhoto(AppConstant.imageUrl + cartLine.getIngredientPhoto());
	            dto.setHalfPortion(cartLine.isHalfPortion());
	            dto.setOrderTime(cartLine.getOrderTime());
	            return dto;
	        }).collect(Collectors.toList());
	        return ResponseEntity.ok(cartLines);
	    }

	    @PreAuthorize("hasAuthority('STAFF')")
	    @PostMapping("/addToCart")
	    public ResponseEntity<String> addToCart(@RequestBody CartLineDTO cartLineDTO) {
	        try {
	            Long tableId = cartLineDTO.getRestaurantTableId();
	            Long ingredientId = cartLineDTO.getIngredientId();
	            BigDecimal quantity = cartLineDTO.getQuantity();
	            BigDecimal price = cartLineDTO.getPrice();
	            boolean halfPortion = cartLineDTO.isHalfPortion();
	            String tableName = cartLineDTO.getTableName();

	            cartService.addOrUpdateCartLine(tableId, ingredientId, quantity, price, halfPortion, tableName);

	            return ResponseEntity.ok("Added to cart successfully");
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to add to cart: " + e.getMessage());
	        }
	    }
    @PreAuthorize("hasAuthority('STAFF')")
    @DeleteMapping("/cartLine/{cartLineId}")
    public ResponseEntity<String> deleteCartLine(@PathVariable("cartLineId") Long cartLineId) {
        try {
            cartService.deleteCartLine(cartLineId);
            return ResponseEntity.ok("Deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to delete cart line: " + e.getMessage());
        }
    }


}
