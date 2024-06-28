package com.restaurant.service.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.TableM;
import com.restaurant.service.repositories.TableMRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class TableMService {
	@Autowired
	private TableMRepository tableRepository;
	
	public TableM findByTableName(String tableName) {
	    return tableRepository.findByNameTable(tableName);
	}

	public void save(TableM tableM) {
		tableM.setCreatedOn(LocalDateTime.now());
		tableRepository.save(tableM);
	}

	public void update(TableM tableM) {
		System.out.println("TableM id" + tableM.getId());
		TableM table = tableRepository.findById(tableM.getId()).get();

		if (table != null) {
			table.setName_table(tableM.getName_table());
			table.setUpdatedOn(LocalDateTime.now());
			tableRepository.save(tableM);
		}
	}

	public List<TableM> listAll() {
		return (List<TableM>) tableRepository.findAll();
	}
	
	public List<TableM> listTableByPerson(Integer person_number, String date, String start_time,String end_time) {
		return (List<TableM>) tableRepository.listTableByPerson(person_number, date, start_time, end_time);
	}

	public TableM get(long id) {
		return tableRepository.findById(id).get();
	}

	public void delete(long id) {
		tableRepository.deleteById(id);
	}

//	public List<TableM> search(String searchText) {
//		return tableRepository.search(searchText);
//	}

}
