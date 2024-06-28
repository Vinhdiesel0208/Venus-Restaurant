package com.mytech.restaurantportal.apis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.restaurant.service.entities.BookingTable;
import com.restaurant.service.services.ReservationService;

@RestController
@RequestMapping("/apis/v1/bookingtable")
public class BookingTableRestController {

	@Autowired
	private ReservationService reservationService;

	@PostMapping("/add")
	public ResponseEntity<BookingTable> create(@RequestBody BookingTable bookingTable) {
		System.out.println("Post add bookingTable API");
		System.out.println("BookingTable: " + bookingTable.toString());
		BookingTable bookingTable2 = new BookingTable(bookingTable.getName(), bookingTable.getEmail(),
				bookingTable.getPhone_number(), bookingTable.getDate(), bookingTable.getStart_time(),
				bookingTable.getEnd_time(), bookingTable.getPerson_number(), bookingTable.getTableId());     
		BookingTable savedBookingTable = reservationService.save(bookingTable2);
		return ResponseEntity.ok(savedBookingTable);
	}

}
