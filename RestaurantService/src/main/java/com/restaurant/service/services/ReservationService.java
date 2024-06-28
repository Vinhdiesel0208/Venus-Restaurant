package com.restaurant.service.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.BookingTable;
import com.restaurant.service.entities.Reservation;
import com.restaurant.service.entities.TableM;
import com.restaurant.service.repositories.BookingTableRepository;
import com.restaurant.service.repositories.ReservationInFoRepository;
import com.restaurant.service.repositories.ReservationRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ReservationService {

	@Autowired
	private BookingTableRepository bookTableRepository;

	@Autowired
	private ReservationRepository reservationRepository;

	@Autowired
	private ReservationInFoRepository reservationInFoRepository;

	public List<Object[]> getReservationDataByDate(String date) {
		return reservationInFoRepository.getReservationDataByDate(date);
	}

	 public List<BookingTable> getBookingsByDateAndTableId(String date, Long tableId) {
	        return bookTableRepository.findByDateAndTableId(date, tableId);
	    }
	
	public List<BookingTable> search(BookingTable bookingTable) {
		List<BookingTable> searchList = bookTableRepository.search(bookingTable.getName(), bookingTable.getDate(),
				bookingTable.getStart_time(),bookingTable.getEnd_time(), bookingTable.getPhone_number(), bookingTable.getPerson_number());
		return searchList;
	}

	public List<BookingTable> getAll() {
		List<BookingTable> reservationList = bookTableRepository.findAll();
		return reservationList;
	}

	public List<Reservation> getAllApprove() {
		List<Reservation> reservationList = reservationRepository.findAll();
		return reservationList;
	}

	public BookingTable get(long id) {
		return bookTableRepository.findById(id).get();
	}

	public BookingTable getById(long id) {
		Optional<BookingTable> optional = bookTableRepository.findById(id);
		BookingTable reservation = null;
		if (optional.isPresent()) {
			reservation = optional.get();
		} else {
			throw new RuntimeException(" Reservation not found for id :: " + id);
		}
		return reservation;
	}

	public BookingTable save(BookingTable bookingTable) {
		System.out.println(bookingTable.getDate());
		// String formattedDate =
		// RemoveZeroUtil.removeLeadingZeros(bookingTable.getDate().replace("/", "-"));
		
		// bookingTable.setDate(formattedDate);
		bookingTable.setCreatedOn(LocalDateTime.now());
		return bookTableRepository.save(bookingTable);
	}


	public Reservation saveApprove(BookingTable bookingTable, TableM tableM) {
		// Date dateToString = DateUtils.parseStringToDate(dateS);
		Reservation reservation = new Reservation();

		reservation.setName(bookingTable.getName());
		reservation.setEmail(bookingTable.getEmail());
		reservation.setPhoneNumber(bookingTable.getPhone_number());
		reservation.setDate(bookingTable.getDate());
		reservation.setStart_time(bookingTable.getStart_time());
		reservation.setEnd_time(bookingTable.getEnd_time());
		reservation.setPerson_number(bookingTable.getPerson_number());
		reservation.setTableM(tableM);
		reservation.setCreatedOn(LocalDateTime.now());
		return reservationRepository.save(reservation);

	}

}
