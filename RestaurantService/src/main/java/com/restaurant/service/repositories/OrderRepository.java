package com.restaurant.service.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.Order;

@Repository
public interface OrderRepository extends  SearchRepository<Order, Long> {
	Order findByEmail(String email);
	 
	 @Query("SELECT o FROM Order o JOIN FETCH o.orderItems")
	    List<Order> findAllWithItems();
	 
	 @Query("SELECT o FROM Order o WHERE CONCAT(o.id, ' ', o.email, ' ', o.fullName, ' ', o.restaurantTable.tableNumber) LIKE %?1%")
	 public Page<Order> findAll(String searchText, Pageable pageable);

	 

}
