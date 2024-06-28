package com.mytech.restaurantportal.apis;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.restaurant.service.dtos.RestaurantTableDTO;
import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.services.RestaurantTableService;

@RestController
@RequestMapping("/apis/v1/tables")
@CrossOrigin(origins = "*")
public class TableResController {

    @Autowired
    private RestaurantTableService restaurantTableService;

    @GetMapping("/list")
    public ResponseEntity<List<RestaurantTableDTO>> getTableList(
            @RequestParam(value = "tableId", required = false) Long tableId,
            @RequestParam(value = "status", required = false) Boolean status,
            @RequestParam(value = "categoryName", required = false) String categoryName) {

        System.out.println("Received request for /apis/v1/tables");

        List<RestaurantTable> listTable;

        if (tableId != null) {
            RestaurantTable table = restaurantTableService.getRestaurantTableById(tableId);
            listTable = table != null ? List.of(table) : List.of();
        } else if (status != null) {
            listTable = restaurantTableService.getAllRestaurantTables().stream()
                    .filter(table -> table.isStatus() == status)
                    .collect(Collectors.toList());
        } else if (categoryName != null) {
            listTable = restaurantTableService.getAllRestaurantTables().stream()
                    .filter(table -> table.getCategory() != null && categoryName.equals(table.getCategory().getCategoryName()))
                    .collect(Collectors.toList());
        } else {
            listTable = restaurantTableService.getAllRestaurantTables();
        }

        List<RestaurantTableDTO> tableDTOs = listTable.stream().map(table -> {
            RestaurantTableDTO dto = new RestaurantTableDTO(
                    table.getId(),
                    table.getTableNumber(),
                    table.isStatus(),
                    table.getSeatCount(),
                    table.getCategory()
            );
            return dto;
        }).collect(Collectors.toList());

        System.out.println("Returning response for /apis/v1/tables: " + tableDTOs);
        return ResponseEntity.ok(tableDTOs);
    }

    @PreAuthorize("hasAuthority('STAFF')")
    @PostMapping("/{tableId}/checkin")
    public ResponseEntity<String> checkinTable(@PathVariable("tableId") Long tableId) {
        try {
            restaurantTableService.checkinTable(tableId);
            return ResponseEntity.ok("Table checked in successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to check in table.");
        }
    }

    @PreAuthorize("hasAuthority('STAFF')")
    @PostMapping("/{tableId}/checkout")
    public ResponseEntity<String> checkoutTable(@PathVariable("tableId") Long tableId) {
        try {
            restaurantTableService.checkoutTable(tableId);
            return ResponseEntity.ok("Table checked out successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to check out table.");
        }
    }
}
