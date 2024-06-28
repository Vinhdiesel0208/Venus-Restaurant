package com.restaurant.service.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


import com.restaurant.service.entities.TCategory;
@Repository
public interface TCategoryRepository extends CrudRepository<TCategory, Long> {

}
