package com.restaurant.service.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.FCategory;

import com.restaurant.service.repositories.FCategoryRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class FCategoryService {
	
	 @Autowired
	 
	private FCategoryRepository fCategoryRepo;
	 
	  public List<FCategory> getAllCategory() {
	        return (List<FCategory>) fCategoryRepo.findAll();
	    }

	    public FCategory getCategoryById(Long id) {
	        return  fCategoryRepo.findById(id).orElse(null);
	    }

	    public FCategory createCategory(FCategory fCategory) {
	        return fCategoryRepo.save(fCategory);
	    }

	    public FCategory updateCategory(Long id, FCategory updatedcategory) {
	        FCategory existingCategory = fCategoryRepo.findById(id).orElse(null);

	        if (existingCategory != null) {
	        	existingCategory.setCategoryName(null);;
	        
	           
	            return fCategoryRepo.save(existingCategory);
	        }

	        return null;
	    }

	    public void deleteCategory(Long id) {
	    	fCategoryRepo.deleteById(id);
	    }
	 

}
