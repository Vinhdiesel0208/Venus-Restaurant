package com.mytech.RestaurantsWeb;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.mytech.RestaurantsWeb", "com.mytech.RestaurantsWeb.security", "com.restaurant.service"})
public class RestaurantsWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(RestaurantsWebApplication.class, args);
	}

}
