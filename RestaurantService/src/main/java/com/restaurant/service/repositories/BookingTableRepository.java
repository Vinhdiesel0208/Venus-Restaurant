package com.restaurant.service.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.BookingTable;

@Repository
public interface BookingTableRepository extends JpaRepository<BookingTable, Long> {

	@Query("SELECT b FROM BookingTable b WHERE " + "(:name IS NULL OR b.name LIKE %:name%) "
			+ "AND (:date IS NULL OR b.date LIKE %:date%) "
			+ "AND (:start_time IS NULL OR b.start_time LIKE %:start_time%) "
			+ "AND (:end_time IS NULL OR b.end_time LIKE %:end_time%) "
			+ "AND (:phone_number IS NULL OR b.phone_number LIKE %:phone_number%) "
			+ "AND (:person_number IS NULL OR b.person_number = %:person_number%)")
	List<BookingTable> search(@Param("name") String name, @Param("date") String date,
			@Param("start_time") String start_time,@Param("end_time") String end_time, @Param("phone_number") String phone_number,
			@Param("person_number") Integer person_number);

	@Query("SELECT b FROM BookingTable b WHERE " + "(b.date = :date) " + "AND (b.tableId = :tableId)")
	List<BookingTable> findByDateAndTableId(@Param("date") String date, @Param("tableId") Long tableId);
}