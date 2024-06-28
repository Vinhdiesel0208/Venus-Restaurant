package com.restaurant.service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.IncomeItem;

@Repository
public interface IncomeItemRepository extends JpaRepository<IncomeItem, Long> {

}
