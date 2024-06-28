package com.restaurant.service.services;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Income;
import com.restaurant.service.entities.IncomeItem;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.repositories.IncomeRepository;

@Service
public class IncomeService {
	 @Autowired
	 private IncomeRepository incomeRepository;

	    public List<Income> getAllIncomes() {
	        return incomeRepository.findAll();
	    }

	    public void updateSoldQuantityForAllIncomeItems(Income income) {
	        for (IncomeItem incomeItem : income.getIncomeItems()) {
	            incomeItem.calculateSoldQuantity();
	        }
	    }
	    public void save(Income income) {
	    	incomeRepository.save(income);
	    }
	  
	    public Income findByDay(LocalDate day) {
	        return incomeRepository.findByDay(day);
	    }
	    public List<Income> findByDayBetween(LocalDateTime startOfDay, LocalDateTime endOfDay) {
	        return incomeRepository.findByDayBetween(startOfDay, endOfDay);
	    }
	 
	    public Page<Income> getAllIncomeByPage(Pageable pageable) {
	        return incomeRepository.findAll(pageable);
	    }	
	    public List<LocalDateTime> getDistinctDays() {
	        return incomeRepository.findDistinctDays();
	    }
//	    public Page<Income> getAllIncomesByDay(LocalDateTime day, Pageable pageable) {
//	        LocalDateTime startOfDay = day.withHour(0).withMinute(0).withSecond(0);
//	        LocalDateTime endOfDay = day.withHour(23).withMinute(59).withSecond(59);
//	        return incomeRepository.findByDayBetween(startOfDay, endOfDay, pageable);
//	    }
	    public Page<Income> getAllIncomes(Pageable pageable) {
	        return incomeRepository.findAll(pageable);
	    }

	    public Page<Income> getAllIncomesByDay(LocalDateTime day, Pageable pageable) {
	        return incomeRepository.findAllByDay(day, pageable);
	    }
	    public List<Income> getIncomesByDay(LocalDate day) {
	        LocalDateTime startOfDay = day.atStartOfDay();
	        LocalDateTime endOfDay = day.atTime(LocalTime.MAX);
	        return incomeRepository.findByDayBetween(startOfDay, endOfDay);
	    }

	    public List<Income> getIncomesByMonth(YearMonth month) {
	        LocalDateTime startOfMonth = month.atDay(1).atStartOfDay();
	        LocalDateTime endOfMonth = month.atEndOfMonth().atTime(LocalTime.MAX);
	        return incomeRepository.findByDayBetween(startOfMonth, endOfMonth);
	    }
	    public List<Income> getIncomesByDateRange(LocalDate startDate, LocalDate endDate) {
	        LocalDateTime startOfDay = startDate.atStartOfDay();
	        LocalDateTime endOfDay = endDate.atTime(LocalTime.MAX);
	        return incomeRepository.findByDayBetween(startOfDay, endOfDay);
	    }
	    
	    public List<Income> getIncomesByDate(LocalDate date) {
	        LocalDateTime startOfDay = date.atStartOfDay();
	        LocalDateTime endOfDay = date.atTime(LocalTime.MAX);
	        return incomeRepository.findByDayBetween(startOfDay, endOfDay);
	    }
	  
}
