package com.mytech.restaurantportal.apis;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.restaurant.service.dtos.PostDTO;
import com.restaurant.service.entities.Post;
import com.restaurant.service.exceptions.PostNotFoundException;
import com.restaurant.service.services.PostService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/apis/v1/posts")
@CrossOrigin(origins = "http://localhost:8083")
public class PostRestController {

	@Autowired
	private PostService postService;

	// Phương thức đã tồn tại để lấy bài viết theo ID
	@GetMapping("/{id}")
	public ResponseEntity<PostDTO> getPostById(@PathVariable("id") Long id) {
		try {
			Post post = postService.findById(id);
			PostDTO postDTO = PostDTO.fromEntity(post);
			postDTO.setImage(AppConstant.imageUrl + post.getImage());
			System.out.println("---------------" + postDTO.getImage());
			return new ResponseEntity<>(postDTO, HttpStatus.OK);
		} catch (PostNotFoundException e) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	// Phương thức mới để lấy tất cả bài viết
	@GetMapping
	public ResponseEntity<List<PostDTO>> getAllPosts() {
	    // Lấy ra danh sách các bài viết không bị archive
	    List<Post> posts = postService.findByArchivedFalse();
	    List<PostDTO> postDTOs = posts.stream().map(post -> {
	        PostDTO postDTO = PostDTO.fromEntity(post);
	        postDTO.setImage(AppConstant.imageUrl + post.getImage());
	        return postDTO;
	    }).collect(Collectors.toList());
	    return ResponseEntity.ok(postDTOs);
	}

	@GetMapping("/search")
	public ResponseEntity<List<PostDTO>> searchPosts(@RequestParam("keyword") String keyword, Pageable pageable) {
	    Page<Post> posts = postService.searchByKeyword(keyword, pageable);
	    List<PostDTO> postDTOs = posts.getContent().stream().map(post -> {
	        PostDTO postDTO = PostDTO.fromEntity(post);
	        postDTO.setImage(AppConstant.imageUrl + post.getImage());
	        return postDTO;
	    }).collect(Collectors.toList());
	    return ResponseEntity.ok(postDTOs);
	}
	
	// Đánh dấu bài viết là đã archive
	@PostMapping("/archive/{id}")
	public ResponseEntity<?> archivePost(@PathVariable Long id) {
	    postService.archivePost(id);
		return ResponseEntity.ok().body("Post with ID " + id + " has been archived successfully.");
	}

	// Đánh dấu bài viết là chưa archive (unarchive)
	@PostMapping("/unarchive/{id}")
	public ResponseEntity<?> unarchivePost(@PathVariable Long id) {
	    postService.unarchivePost(id);
		return ResponseEntity.ok().body("Post with ID " + id + " has been unarchived successfully.");
	}




}
