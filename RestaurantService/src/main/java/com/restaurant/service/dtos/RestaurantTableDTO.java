package com.restaurant.service.dtos;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;
import com.restaurant.service.entities.TCategory;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class RestaurantTableDTO {
    private Long id; // Thêm biến này
    private String tableNumber;
    private boolean status;
    private int seatCount;

    @JsonProperty(access = Access.WRITE_ONLY)
    private TCategory category;

    public RestaurantTableDTO(Long id, String tableNumber, boolean status, int seatCount, TCategory category) {
        this.id = id; // Khởi tạo biến này
        this.tableNumber = tableNumber;
        this.status = status;
        this.seatCount = seatCount;
        this.category = category;
    }

    public RestaurantTableDTO() {
        super();
    }

    public Long getId() {
        return id; // Thêm getter và setter cho biến này
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(String tableNumber) {
        this.tableNumber = tableNumber;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getSeatCount() {
        return seatCount;
    }

    public void setSeatCount(int seatCount) {
        this.seatCount = seatCount;
    }

    public TCategory getCategory() {
        return category;
    }

    public void setCategory(TCategory category) {
        this.category = category;
    }
}
