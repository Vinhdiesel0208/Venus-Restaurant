package com.restaurant.service.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.TableM;

@Repository
public interface TableMRepository extends JpaRepository<TableM, Long> {
	@Query("SELECT t FROM TableM t WHERE t.name_table = :nameTable")
	TableM findByNameTable(@Param("nameTable")String nameTable);

//	 @Query("SELECT t FROM TableM t WHERE t.capacity = :person_number AND NOT EXISTS ("
//	            + " SELECT 1 FROM Reservation r JOIN BookingTable b ON DATE(r.date) = DATE(b.date) AND r.time = b.time "
//	            + " WHERE r.tableM.id = t.id)")
	@Query("SELECT t FROM TableM t " +
		       "WHERE t.capacity = :person_number " +
		       "AND NOT EXISTS (SELECT 1 FROM Reservation r " +
		       "WHERE r.date = :date " +
		       "AND (r.start_time BETWEEN :start_time AND :end_time " +
		       "OR r.end_time BETWEEN :start_time AND :end_time) " +
		       "AND r.tableM.id = t.id)")
		public List<TableM> listTableByPerson(
		    @Param("person_number") Integer person_number,
		    @Param("date") String date,
		    @Param("start_time") String start_time,
		    @Param("end_time") String end_time);
}
	