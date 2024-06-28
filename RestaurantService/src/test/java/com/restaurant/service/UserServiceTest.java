package com.restaurant.service;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;

import com.restaurant.service.entities.Role;
import com.restaurant.service.entities.User;
import com.restaurant.service.services.UserService;


@DataJpaTest(showSql = true)
@Rollback(false)
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class UserServiceTest {
	
	@Autowired
	private TestEntityManager entityManager;
	
	@Autowired
	private UserService userService;
	
	  @Test
	    void createNewUserWithoutRole() {
			User userAdmin2 = new User("admin2@abc.com", "123", "Admin 2", "Portal");

			User savedUser = userService.save(userAdmin2);

			if (savedUser != null) {
				System.out.println("Saved: " + savedUser.getId());
			} else {
				System.out.println("Saved failed. Can not create user!");
			}

			assertThat(savedUser).isNotNull();
		}
	  
	  @Test
	  void createNewUserWithRoleAdmin() {
	     
	      Role roleAdmin = new Role();
	      roleAdmin.setName("ADMIN");
	      roleAdmin.setDescription("ADMIN");
	      
	      
	      entityManager.persist(roleAdmin);
	      
	     
	      User userAdmin2 = new User("admin2@abc.com", "123", "Admin 2", "Portal");

	     
	      userAdmin2.getRoles().add(roleAdmin);

	      
	      userService.save(userAdmin2);

	     
	      assertThat(userAdmin2.getRoles()).contains(roleAdmin);
	  }




	    @Test
	    void createNewUserWithOneRole() {
			Role roleAdmin = entityManager.find(Role.class, 1);
			
			User userAdmin3 = new User("admin3@abc.com", "123", "Admin 3", "Portal");

			userAdmin3.getRoles().add(roleAdmin);
			
			User savedUser = userService.save(userAdmin3);

			if (savedUser != null) {
				System.out.println("Saved: " + savedUser.getId());
			} else {
				System.out.println("Saved failed. Can not create user!");
			}

			assertThat(savedUser).isNotNull();
		}

	    @Test
	    void create100NewUsers() {
			for (int i = 11; i <= 10; i++ ) {
				User userAdmin = new User("admin" + i + "@ymail.com", "123", "Admin " + i, "Portal");
				userService.save(userAdmin);
			}
			
			long countUsers = userService.getCount();
			
			assertThat(countUsers).isGreaterThan(100);
		}

	
	@Test
	public void testAdd100Users() {
		for(int i = 10; i < 20; i++) {
			User user = new User("admin" + i + "@ymai.com", "123", "Admin" + i, "Portal");
			userService.save(user);
		}
	}
}