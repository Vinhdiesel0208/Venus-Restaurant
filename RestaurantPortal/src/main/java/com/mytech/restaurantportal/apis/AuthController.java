package com.mytech.restaurantportal.apis;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mytech.restaurantportal.dtos.JwtResponse;
import com.mytech.restaurantportal.dtos.LoginDTO;
import com.mytech.restaurantportal.dtos.MessageResponse;
import com.mytech.restaurantportal.security.AppUserDetails;
import com.mytech.restaurantportal.security.jwt.JwtUtils;
import com.restaurant.service.dtos.UserDTO;
import com.restaurant.service.entities.User;
import com.restaurant.service.mappers.UserMapper;
import com.restaurant.service.services.RoleService;
import com.restaurant.service.services.UserService;

import jakarta.validation.Valid;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/apis/v1")
public class AuthController {
	@Autowired
	AuthenticationManager authenticationManager;

	@Autowired
	UserService userService;

	@Autowired
	RoleService roleService;

	@Autowired
	PasswordEncoder encoder;

	@Autowired
	JwtUtils jwtUtils;

	@PostMapping("/signin")
	public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginDTO loginRequest) {
	    Authentication authentication = authenticationManager.authenticate(
	            new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));

	    SecurityContextHolder.getContext().setAuthentication(authentication);
	    String jwt = jwtUtils.generateJwtToken(authentication);

	    AppUserDetails userDetails = (AppUserDetails) authentication.getPrincipal();
	    List<String> roles = userDetails.getAuthorities().stream().map(item -> item.getAuthority())
	            .collect(Collectors.toList());

	    // In log để kiểm tra token và thông tin người dùng
	    System.out.println("Generated JWT: " + jwt);
	    System.out.println("User Details: " + userDetails);

	    return ResponseEntity.ok(
	            new JwtResponse("success", jwt, userDetails.getId(), userDetails.getFullname(), userDetails.getEmail(), roles));
	}



	@PostMapping("/signup")
//	@RolesAllowed({"ROLE_ADMIN"})
//	@Secured({"ROLE_ADMIN"})
	@PreAuthorize("hasAuthority('ADMIN')")
	public ResponseEntity<?> registerUser(@Valid @RequestBody UserDTO userDTO) {

		System.out.println("apis::registerUser::" + userDTO.getEmail());
		
		if (userService.isEmailExisted(userDTO.getEmail())) {
			return ResponseEntity.badRequest().body(new MessageResponse("Error: Email is already in use!"));
		}

		// Create new user's account
		User user = UserMapper.MAPPER.userDTOToUser(userDTO);
		userService.save(user);

		return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
	}
}
