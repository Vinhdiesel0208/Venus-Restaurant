package com.restaurant.service.services;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.CartLine;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.entities.Order;
import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.enums.IngredientStatus;
import com.restaurant.service.enums.OrderStatus;
import com.restaurant.service.repositories.CartLineRepository;
import com.restaurant.service.repositories.IngredientRepository;
import com.restaurant.service.repositories.OrderRepository;
import com.restaurant.service.repositories.RestaurantTableRespository;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class CartService {

	private Map<String, List<CartLine>> temporaryCartLines = new HashMap<>();

	@Autowired
	private IngredientRepository ingredientRepository;

	@Autowired
	private RestaurantTableRespository restaurantTableRespository;

	@Autowired
	private CartLineRepository cartLineRepository;
	@Autowired
	private OrderRepository orderRepository;
	@Autowired
    private EmailService emailService;
	
	
	public void clearOrderHistoryByTableName(String tableName) {
        Iterator<CartLine> iterator = orderHistory.iterator();
        while (iterator.hasNext()) {
            CartLine cartLine = iterator.next();
            if (cartLine.getTableName().equals(tableName)) {
                iterator.remove();
            }
        }
    }
	// add to cart
	@Transactional
	public void addOrUpdateCartLine(Long tableId, Long ingredientId, BigDecimal quantity, BigDecimal price,
			boolean halfPortion, String tableName) {
		List<CartLine> pendingCartLines = cartLineRepository.findByTableIdAndStatus(tableId, OrderStatus.PENDING);
		Order order;
		if (pendingCartLines.isEmpty()) {
			// Create new order if no pending order exists
			order = new Order();
			order.setRestaurantTableId(tableId);
			order.setOrdertime(LocalDateTime.now());
			orderRepository.save(order);
		} else {
			// Use existing order
			order = pendingCartLines.get(0).getOrder();
		}

		Ingredient ingredient = ingredientRepository.findById(ingredientId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid ingredientId"));
		RestaurantTable restaurantTable = restaurantTableRespository.findById(tableId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid tableId"));

		BigDecimal availableQuantity = ingredient.getQuantityInStock();
		if (availableQuantity.compareTo(quantity) < 0) {
			throw new IllegalStateException("Not enough stock available");
		}

		// Subtract the quantity from stock
		BigDecimal newQuantityInStock = availableQuantity.subtract(quantity);
		ingredient.setQuantityInStock(newQuantityInStock);
		if (newQuantityInStock.compareTo(BigDecimal.ZERO) == 0) {
			ingredient.setStatus(IngredientStatus.OutofStock);
			String subject = "Thông báo hết hàng";
            String text = "Số lượng hàng của " + ingredient.getIngredientName() + " đã hết, hãy bổ sung hàng vào kho.";
            emailService.sendSimpleMessage("hdviettien@gmail.com", subject, text);
		}
		ingredientRepository.save(ingredient);

		CartLine cartLine = new CartLine();
		cartLine.setIngredient(ingredient);
		cartLine.setRestaurantTable(restaurantTable);
		cartLine.setQuantity(quantity);
		cartLine.setPrice(price);
		cartLine.setHalfPortion(halfPortion);
		cartLine.setStatus(OrderStatus.PENDING);
		cartLine.setTableName(tableName);
		cartLine.setOrderTime(LocalDateTime.now());
		cartLine.setOrder(order);
		cartLineRepository.save(cartLine);
	}

	@Transactional
	public Order createOrderAndAddCartLine(Long ingredientId, Long tableId, BigDecimal quantity, BigDecimal price,
			Boolean halfPortion, String tableName) {
		Ingredient ingredient = ingredientRepository.findById(ingredientId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid ingredientId"));
		RestaurantTable restaurantTable = restaurantTableRespository.findById(tableId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid tableId"));

		BigDecimal availableQuantity = ingredient.getQuantityInStock();
		if (availableQuantity.compareTo(quantity) < 0) {
			return null;
		}
		BigDecimal newQuantityInStock = availableQuantity.subtract(quantity);
		ingredient.setQuantityInStock(newQuantityInStock);
		if (newQuantityInStock.compareTo(BigDecimal.ZERO) == 0) {
			ingredient.setStatus(IngredientStatus.OutofStock);
		}
		ingredientRepository.save(ingredient);

		List<CartLine> pendingCartLines = cartLineRepository.findByTableIdAndStatus(tableId, OrderStatus.PENDING);
		Order order;
		if (pendingCartLines.isEmpty()) {
			order = new Order();
			order.setRestaurantTableId(tableId);
			order.setOrdertime(LocalDateTime.now());
			orderRepository.save(order);
		} else {
			order = pendingCartLines.get(0).getOrder();
		}

		// Tạo và lưu một CartLine mới
		CartLine cartLine = new CartLine();
		cartLine.setIngredient(ingredient);
		cartLine.setRestaurantTable(restaurantTable);
		cartLine.setQuantity(quantity);
		cartLine.setPrice(price);
		cartLine.setHalfPortion(halfPortion);
		cartLine.setStatus(OrderStatus.PENDING);
		cartLine.setTableName(tableName);
		cartLine.setOrderTime(LocalDateTime.now());
		cartLine.setOrder(order);
		cartLineRepository.save(cartLine);

		orderHistory.add(cartLine);
		Collections.sort(orderHistory, Comparator.comparing(CartLine::getOrderTime).reversed());
		temporaryCartLines.remove(tableName);

		return order;
	}

	@Transactional
	public void addCartLineToOrder(Long orderId, Long ingredientId, Long tableId, BigDecimal quantity, BigDecimal price,
			Boolean halfPortion, String tableName) {
		Ingredient ingredient = ingredientRepository.findById(ingredientId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid ingredientId"));
		RestaurantTable restaurantTable = restaurantTableRespository.findById(tableId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid tableId"));
		Order order = orderRepository.findById(orderId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid orderId"));

		// Create and save a new CartLine
		CartLine cartLine = new CartLine();
		cartLine.setIngredient(ingredient);
		cartLine.setRestaurantTable(restaurantTable);
		cartLine.setQuantity(quantity);
		cartLine.setPrice(price);
		cartLine.setHalfPortion(halfPortion);
		cartLine.setStatus(OrderStatus.PENDING);
		cartLine.setTableName(tableName);
		cartLine.setOrderTime(LocalDateTime.now());
		cartLine.setOrder(order);
		cartLineRepository.save(cartLine);

		orderHistory.add(cartLine);
		Collections.sort(orderHistory, Comparator.comparing(CartLine::getOrderTime).reversed());
	}

	@Transactional
	public boolean checkoutTable(Long tableId) {
		try {
			List<CartLine> cartLines = cartLineRepository.findByRestaurantTableId(tableId);
			if (cartLines.isEmpty()) {
				return false;
			}

			Order order = cartLines.get(0).getOrder(); // Giả sử tất cả các dòng giỏ hàng thuộc về cùng một đơn hàng

			double total = cartLines.stream()
					.mapToDouble(cartLine -> cartLine.getPrice().doubleValue() * cartLine.getQuantity().doubleValue())
					.sum();
			double tax = total * 0.1; // 10% thuế
			double total1 = total + tax;

			order.setTotal(total);
			order.setTax(tax);
			order.setTotal1(total1);

			orderRepository.save(order);

			for (CartLine cartLine : cartLines) {
				cartLine.setStatus(OrderStatus.COMPLETED);
				cartLineRepository.save(cartLine);
			}

			cartLineRepository.deleteAll(cartLines);

			Optional<RestaurantTable> tableOptional = restaurantTableRespository.findById(tableId);
			if (tableOptional.isPresent()) {
				RestaurantTable table = tableOptional.get();
				table.setStatus(true); // true: available, false: occupied
				restaurantTableRespository.save(table);
			} else {
				throw new RuntimeException("Table not found");
			}

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<CartLine> getCartLinesByTableId(Long tableId) {
		List<CartLine> cartLines = cartLineRepository.findByRestaurantTableId(tableId);
		System.out.println("Found " + cartLines.size() + " cart lines for table ID: " + tableId);
		for (CartLine cartLine : cartLines) {
			System.out.println("CartLine - Ingredient: " + cartLine.getIngredient().getIngredientName() + ", Quantity: "
					+ cartLine.getQuantity() + ", Price: " + cartLine.getPrice());
		}
		return cartLines;
	}

	public List<CartLine> listCartLines(String tableName) {
		return temporaryCartLines.getOrDefault(tableName, new ArrayList<>());
	}

	// Modify this method to include sorting
	public List<CartLine> listAllCartLines() {
		return cartLineRepository.findAll(Sort.by(Sort.Direction.DESC, "orderTime"));
	}

	public void updateCartLineStatus(Long id, OrderStatus status) {
		try {
			CartLine cartLine = cartLineRepository.findById(id)
					.orElseThrow(() -> new EntityNotFoundException("CartLine not found with id: " + id));
			cartLine.setStatus(status);
			cartLineRepository.save(cartLine);
			System.out.println("Updated CartLine ID: " + id + " to status: " + status);
		} catch (Exception e) {
			System.out.println("Error updating CartLine status: " + e.getMessage());
			throw e;
		}
	}

	public List<CartLine> listAllCartLinesByStatus(OrderStatus status) {
		return cartLineRepository.findByStatus(status);
	}

	public void deleteCartLine(Long cartLineId) {

		if (!cartLineRepository.existsById(cartLineId)) {
			throw new RuntimeException("CartLine không tìm thấy với ID: " + cartLineId);
		}

		cartLineRepository.deleteById(cartLineId);
	}

	public Map<String, Object> addIngredient(Long ingredientId, Long tableId, BigDecimal quantity, BigDecimal price,
			String tableName, boolean isReady, boolean isPreparing, boolean halfPortion) {
		Ingredient ingredient = ingredientRepository.findById(ingredientId).orElse(null);
		RestaurantTable restaurantTable = restaurantTableRespository.findById(tableId).orElse(null);
		Map<String, Object> response = new HashMap<>();

		OrderStatus status;
		if (isPreparing) {
			status = OrderStatus.PREPARING;
		} else if (isReady) {
			status = OrderStatus.READY;
		} else {
			status = OrderStatus.PENDING;
		}
		// Add a null check for status
		if (status == null) {
			status = OrderStatus.PENDING; // Default status or throw an exception
		}

		if (ingredient == null || restaurantTable == null) {
			response.put("cartLine", null);
			response.put("total", BigDecimal.ZERO);
			return response;
		}

		BigDecimal availableQuantity = ingredient.getQuantityInStock();

		BigDecimal totalQuantityInCart = BigDecimal.ZERO;
		List<CartLine> cartLinesForTable = temporaryCartLines.get(tableName);
		if (cartLinesForTable != null) {
			for (CartLine cartLine : cartLinesForTable) {
				if (cartLine.getIngredient().getId().equals(ingredientId)) {
					totalQuantityInCart = totalQuantityInCart.add(cartLine.getQuantity());
				}
			}
		}

		BigDecimal newTotalQuantity = totalQuantityInCart.add(quantity);

		if (newTotalQuantity.compareTo(availableQuantity) > 0) {
			response.put("error", "Số lượng món ăn yêu cầu vượt quá số lượng có sẵn trong kho.");
			return response;
		}

		if (totalQuantityInCart.compareTo(BigDecimal.ZERO) > 0) {
			for (CartLine cartLine : cartLinesForTable) {
				if (cartLine.getIngredient().getId().equals(ingredientId)
						&& cartLine.isHalfPortion() == (quantity.compareTo(BigDecimal.valueOf(0.5)) == 0)) {
					BigDecimal newQuantity = cartLine.getQuantity().add(quantity);
					cartLine.setQuantity(newQuantity);
					response.put("cartLine", cartLine);
					response.put("total", calculateTotalForTable(tableName));
					return response;
				}
			}
		}

		CartLine cartLine = new CartLine();
		cartLine.setIngredient(ingredient);
		cartLine.setQuantity(quantity);
		cartLine.setRestaurantTable(restaurantTable);
		cartLine.setPrice(price);
		cartLine.setStatus(status);
		cartLine.setTableName(tableName);

		cartLine.setHalfPortion(quantity.compareTo(BigDecimal.valueOf(0.5)) == 0);

		temporaryCartLines.computeIfAbsent(tableName, k -> new ArrayList<>()).add(cartLine);

		response.put("cartLine", cartLine);
		response.put("total", calculateTotalForTable(tableName));
		return response;
	}

	public void saveCartLine(CartLine cartLine) {
		cartLineRepository.save(cartLine);
	}

	public CartLine getCartLineById(Long id) {
		return cartLineRepository.findById(id).orElse(null);
	}

	public List<CartLine> getOrderHistory() {
		return orderHistory;
	}

	public void clearOrderHistory() {
		orderHistory.clear();
	}

	public Map<String, Object> removeIngredient(Long ingredientId, Long tableId, BigDecimal quantityToRemove,
			BigDecimal price, String tableName, boolean status, boolean orderStatus) {
		Ingredient ingredient = ingredientRepository.findById(ingredientId).orElse(null);
		Map<String, Object> response = new HashMap<>();

		if (ingredient == null) {
			response.put("cartLine", null);
			response.put("total", BigDecimal.ZERO);
			return response;
		}

		List<CartLine> cartLinesForTable = temporaryCartLines.get(tableName);
		if (cartLinesForTable != null) {
			for (CartLine cartLine : cartLinesForTable) {
				if (cartLine.getIngredient().getId().equals(ingredientId)
						&& cartLine.isHalfPortion() == (quantityToRemove.compareTo(BigDecimal.valueOf(0.5)) == 0)) {
					BigDecimal newQuantity = cartLine.getQuantity().subtract(quantityToRemove);
					if (newQuantity.compareTo(BigDecimal.ZERO) <= 0) {
						cartLinesForTable.remove(cartLine);
					} else {
						cartLine.setQuantity(newQuantity);
					}
					response.put("cartLine", null);
					response.put("total", calculateTotalForTable(tableName));
					return response;
				}
			}
		}

		response.put("cartLine", null);
		response.put("total", calculateTotalForTable(tableName));
		return response;
	}

	private List<CartLine> orderHistory = new ArrayList<>();

	public CartLine createCartLine(Long ingredientId, Long tableId, BigDecimal quantity, BigDecimal price,
			Boolean halfPortion, Boolean orderStatus, String tableName) {
		Ingredient ingredient = ingredientRepository.findById(ingredientId).orElse(null);
		RestaurantTable restaurantTable = restaurantTableRespository.findById(tableId).orElse(null);

		if (ingredient == null || restaurantTable == null) {
			return null;
		}

		BigDecimal availableQuantity = ingredient.getQuantityInStock();
		if (availableQuantity.compareTo(quantity) < 0) {
			return null;
		}
		BigDecimal newQuantityInStock = availableQuantity.subtract(quantity);

		ingredient.setQuantityInStock(newQuantityInStock);
		ingredient.setQuantityInStock(newQuantityInStock);
		if (newQuantityInStock.compareTo(BigDecimal.ZERO) == 0) {
			ingredient.setStatus(IngredientStatus.OutofStock);
		}
		ingredientRepository.save(ingredient);

		CartLine cartLine = new CartLine();
		cartLine.setIngredient(ingredient);
		cartLine.setRestaurantTable(restaurantTable);
		cartLine.setQuantity(quantity);
		cartLine.setPrice(price);
		cartLine.setHalfPortion(halfPortion);
		OrderStatus status = orderStatus ? OrderStatus.PENDING : OrderStatus.COMPLETED;
		cartLine.setStatus(status);
		cartLine.setTableName(tableName);
		cartLine.setOrderTime(LocalDateTime.now());

		orderHistory.add(cartLine);
		Collections.sort(orderHistory, Comparator.comparing(CartLine::getOrderTime).reversed());
		cartLineRepository.save(cartLine);
		temporaryCartLines.remove(tableName);

		return cartLine;
	}

	public List<CartLine> getTemporaryOrderedItems() {
		List<CartLine> temporaryOrderedItemsList = new ArrayList<>();
		temporaryCartLines.values().forEach(temporaryOrderedItemsList::addAll);
		return temporaryOrderedItemsList;
	}

	public List<CartLine> getOrderHistoryCheckout(String tableName) {
		List<CartLine> orderHistoryCheckout = new ArrayList<>();

		for (CartLine order : orderHistory) {
			if (order.getTableName().equals(tableName)) {
				CartLine newOrder = new CartLine();
				newOrder.setIngredient(order.getIngredient());
				newOrder.setHalfPortion(order.isHalfPortion());
				newOrder.setQuantity(order.getQuantity());
				newOrder.setPrice(order.getPrice());

				boolean merged = false;

				for (CartLine checkoutOrder : orderHistoryCheckout) {
					if (newOrder.getIngredient().getId().equals(checkoutOrder.getIngredient().getId())
							&& newOrder.isHalfPortion() == checkoutOrder.isHalfPortion()) {
						BigDecimal newQuantity = checkoutOrder.getQuantity().add(newOrder.getQuantity());
						checkoutOrder.setQuantity(newQuantity);
						merged = true;
						break;
					}
				}

				if (!merged) {
					orderHistoryCheckout.add(newOrder);
				}
			}
		}

		return orderHistoryCheckout;
	}

//	public void updateQuantity(Long cartLineId, BigDecimal quantity) {
//
//		temporaryCartLines.values().forEach(cartLines -> cartLines.forEach(cartLine -> {
//			if (cartLine.getId().equals(cartLineId)) {
//				cartLine.setQuantity(quantity);
//			}
//		}));
//	}

	@Transactional
	public void updateQuantity(Long cartLineId, BigDecimal quantity) {
	    CartLine cartLine = cartLineRepository.findById(cartLineId)
	            .orElseThrow(() -> new IllegalArgumentException("Invalid cartLineId: " + cartLineId));
	    Ingredient ingredient = cartLine.getIngredient();

	    BigDecimal currentCartLineQuantity = cartLine.getQuantity();
	    BigDecimal quantityDifference = quantity.subtract(currentCartLineQuantity);
	    BigDecimal updatedStockQuantity = ingredient.getQuantityInStock().subtract(quantityDifference);

	    if (updatedStockQuantity.compareTo(BigDecimal.ZERO) < 0) {
	        throw new IllegalArgumentException("Not enough stock available");
	    }

	    cartLine.setQuantity(quantity);
	    ingredient.setQuantityInStock(updatedStockQuantity);

	    cartLineRepository.save(cartLine);
	    ingredientRepository.save(ingredient);
	}




	public void removeCartItem(Long ingredientId, String tableName, boolean isHalfPortion) {
		List<CartLine> cartLinesForTable = temporaryCartLines.get(tableName);
		if (cartLinesForTable != null) {
			cartLinesForTable.removeIf(cartLine -> cartLine.getIngredient().getId().equals(ingredientId)
					&& cartLine.isHalfPortion() == isHalfPortion);
		}
	}

	public void clearCart(String tableName) {

		temporaryCartLines.remove(tableName);
	}

	public BigDecimal calculateTotalForTable(String tableName) {
		BigDecimal totalForTable = BigDecimal.ZERO;
		List<CartLine> cartLinesForTable = temporaryCartLines.getOrDefault(tableName, new ArrayList<>());
		for (CartLine cartLine : cartLinesForTable) {
			BigDecimal lineTotal;
			if (cartLine.isHalfPortion()) {
				lineTotal = cartLine.getPrice().multiply(cartLine.getQuantity().multiply(BigDecimal.valueOf(2)));
			} else {
				lineTotal = cartLine.getPrice().multiply(cartLine.getQuantity());
			}
			totalForTable = totalForTable.add(lineTotal);
		}
		return totalForTable;
	}

	public Map<String, List<CartLine>> getTemporaryCartLines() {
		return temporaryCartLines;
	}

}
