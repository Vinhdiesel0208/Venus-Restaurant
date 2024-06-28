package com.mytech.restaurantportal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;

import com.mytech.restaurantportal.RestaurantPortalApplication;


@SpringBootApplication
@ComponentScan(basePackages = {"com.mytech.restaurantportal", "com.restaurant.service", "com.restaurant.service.mappers"})
@EntityScan({"com.restaurant.service.entities"})
public class  RestaurantPortalApplication {

	public static void main(String[] args) {
		SpringApplication.run(RestaurantPortalApplication.class, args);
	}

}