package com.restaurant.service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@NoRepositoryBean
//public interface SearchRepository<T, ID> extends PagingAndSortingRepository<T, ID> {
public interface SearchRepository<T, ID> extends JpaRepository<T, ID> {
	public Page<T> findAll(String searchText, Pageable pageable);
}