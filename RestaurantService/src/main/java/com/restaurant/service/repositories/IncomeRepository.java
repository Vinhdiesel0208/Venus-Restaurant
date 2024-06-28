package com.restaurant.service.repositories;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.Income;

@Repository
public interface IncomeRepository extends JpaRepository<Income, Long> {
	List<Income> findAll();

	Income findByDay(LocalDate day);

	// List<Income> findByDayBetween(LocalDateTime startOfDay, LocalDateTime
	// endOfDay);

	Page<Income> findAll(Pageable pageable);

	@Query("SELECT DISTINCT i.day FROM Income i")
	List<LocalDateTime> findDistinctDays();

	Page<Income> findByDayBetween(LocalDateTime startOfDay, LocalDateTime endOfDay, Pageable pageable);

	@Query("SELECT i FROM Income i WHERE i.day = :day")
	Page<Income> findAllByDay(@Param("day") LocalDateTime day, Pageable pageable);

	@Query("SELECT i FROM Income i WHERE i.day BETWEEN :startDate AND :endDate")
	List<Income> findByDayBetween(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
}
