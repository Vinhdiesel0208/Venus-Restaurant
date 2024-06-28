package com.restaurant.service.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.Reservation;
@Repository
public interface ReservationInFoRepository extends JpaRepository<Reservation, Long> {
	@Query(value = "SELECT t.name_table AS table_name, "
			+ "MAX(CASE WHEN r.time = '9:00' THEN r.name ELSE '' END) AS h9, "
			+ "MAX(CASE WHEN r.time = '10:00' THEN r.name ELSE '' END) AS h10, "
			+ "MAX(CASE WHEN r.time = '11:00' THEN r.name ELSE '' END) AS h11, "
			+ "MAX(CASE WHEN r.time = '12:00' THEN r.name ELSE '' END) AS h12, "
			+ "MAX(CASE WHEN r.time = '13:00' THEN r.name ELSE '' END) AS h13, "
			+ "MAX(CASE WHEN r.time = '14:00' THEN r.name ELSE '' END) AS h14, "
			+ "MAX(CASE WHEN r.time = '15:00' THEN r.name ELSE '' END) AS h15, "
			+ "MAX(CASE WHEN r.time = '16:00' THEN r.name ELSE '' END) AS h16, "
			+ "MAX(CASE WHEN r.time = '17:00' THEN r.name ELSE '' END) AS h17, "
			+ "MAX(CASE WHEN r.time = '18:00' THEN r.name ELSE '' END) AS h18, "
			+ "MAX(CASE WHEN r.time = '19:00' THEN r.name ELSE '' END) AS h19, "
			+ "MAX(CASE WHEN r.time = '20:00' THEN r.name ELSE '' END) AS h20, "
			+ "MAX(CASE WHEN r.time = '21:00' THEN r.name ELSE '' END) AS h21 "
			+ "FROM tables t "
			+ "LEFT JOIN reservation r ON r.table_id = t.id AND r.date = :date " 
			+ "GROUP BY t.name_table "
			+ "ORDER BY t.name_table", nativeQuery = true)
List<Object[]> getReservationDataByDate(@Param("date") String date);

}