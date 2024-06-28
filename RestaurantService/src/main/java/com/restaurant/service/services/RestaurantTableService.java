package com.restaurant.service.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.entities.TableM;
import com.restaurant.service.repositories.RestaurantTableRespository;
import com.restaurant.service.repositories.TCategoryRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class RestaurantTableService {
	@Autowired
	private RestaurantTableRespository tableres;

	@Autowired
	private TCategoryRepository tcategoryRepo;

	public List<RestaurantTable> listTableByPerson(Integer person_number, String date, String start_time,
			String end_time) {

		return (List<RestaurantTable>) tableres.listTableByPerson(person_number, date, start_time, end_time);
	}

	public List<RestaurantTable> getAllRestaurantTables() {
		return (List<RestaurantTable>) tableres.findAll();
	}

	public List<RestaurantTable> getAllIngredientWithCategoryAndUnit() {
		return tableres.findAllWithCategoryAndUnit();
	}

	public boolean getTableStatusById(Long tableId) {
		RestaurantTable table = tableres.findById(tableId).orElse(null);
		if (table != null) {
			return table.isStatus();
		} else {
			return false;
		}
	}

	public boolean isTableNumberExists(String tableNumber) {
		return tableres.existsByTableNumber(tableNumber);
	}

	public RestaurantTable getRestaurantTableById(Long id) {
		return tableres.findById(id).orElse(null);
	}

	public RestaurantTable createTable(RestaurantTable restaurantTable) {
		restaurantTable.setStatus(true);
		return tableres.save(restaurantTable);
	}

	public Long getTableIdById(Long tableId) {

		Optional<RestaurantTable> tableOptional = tableres.findById(tableId);

		return tableOptional.map(RestaurantTable::getId).orElse(null);
	}

	public String getTableNameById(Long id) {
		Optional<RestaurantTable> tableOptional = tableres.findById(id);
		return tableOptional.map(RestaurantTable::getTableNumber).orElse(null);
	}

	public Long getTableIdByTableName(String tableName) {
		Optional<RestaurantTable> tableOptional = tableres.findByTableNumber(tableName);
		return tableOptional.map(RestaurantTable::getId).orElse(null);
	}

	@Transactional
	public void checkinTable(Long tableId) {
		RestaurantTable table = tableres.findById(tableId).orElse(null);
		if (table != null) {
			table.setStatus(false);
			tableres.save(table);
		}
	}

	@Transactional
	public void checkoutTable(Long tableId) {
		RestaurantTable table = tableres.findById(tableId).orElse(null);
		if (table != null) {
			table.setStatus(true);
			tableres.save(table);
		}
	}

	public RestaurantTable updateRestaurantTable(Long id, RestaurantTable updatedRestaurantTable) {
		RestaurantTable existingRestaurantTable = tableres.findById(id).orElse(null);

		if (existingRestaurantTable != null) {
			existingRestaurantTable.setSeatCount(updatedRestaurantTable.getSeatCount());
			existingRestaurantTable.setTableNumber(updatedRestaurantTable.getTableNumber());
			existingRestaurantTable.setOnline(updatedRestaurantTable.getOnline());
			existingRestaurantTable.setPrice(updatedRestaurantTable.getPrice());
			return tableres.save(existingRestaurantTable);
		}

		return null;
	}

	public void deleteRestaurantTable(Long id) {
		tableres.deleteById(id);
	}

}
