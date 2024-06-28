package com.restaurant.service.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.Ingredient;

import jakarta.transaction.Transactional;


@Repository
public interface IngredientRepository extends SearchRepository<Ingredient, Long> {

    @Query("SELECT i FROM Ingredient i WHERE i.ingredientCode = :ingredientCode")
    public Ingredient getIngredientByCode(@Param("ingredientCode") String ingredientCode);

    @Query("SELECT i FROM Ingredient i WHERE LOWER(CONCAT(i.ingredientName, ' ', i.ingredientCode)) LIKE %:searchText%")
    public Page<Ingredient> findAll(@Param("searchText") String searchText, Pageable pageable);

    @Query("SELECT i FROM Ingredient i JOIN FETCH i.category WHERE i.status = 'Available'or i.status ='OutofStock'")
    List<Ingredient> findAllWithCategoryAndUnit();
    
    @Query("UPDATE Ingredient u SET u.halfPortionAvailable = ?2 WHERE u.id = ?1")
	@Modifying
	public void updatehalfPortionAvailableStatus(Long id, boolean halfPortionAvailable);
    
    @Transactional
	@Modifying
	@Query("UPDATE Ingredient i SET i.ingredientName = :ingredientName, " +
			"i.price = :price WHERE i.id = :id")
	void updateIngredient(@Param("ingredientName") String ingredientName, @Param("price") BigDecimal price, @Param("id") Long id);

    
    //tien
    @Query(value = "SELECT c FROM Ingredient c WHERE c.ingredientName LIKE '%' || :searchText || '%'")
	public List<Ingredient> search(@Param("searchText") String searchText);
    
    
    public Long countById(Long id);
    Page<Ingredient> findByIngredientNameContainingIgnoreCase(String ingredientName, Pageable pageable);
    
    
  //vinh
    @Query("SELECT i FROM Ingredient i WHERE i.category.id = :categoryId AND LOWER(i.ingredientName) LIKE %:keyword%")
    List<Ingredient> findByCategoryAndNameLike(@Param("categoryId") Long categoryId, @Param("keyword") String keyword);

    @Query("SELECT i FROM Ingredient i WHERE LOWER(i.ingredientName) LIKE %:keyword%")
    List<Ingredient> findByNameLike(@Param("keyword") String keyword);

    @Query("SELECT i FROM Ingredient i WHERE i.category.id = :categoryId")
    List<Ingredient> findByCategory(@Param("categoryId") Long categoryId);

    List<Ingredient> findByIngredientNameContainingIgnoreCase(String keyword);

}
