package com.restaurant.service.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.restaurant.service.entities.Contact;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.entities.Post;
import com.restaurant.service.entities.User;
import com.restaurant.service.enums.AuthenticationType;



public interface PostRepository extends SearchRepository<Post, Long> {
//	@Query("SELECT u FROM Post u WHERE CONCAT(u.id, ' ', u.title, ' ', u.created_actor) LIKE %?1%")
//	public Page<Post> findAll(@Param("searchText")  String searchText, Pageable pageable);
	
	public Long countById(Long id);
	  // Tìm kiếm bài đăng theo ID và trả về Optional<Post>
    Optional<Post> findById(long id);

    // Cập nhật thông tin của bài đăng
    Post save(Post post);
 // Tìm kiếm bài viết theo từ khóa trong title và content
    Page<Post> findByTitleContainingOrContentContaining(String titleKeyword, String contentKeyword, Pageable pageable);
    //archive bai post
    @Modifying
    @Query("UPDATE Post p SET p.archived = :archived WHERE p.id = :id")
    void updateArchivedStatus(@Param("archived") boolean archived, @Param("id") Long id);
    Page<Post> findByArchivedFalse(Pageable pageable);
    List<Post> findByArchivedFalse();
    @Query("SELECT p FROM Post p WHERE p.archived = false ORDER BY p.create_at DESC")
    Page<Post> findUnarchivedPostsSortedByCreateDate(Pageable pageable);
    
    @Query("SELECT i FROM Post i WHERE LOWER(CONCAT(i.title, ' ')) LIKE %:searchText%")
    public Page<Post> findAll(@Param("searchText") String searchText, Pageable pageable);
 




}
