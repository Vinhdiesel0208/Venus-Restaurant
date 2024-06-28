package com.restaurant.service.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.TCategory;
import com.restaurant.service.repositories.TCategoryRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class TCategoryService {
	
	 @Autowired
		private TCategoryRepository tCategoryRepo;
		 
	 public List<TCategory> getAllCategory() {
	        return (List<TCategory>) tCategoryRepo.findAll();
	    }

		    public TCategory getCategoryById(Long id) {
		        return  tCategoryRepo.findById(id).orElse(null);
		    }

		    public TCategory createCategory(TCategory tCategory) {
		        return tCategoryRepo.save(tCategory);
		    }

		    public TCategory updateCategory(Long id, TCategory updatedcategory) {
		        TCategory existingCategory = tCategoryRepo.findById(id).orElse(null);

		        if (existingCategory != null) {
		        	existingCategory.setCategoryName(null);;
		        
		           
		            return tCategoryRepo.save(existingCategory);
		        }

		        return null;
		    }

		    public void deleteCategory(Long id) {
		    	tCategoryRepo.deleteById(id);
		    }
		 
}
