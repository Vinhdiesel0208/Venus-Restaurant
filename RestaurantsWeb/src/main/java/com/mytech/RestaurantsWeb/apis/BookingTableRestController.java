package com.mytech.RestaurantsWeb.apis;

import java.util.List;

import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.restaurant.service.entities.BookingTable;
import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.services.ReservationService;
import com.restaurant.service.services.RestaurantTableService;

@RestController
@RequestMapping("/apis/v1/bookingtable")
public class BookingTableRestController {

	@Autowired
	private RestaurantTableService restaurantTableService;

	@Autowired
	private ReservationService reservationService;

	@PostMapping
	public ResponseEntity<BookingTable> create(@RequestBody BookingTable bookingTable) {
	    try {
	    	System.out.println("Post add bookingTable API");
	        System.out.println("BookingTable: " + bookingTable.toString());
	        BookingTable bookingTable2 = new BookingTable(
	            bookingTable.getName(),
	            bookingTable.getEmail(),
	            bookingTable.getPhone_number(),
	            bookingTable.getDate(),
	            bookingTable.getStart_time(),
	            bookingTable.getEnd_time(),
	            bookingTable.getPerson_number(),
	            bookingTable.getTableId()             
	        );
	        BookingTable savedBookingTable = reservationService.save(bookingTable2);
	        return ResponseEntity.ok(savedBookingTable);
	    } catch (Exception e) {
	        System.err.println("Error creating booking table: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.SC_INTERNAL_SERVER_ERROR).build();
	    }
	}

	@GetMapping("/tablelist")
	public ResponseEntity<List<RestaurantTable>> findtable(@RequestParam(name = "person_number") Integer person_number,
			@RequestParam(name = "date") String date, @RequestParam(name = "start_time") String start_time,
			@RequestParam(name = "end_time") String end_time) {
		System.out.println("Get tablelist API");
		List<RestaurantTable> listTable = restaurantTableService.listTableByPerson(person_number, date, start_time,
				end_time);
		return ResponseEntity.ok(listTable);
	}
}
