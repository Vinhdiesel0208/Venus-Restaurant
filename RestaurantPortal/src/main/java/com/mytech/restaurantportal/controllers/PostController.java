package com.mytech.restaurantportal.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.mytech.restaurantportal.helpers.AppHelper;
import com.mytech.restaurantportal.security.AppUserDetails;
import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.entities.Contact;
import com.restaurant.service.entities.FCategory;
import com.restaurant.service.entities.Post;
import com.restaurant.service.entities.User;
import com.restaurant.service.exceptions.PostNotFoundException;
import com.restaurant.service.exceptions.UserNotFoundException;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.paging.PagingAndSortingParam;
import com.restaurant.service.services.PostService;
import com.restaurant.service.services.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/posts")
public class PostController {

	private String defaultRedirectURL = "redirect:/posts/page/1?sortField=title&sortDir=asc";

	public static final String DATE_FORMAT_NOW = "dd-MM-yyyy HH:mm:ss";

	@Autowired
	private PostService postService;

	@Autowired
	private UserService userService;

	private final StorageService storageService;

	public PostController(StorageService storageService) {
		this.storageService = storageService;
	}

	public static String now() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
		return sdf.format(cal.getTime());
	}

	@GetMapping("")
	public String getPostList(Model model) {
		model.addAttribute("moduleURL", "/posts"); // Adjust according to your mapping
		return listIngByPage(model, 1, "title", "asc", "");
	}

	@GetMapping("/page")
	public String listByPage() {
		return "redirect:/posts/page/1";
	}

	@GetMapping("/page/{pageNum}")
	public String listIngByPage(Model model, @PathVariable(name = "pageNum") int pageNum,
			@RequestParam(name = "sortField", defaultValue = "title", required = false) String sortField,
			@RequestParam(name = "sortDir", defaultValue = "asc", required = false) String sortDir,
			@RequestParam(name = "searchText", defaultValue = "", required = false) String searchText) {

		// Ensure the sortField is a valid attribute of the entity
		String validSortField = validateSortField(sortField);
		PagingAndSortingHelper helper = new PagingAndSortingHelper(model, "listPosts", validSortField, sortDir,
				searchText);
		postService.listIngByPage(pageNum, 5, helper);

		model.addAttribute("currentPage", pageNum);
		model.addAttribute("sortField", validSortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("moduleURL", "/posts");
		model.addAttribute("searchText", searchText);

		return "/apps/posts/list";
	}

	private String validateSortField(String sortField) {
		// Replace this with the actual validation logic for your entity
		if ("title".equals(sortField)) {
			return sortField;
		}
		return "title"; // default sort field
	}

	@GetMapping("/add")
	public String add(@AuthenticationPrincipal AppUserDetails loggedUser, Model model) {
		try {
			User user = userService.get(loggedUser.getId());
			Post post = new Post();
			post.setImage("");
			post.setCreated_actor(user.getFirstName());
			model.addAttribute("post", post);
		} catch (UserNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "apps/posts/add";
	}

	@PostMapping("/addpost")
	public String savePost(@RequestParam("photo") MultipartFile file, Post post,
			RedirectAttributes redirectAttributes) {
		post.setCreate_at(now());
		post.setUser_seen(0);
		if (!file.isEmpty()) {
			String fileName = AppHelper.encode(post.getTitle());
			post.setImage(fileName);
			storageService.store(file, fileName);

			List<String> files = storageService.loadAll()
					.map(path -> MvcUriComponentsBuilder
							.fromMethodName(PortalController.class, "serveFile", path.getFileName().toString()).build()
							.toUri().toString())
					.collect(Collectors.toList());

			for (String filename : files) {
				System.out.println("Uploaded file: " + filename);
			}
		}

		postService.save(post);

		redirectAttributes.addFlashAttribute("message", "The post has been saved successfully.");

		return "redirect:/posts/add";
	}

	@PostMapping("/add")
	public String save(@Valid Post post, BindingResult bindingResult, Model model,
			RedirectAttributes redirectAttributes) {

		System.out.println("Post: ");
		if (bindingResult.hasErrors()) {
			return "/apps/posts/add";
		}
		postService.save(post);
		redirectAttributes.addFlashAttribute("message", "Successful!");

		model.addAttribute("contact", new Contact());
		return "redirect:/posts";
	}

	// Build Delete Todo REST API
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable("id") Long id) {
		try {
			postService.delete(id);
		} catch (PostNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "apps/posts/list";
	}

	@GetMapping("/edit/{id}")
	public String editPost(@PathVariable("id") long id, Model model) {
		try {
			Post post = postService.findById(id);
			model.addAttribute("post", post);
		} catch (PostNotFoundException e) {
			// Xử lý ngoại lệ khi không tìm thấy bài đăng
			e.printStackTrace();
		}
		return "apps/posts/edit";
	}

	@PostMapping("/edit/{id}")
	public String updatePost(@PathVariable("id") long id, @Valid Post updatedPost, BindingResult bindingResult,
			RedirectAttributes redirectAttributes, @RequestParam("photo") MultipartFile file) {
		if (bindingResult.hasErrors()) {
			return "apps/posts/edit";
		}

		try {
			Post existingPost = postService.findById(id);
			existingPost.setTitle(updatedPost.getTitle());
			existingPost.setContent(updatedPost.getContent());
			existingPost.setCreate_at(now()); // Cập nhật ngày chỉnh sửa
			existingPost.setUser_seen(updatedPost.getUser_seen());

			if (!file.isEmpty()) {
				String fileName = AppHelper.encode(existingPost.getTitle());
				existingPost.setImage(fileName);
				storageService.store(file, fileName);
			}

			postService.update(existingPost);
			redirectAttributes.addFlashAttribute("message", "The post has been updated successfully.");
		} catch (PostNotFoundException e) {
			e.printStackTrace();
		}

		return "redirect:/posts"; // Chuyển hướng đến trang danh sách bài đăng
	}

//an bai viết archive
	@PostMapping("/archive/{id}")
	@ResponseBody
	public ResponseEntity<?> archivePost(@PathVariable("id") Long id) {
		try {
			postService.archivePost(id);
			return ResponseEntity
					.ok(Map.of("message", "Post with ID " + id + " has been hidden successfully.", "success", true));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("message", "Failed to archive post.", "success", false));
		}
	}

	@PostMapping("/unarchive/{id}")
	@ResponseBody
	public ResponseEntity<?> unarchivePost(@PathVariable("id") Long id) {
		try {
			postService.unarchivePost(id);
			return ResponseEntity
					.ok(Map.of("message", "Post with ID " + id + " has been shown successfully.", "success", true));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("message", "Failed to unarchive post.", "success", false));
		}
	}

}