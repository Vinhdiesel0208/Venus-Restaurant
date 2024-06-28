package com.restaurant.service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.restaurant.service.entities.Reservation;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {

}
