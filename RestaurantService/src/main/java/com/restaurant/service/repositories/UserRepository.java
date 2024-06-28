package com.restaurant.service.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.User;


@Repository
public interface UserRepository extends SearchRepository<User, Long> {
	@Query("SELECT u FROM User u WHERE u.email = :email")
	public User getUserByEmail(@Param("email") String email);
	
	@Query("SELECT u FROM User u WHERE CONCAT(u.id, ' ', u.email, ' ', u.firstName, ' ', u.lastName) LIKE %?1%")
	public Page<User> findAll(@Param("searchText")  String searchText, Pageable pageable);
	
	@Query("UPDATE User u SET u.enabled = ?2 WHERE u.id = ?1")
	@Modifying
	public void updateEnabledStatus(Long id, boolean enabled);
	
	public Long countById(Long id);
	public User findByEmail(String email);
	public User findByResetPasswordToken(String email);
	@Query("SELECT u FROM User u JOIN u.roles r WHERE r.name = 'CHEF'")
    List<User> findAllChefs();
}