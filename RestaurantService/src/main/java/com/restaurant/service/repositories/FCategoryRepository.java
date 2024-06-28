package com.restaurant.service.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.FCategory;


@Repository
public interface FCategoryRepository  extends CrudRepository<FCategory, Long>  {

}
