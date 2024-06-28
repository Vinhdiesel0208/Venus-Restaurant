package com.restaurant.service.dtos;

import java.util.List;

public class CartLineRequest {
    private String email;
    private double totalAmount;
    private long tableId;
    private List<CartLineDTO> cartLines;

    public CartLineRequest() {
    }

    public CartLineRequest(String email, double totalAmount, long tableId, List<CartLineDTO> cartLines) {
        this.email = email;
        this.totalAmount = totalAmount;
        this.tableId = tableId;
        this.cartLines = cartLines;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public long getTableId() {
        return tableId;
    }

    public void setTableId(long tableId) {
        this.tableId = tableId;
    }

    public List<CartLineDTO> getCartLines() {
        return cartLines;
    }

    public void setCartLines(List<CartLineDTO> cartLines) {
        this.cartLines = cartLines;
    }
}
