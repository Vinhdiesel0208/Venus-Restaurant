package com.mytech.restaurantportal.controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itextpdf.text.DocumentException;
import com.mytech.restaurantportal.exporters.OrderPdfExporter;
import com.mytech.restaurantportal.helpers.AppConstant;
import com.restaurant.service.entities.Order;
import com.restaurant.service.entities.OrderItem;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.paging.PagingAndSortingParam;
import com.restaurant.service.services.OrderItemService;
import com.restaurant.service.services.OrderService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/order")
public class OrderController {

	private String defaultRedirectURL = "redirect:/order/page/1?sortField=ordertime&sortDir=asc";
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderItemService orderItemService;

	@GetMapping("")
	public String getOrderList(Model model) {
		model.addAttribute("moduleURL", "/order"); // Adjust according to your mapping
		return listByPage(model, 1, "id", "desc", "" ,"date");
	}

	@GetMapping("/page")
	public String listByPage() {
		return "redirect:/order/page/1";
	}

	@GetMapping("/page/{pageNum}")
	public String listByPage(Model model, @PathVariable(name = "pageNum") int pageNum,
			@RequestParam(name = "sortField", defaultValue = "id", required = false) String sortField,
			@RequestParam(name = "sortDir", defaultValue = "desc", required = false) String sortDir,
			@RequestParam(name = "searchText", defaultValue = "", required = false) String searchText,
			@RequestParam(name = "date", required = false) String date) {

		// Ensure the sortField is a valid attribute of the entity
		String validSortField = validateSortField(sortField);
		PagingAndSortingHelper helper = new PagingAndSortingHelper(model, "orders", validSortField, sortDir,
				searchText);
		orderService.listOrderByPage(pageNum, 5, helper);

	
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("sortField", validSortField);
		model.addAttribute("sortDir", "desc");
		model.addAttribute("reverseSortDir", sortDir.equals("desc") ? "asc" : "desc");
		model.addAttribute("searchText", searchText);
	    model.addAttribute("moduleURL", "/order");
	    model.addAttribute("date", date);
		return "/apps/order/list";
	}

	private String validateSortField(String sortField) {
		// Replace this with the actual validation logic for your entity
		if ("id".equals(sortField) || "email".equals(sortField) || "fullName".equals(sortField)) {
			return sortField;
		}
		return "id"; // default sort field
	}

	@PostMapping("/search")
	public String search(@RequestParam(name = "searchText") String searchText, Model model) {
		return listByPage(model, 1, "id", "asc", searchText,"date");
	}


	@GetMapping("/{orderId}/items")
	public String getOrderItemsByOrderId(@PathVariable("orderId") Long orderId, Model model) {
	    List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(orderId)
	                                                 .stream()
	                                                 .filter(orderItem -> orderItem.getIngredient() != null)
	                                                 .collect(Collectors.toList());
	    model.addAttribute("orderItems", orderItems);
	    return "/apps/order/order-items";
	}


	@GetMapping("/export/pdf/{orderId}")
	public void exportOrderItemsToPDF(@PathVariable("orderId") Long orderId, HttpServletResponse response)
			throws IOException, DocumentException {
		List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(orderId);
		OrderPdfExporter exporter = new OrderPdfExporter();
		exporter.export(orderItems, response);
	}

	@PostMapping("/export")
	public void exportOrderItems(HttpServletResponse response, @RequestParam(name = "format") String format,
			@RequestParam(name = "orderId") Long orderId) throws IOException, DocumentException {
		System.out.println("Order export: " + format + " for order ID: " + orderId);

		List<OrderItem> orderItems = orderItemService.getOrderItemsByOrderId(orderId);

		OrderPdfExporter exporter = new OrderPdfExporter();
		exporter.export(orderItems, response);
	}
}
