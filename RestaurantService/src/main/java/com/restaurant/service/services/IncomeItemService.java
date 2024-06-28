package com.restaurant.service.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.IncomeItem;
import com.restaurant.service.repositories.IncomeItemRepository;
@Service
public class IncomeItemService {
	@Autowired
	private IncomeItemRepository incomeItemRepository;

	public void save(IncomeItem incomeitem) {
		incomeItemRepository.save(incomeitem);
	}
}
