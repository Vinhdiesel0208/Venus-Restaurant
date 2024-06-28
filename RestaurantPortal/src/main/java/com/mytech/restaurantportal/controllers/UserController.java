package com.mytech.restaurantportal.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itextpdf.text.DocumentException;
import com.mytech.restaurantportal.exporters.UserCsvExporter;
import com.mytech.restaurantportal.exporters.UserExcelExporter;
import com.mytech.restaurantportal.exporters.UserPdfExporter;
import com.mytech.restaurantportal.helpers.AppConstant;
import com.mytech.restaurantportal.helpers.AppHelper;
import com.mytech.restaurantportal.mailer.EmailService;
import com.mytech.restaurantportal.storage.StorageService;
import com.restaurant.service.dtos.CustomerDTO;
import com.restaurant.service.dtos.IngredientDTO;
import com.restaurant.service.dtos.UserDTO;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.entities.Role;
import com.restaurant.service.entities.User;
import com.restaurant.service.enums.Gender;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.paging.PagingAndSortingParam;
import com.restaurant.service.services.CustomerService;
import com.restaurant.service.services.RoleService;
import com.restaurant.service.services.UserService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/users")
public class UserController {

	private String defaultRedirectURL = "redirect:/users/page/1?sortField=email&sortDir=asc";

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private CustomerService  customerService ;
	
	@Autowired
  public EmailService emailService;

	private final StorageService storageService;

	public UserController(StorageService storageService) {
		this.storageService = storageService;
	}

	@GetMapping("")
	public String getUserList(Model model) {
		List<User> listUsers = userService.getAllUsers();
		List<Role> listRoles = roleService.getAllRoles();

		model.addAttribute("listRoles", listRoles);
		model.addAttribute("listUsers", listUsers);
		model.addAttribute("currentPage", "1");
		model.addAttribute("sortField", "email");
		model.addAttribute("sortDir", "asc");
		model.addAttribute("reverseSortDir", "desc");
		model.addAttribute("searchText", "");
		model.addAttribute("moduleURL", "/users");

		return "/apps/users/list";
	}
	
	@GetMapping("/staff")
	public String getStaffList(Model model) {
		List<Customer> listStaff = customerService.findAllStaffCustomers();

		
		model.addAttribute("listStaff", listStaff);
		model.addAttribute("currentPage", "1");
		model.addAttribute("sortField", "email");
		model.addAttribute("sortDir", "asc");
		model.addAttribute("reverseSortDir", "desc");
		model.addAttribute("searchText", "");
		model.addAttribute("moduleURL", "/staff");

		return "/apps/users/staff";
	}
	
	@PostMapping("/addStaff")
	public String saveStaff(@RequestParam("avatar") MultipartFile file,
	                        @RequestParam("fullName") String fullName,
	                        @RequestParam("email") String email,
	                        @RequestParam("phoneNumber") String phoneNumber,
	                        @RequestParam("password") String password,
	                        @RequestParam("address") String address,
	                        @RequestParam("enabled") boolean enabled,
	                        @RequestParam("staff") boolean staff,
	                        @RequestParam("gender") String gender,
	                        RedirectAttributes redirectAttributes) {
	    
	    CustomerDTO customerDTO = new CustomerDTO(fullName, email, phoneNumber, password, null, address, enabled, staff, gender, null);

	    if (!file.isEmpty()) {
	        String fileName = AppHelper.encode(fullName); 
	        customerDTO.setPhoto(fileName);
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
	    
	    customerService.CreateStaff(customerDTO);

	    return "redirect:/users/staff";
	}


	
	

	@GetMapping("/page")
	public String listByPage() {
		return defaultRedirectURL;
	}

	@GetMapping("/page/{pageNum}")
	public String listByPage(
			@PagingAndSortingParam(listName = "listUsers", moduleURL = "/users", defaultSortField = "email") PagingAndSortingHelper helper,
			@PathVariable(name = "pageNum") int pageNum,
			@RequestParam(name = "sortField", defaultValue = "email", required = false) String sortField,
			@RequestParam(name = "sortDir", defaultValue = "asc", required = false) String sortDir) {

		System.out
				.println("UserControllerlistByPage::" + pageNum + " sortField: " + sortField + " sortDir: " + sortDir);
		userService.listUserByPage(pageNum, AppConstant.pageCount, helper);

		return "/apps/users/list";
	}

	@GetMapping("/add")
	public String add(Model model) {
		List<Role> listRoles = roleService.getAllRoles();
		User user = new User();

		model.addAttribute("user", user);
		model.addAttribute("listRoles", listRoles);

		return "/apps/users/add";
	}

	@PostMapping("/adduser")
	public String saveUser(@RequestParam("avatar") MultipartFile file, User user, RedirectAttributes redirectAttributes) {
		System.out.println("User save: " + user.getFirstName() + " -- " + user.getLastName() + " -- " + user.getEmail()
				+ " -- " + user.isEnabled());
		
		User findUser = userService.getByEmail(user.getEmail());
		
		if (findUser != null) {
			redirectAttributes.addFlashAttribute("errorMessage", "The user with this email already registered.");
			return "redirect:/users/add";
		}
		
		for (Role role : user.getRoles()) {
			System.out.println("User save: " + role.getName() );
		}

		if (!file.isEmpty()) {
			String fileName = AppHelper.encode(user.getEmail());
			user.setPhoto(fileName);
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

		userService.save(user);
		
//		emailService.sendSimpleMessage("info.cgodev@gmail.com", "User added", "Your password is: 123");
		try {
			Map<String, Object> templateModel = new HashMap<>();
	        templateModel.put("recipientName", user.getFullName());
	        templateModel.put("text", "Your password is: 123. You need to change password first");
	        templateModel.put("senderName", "noreply@thebags.com");
			emailService.sendMessageUsingThymeleafTemplate("vinhdiesel92025@gmail.com", "User info", templateModel);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		redirectAttributes.addFlashAttribute("message", "The user has been saved successfully.");

		return "redirect:/users/add";
	}

	@PostMapping("/add")
	public String save(@RequestParam(name = "email") String email, @RequestParam(name = "firstname") String firstname,
			@RequestParam(name = "lastname") String lastname,
			@RequestParam(name = "enabled", defaultValue = "0") boolean enabled) {
		System.out.println("User save: " + firstname + " -- " + lastname + " -- " + email + " -- " + enabled);

		userService.save(new UserDTO(email, firstname, lastname, enabled));

		return "redirect:/users";
	}

	@PostMapping("/export")
	public void export(HttpServletResponse response, @RequestParam(name = "format") String format,
			@RequestParam(name = "date") String date) throws IOException, DocumentException {
		System.out.println("User export: " + format);
		System.out.println("User export: " + date);

		List<User> listUsers = userService.getAllUsers();

		if ("excel".endsWith(format)) {
			UserExcelExporter exporter = new UserExcelExporter();
			exporter.export(listUsers, response);
		} else if ("csv".equals(format)) {
			UserCsvExporter exporter = new UserCsvExporter();
			exporter.export(listUsers, response);
		} else {
			UserPdfExporter exporter = new UserPdfExporter();
			exporter.export(listUsers, response);
		}
	}

	// Files exporting
	@GetMapping("/export/csv")
	public void exportToCSV(HttpServletResponse response) throws IOException {
		List<User> listUsers = userService.getAllUsers();
		UserCsvExporter exporter = new UserCsvExporter();
		exporter.export(listUsers, response);
	}

	@GetMapping("/export/excel")
	public void exportToExcel(HttpServletResponse response) throws IOException {
		List<User> listUsers = userService.getAllUsers();

		UserExcelExporter exporter = new UserExcelExporter();
		exporter.export(listUsers, response);
	}

	@GetMapping("/export/pdf")
	public void exportToPDF(HttpServletResponse response) throws IOException, DocumentException {
		List<User> listUsers = userService.getAllUsers();

		UserPdfExporter exporter = new UserPdfExporter();
		exporter.export(listUsers, response);
	}
}