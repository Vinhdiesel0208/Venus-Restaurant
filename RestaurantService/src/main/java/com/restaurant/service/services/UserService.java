package com.restaurant.service.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.restaurant.service.dtos.UserDTO;
import com.restaurant.service.entities.Role;
import com.restaurant.service.exceptions.UserNotFoundException;
import com.restaurant.service.helpers.AppConstant;
import com.restaurant.service.mappers.UserMapper;
import com.restaurant.service.paging.PagingAndSortingHelper;
import com.restaurant.service.entities.User;
import com.restaurant.service.repositories.RoleRepository;
import com.restaurant.service.repositories.UserRepository;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.NoSuchElementException;

import jakarta.transaction.Transactional;
import net.bytebuddy.utility.RandomString;

@Service
@Transactional
public class UserService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private RoleRepository roleRepo;
	
	@Autowired
	private UserMapper userMapper;

	public void listUserByPage(int pageNum, int pageCount, PagingAndSortingHelper helper) {
		helper.listEntities(pageNum, pageCount, userRepo);
	}
	
	public List<User> getAllChef() {
		List<User> user = userRepo.findAllChefs();
		
		
		
		return user;
	}
	
	public List<User> getAllUsers() {
		User user = userRepo.findById(10L).get();
		
		UserDTO userDTO = UserMapper.MAPPER.userToUserDTO(user);
		
		System.out.println(user.toString());
		System.out.println(userDTO.toString());
		
		return (List<User>) userRepo.findAll(Sort.by("firstName").ascending());
	}
	
	public List<User> getUserPage(int pageNum) {
		Pageable pageable = PageRequest.of(pageNum, AppConstant.pageSize);
		return userRepo.findAll(pageable).getContent();
	}
	
	public List<Role> listRoles() {
		return (List<Role>) roleRepo.findAll();
	}
	
	public User getByEmail(String email) {
		return userRepo.getUserByEmail(email);
	}
	
	public User save(UserDTO userDTO) {
		userDTO.setPassword("123");
		User user = userMapper.userDTOToUser(userDTO);
		return save(user);
	}

	public User save(User user) {
		boolean isUpdatingUser = (user.getId() != null);
		
		if (isUpdatingUser) {
			User existingUser = userRepo.findById(user.getId()).get();
			
			if (!user.getPassword().isEmpty()) {
				existingUser.setPassword(user.getPassword());
				encodePassword(existingUser);
			}
			return userRepo.save(existingUser);
			
		} else {		
			encodePassword(user);
		}
		System.out.println("User save: " + user.getFirstName() + " -- " + user.getLastName() + " -- " + user.getEmail() + " -- " + user.isEnabled());
		return userRepo.save(user);
	}
	
	public User updateAccount(User userDto) {
		User userInDB = userRepo.findById(userDto.getId()).get();
		
		if (!userDto.getPassword().isEmpty()) {
			userInDB.setPassword(userDto.getPassword());
			encodePassword(userInDB);
		}
		
		if (userDto.getPhoto() != null) {
			userInDB.setPhoto(userDto.getPhoto());
		}
		
		userInDB.setFirstName(userDto.getFirstName());
		userInDB.setLastName(userDto.getLastName());
		
		return userRepo.save(userInDB);
	}
	
	private void encodePassword(User user) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
	}
	
	public boolean isEmailUnique(Long id, String email) {
		User userByEmail = userRepo.getUserByEmail(email);
		
		if (userByEmail == null) return true;
		
		boolean isCreatingNew = (id == null);
		
		if (isCreatingNew) {
			if (userByEmail != null) return false;
		} else {
			if (userByEmail.getId() != id) {
				return false;
			}
		}
		
		return true;
	}
	
	public boolean isEmailExisted(String email) {
		User userByEmail = userRepo.getUserByEmail(email);
		
		if (userByEmail == null) return false;
		
		return true;
	}

	public User get(Long id) throws UserNotFoundException {
		try {
			return userRepo.findById(id).get();
		} catch (NoSuchElementException ex) {
			throw new UserNotFoundException("Could not find any user with ID " + id);
		}
	}
	
	public void delete(Long id) throws UserNotFoundException {
		Long countById = userRepo.countById(id);
		if (countById == null || countById == 0) {
			throw new UserNotFoundException("Could not find any user with ID " + id);
		}
		
		userRepo.deleteById(id);
	}
	
	public void updateUserEnabledStatus(Long id, boolean enabled) {
		userRepo.updateEnabledStatus(id, enabled);
	}
	
	public long getCount() {
		return userRepo.count();
	}

	public String updateResetPasswordToken(String email) throws UserNotFoundException {
		User user = userRepo.getUserByEmail(email);
		if (userRepo != null) {
			Date date = new Date();
			Calendar calendar = Calendar.getInstance(); 
			calendar.setTime(date); 
			calendar.add(Calendar.DATE, 1);
			date = calendar.getTime();
			
			//Encode token with 32 chars String and expired time;
			String expiredEncoded = Base64.getEncoder().encodeToString((date.getTime() + "").getBytes());
			String token = RandomString.make(32) + expiredEncoded;
			
			System.out.println("ResetPasswordToken: " + expiredEncoded);
			System.out.println("ResetPasswordToken: " + token);
			
			user.setResetPasswordToken(token);
			userRepo.save(user);
			
			return token;
		} else {
			throw new UserNotFoundException("Could not find any customer with the email " + email);
		}
	}

	public User getByResetPasswordToken(String token) {
		String expired = token.substring(32, token.length());
		System.out.println("--ResetExpiredToken: " + expired);
		
		byte[] decoded = Base64.getDecoder().decode(expired);
		String decodeExpired = new String(decoded, StandardCharsets.UTF_8);
		
		System.out.println("--ResetExpiredToken: " + decodeExpired);
		
		Long expiredTime = Long.parseLong(decodeExpired);
		Date curDate = new Date();
		
		if (curDate.getTime() < expiredTime) {
			return userRepo.findByResetPasswordToken(token);
		}
		
		return null;
	}

	public void updatePassword(String token, String password) {
		
		User user = userRepo.findByResetPasswordToken(token);
		user.setPassword(password);
		user.setResetPasswordToken(null);
		encodePassword(user);
		userRepo.save(user);
		
	}

	public void updatePassword(long id, String password) {
		User user = userRepo.findById(id).get();
		user.setPassword(password);
		user.setChangePassword(false);
		encodePassword(user);
		userRepo.save(user);
	}
}