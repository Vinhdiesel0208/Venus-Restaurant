package com.restaurant.service.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Post;
import com.restaurant.service.entities.User;
import com.restaurant.service.exceptions.PostNotFoundException;
import com.restaurant.service.exceptions.UserNotFoundException;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.repositories.PostRepository;
import com.restaurant.service.repositories.SearchRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class PostService {

	@Autowired
	private PostRepository postRepository;
	
	
	public Page<Post> listPostByPage(int pageNum, int pageSize, PagingAndSortingHelper helper) {
	    Pageable pageable = helper.createPageable(pageSize, pageNum);
	    return postRepository.findAll(helper.getSearchText(), pageable);
	}

	public void listIngByPage(int pageNum, int pageCount, PagingAndSortingHelper helper) {
		helper.listEntities(pageNum, pageCount, postRepository);
	}

	public Post registerContact(Post post) {
		return postRepository.save(post);
	}
	

    public Page<Post> findPaginated(Pageable pageable) {
    	List<Post> posts = postRepository.findAll();
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;
        List<Post> list;

        if (posts.size() < startItem) {
            list = Collections.emptyList();
        } else {
            int toIndex = Math.min(startItem + pageSize, posts.size());
            list = posts.subList(startItem, toIndex);
        }

        Page<Post> postPage
          = new PageImpl<Post>(list, PageRequest.of(currentPage, pageSize), posts.size());

        return postPage;
    }
    
    public Post save(Post post) {
    	return postRepository.save(post);
	}
    
    public void delete(Long id) throws PostNotFoundException {
		Long countById = postRepository.countById(id);
		if (countById == null || countById == 0) {
			throw new PostNotFoundException("Could not find any post with ID " + id);
		}
		
		postRepository.deleteById(id);
	}
    // Thêm phương thức để tìm kiếm bài đăng theo ID
    public Post findById(long id) throws PostNotFoundException {
        Optional<Post> postOptional = postRepository.findById(id);
        if (postOptional.isPresent()) {
            return postOptional.get();
        } else {
            throw new PostNotFoundException("Post not found with id: " + id);
        }
    }


    // Thêm phương thức để cập nhật bài đăng
    public Post update(Post updatedPost) throws PostNotFoundException {
        long id = updatedPost.getId();
        Post existingPost = findById(id); // Kiểm tra xem bài đăng có tồn tại không
        // Cập nhật thông tin của bài đăng
        existingPost.setTitle(updatedPost.getTitle());
        existingPost.setImage(updatedPost.getImage());
        existingPost.setContent(updatedPost.getContent());
        existingPost.setCreated_actor(updatedPost.getCreated_actor());
        existingPost.setCreate_at(updatedPost.getCreate_at());
        existingPost.setUser_seen(updatedPost.getUser_seen());
        return postRepository.save(existingPost); // Lưu bài đăng đã được cập nhật vào cơ sở dữ liệu
    }
    public Page<Post> findAllByOrderByCreateAtDesc(Pageable pageable) {
        List<Post> allPosts = postRepository.findAll();
        Collections.sort(allPosts, (post1, post2) -> post2.getCreate_at().compareTo(post1.getCreate_at())); // Sort by create_at descending

        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;
        List<Post> sortedPage;

        if (allPosts.size() < startItem) {
            sortedPage = Collections.emptyList();
        } else {
            int toIndex = Math.min(startItem + pageSize, allPosts.size());
            sortedPage = allPosts.subList(startItem, toIndex);
        }

        return new PageImpl<Post>(sortedPage, PageRequest.of(currentPage, pageSize), allPosts.size());
    }
    public List<Post> findAll() {
        return postRepository.findAll();
    }
    
    public Page<Post> searchByKeyword(String keyword, Pageable pageable) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Sử dụng phương thức tìm kiếm đã cập nhật trong PostRepository để tìm kiếm cả trong title và content
            return postRepository.findByTitleContainingOrContentContaining(keyword, keyword, pageable);
        } else {
            // Nếu không có từ khóa, trả về tất cả bài viết
            return new PageImpl<>(findAll(), pageable, findAll().size());
        }
    }
//an bai viet archive
    public void archivePost(Long id) {
        postRepository.updateArchivedStatus(true, id); // Set archived to true
    }
    public void unarchivePost(Long id) {
        postRepository.updateArchivedStatus(false, id); // Set archived to false
    }
    public Page<Post> getNotArchivedPosts(Pageable pageable) {
        return postRepository.findByArchivedFalse(pageable);
    }
    public List<Post> findByArchivedFalse() {
        return postRepository.findByArchivedFalse();
    }
    public Page<Post> findUnarchivedPosts(Pageable pageable) {
        return postRepository.findByArchivedFalse(pageable);
    }
    public Page<Post> findUnarchivedPostsSorted(Pageable pageable) {
        return postRepository.findUnarchivedPostsSortedByCreateDate(pageable);
    }





}
