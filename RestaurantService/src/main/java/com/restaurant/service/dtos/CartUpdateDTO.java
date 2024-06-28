package com.restaurant.service.dtos;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Getter
@Setter
public class CartUpdateDTO {
	private String cartLineTotal;
	private String subTotal;
	
	public String getCartLineTotal() {
		return cartLineTotal;
	}

	public void setCartLineTotal(String cartLineTotal) {
		this.cartLineTotal = cartLineTotal;
	}

	public String getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(String subTotal) {
		this.subTotal = subTotal;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	private String total;

	public CartUpdateDTO(String cartLineTotal, String subTotal, String total) {
		super();
		this.cartLineTotal = cartLineTotal;
		this.subTotal = subTotal;
		this.total = total;
	}

	public CartUpdateDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
