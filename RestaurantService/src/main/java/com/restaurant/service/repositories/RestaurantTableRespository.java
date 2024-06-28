package com.restaurant.service.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.entities.Role;

@Repository
public interface RestaurantTableRespository extends CrudRepository<RestaurantTable, Long> {
	 @Query("SELECT i FROM RestaurantTable i JOIN FETCH i.category")
	    List<RestaurantTable> findAllWithCategoryAndUnit();
	 
	  Optional<RestaurantTable> findByTableNumber(String tableNumber);
	  boolean existsByTableNumber(String tableNumber);
	  List<RestaurantTable> findByStatus(boolean status);

	    @Query("SELECT rt FROM RestaurantTable rt JOIN rt.category c WHERE c.categoryName = :categoryName")
	    List<RestaurantTable> findByCategoryName(String categoryName);
	    
	    //Phuoc

		@Query("SELECT t FROM RestaurantTable t " +
			       "WHERE t.seatCount = :person_number " +
			       "AND t.online = 1 " +
			       "AND NOT EXISTS (" +
			       "   SELECT 1 FROM BookingTable b " +
			       "   WHERE b.date = :date " +
			       "   AND (b.start_time BETWEEN :start_time AND :end_time OR b.end_time BETWEEN :start_time AND :end_time) " +
			       "   AND b.tableId = t.id)")
			List<RestaurantTable> listTableByPerson(@Param("person_number") Integer person_number,
			                                        @Param("date") String date,
			                                        @Param("start_time") String start_time,
			                                        @Param("end_time") String end_time);


	    //endP
	  
}

