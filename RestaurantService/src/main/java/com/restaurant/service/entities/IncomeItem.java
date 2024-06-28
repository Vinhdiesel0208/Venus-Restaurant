package com.restaurant.service.entities;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "income_item")
public class IncomeItem extends AbstractEntity {


	private static final long serialVersionUID = -8686189964045077179L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "income_id")
    private Income income;

    @ManyToOne
    @JoinColumn(name = "order_item_id")
    private OrderItem orderItem;
    
    
    private boolean halfPortion;
    public OrderItem getOrderItem() {
		return orderItem;
	}

	public IncomeItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	public IncomeItem(Long id, Income income, OrderItem orderItem, boolean halfPortion, Ingredient ingredient,
			BigDecimal soldQuantity, BigDecimal price) {
		super();
		this.id = id;
		this.income = income;
		this.orderItem = orderItem;
		this.halfPortion = halfPortion;
		this.ingredient = ingredient;
		this.soldQuantity = soldQuantity;
		this.price = price;
	}

	public void setOrderItem(OrderItem orderItem) {
		this.orderItem = orderItem;
	}

	public boolean isHalfPortion() {
		return halfPortion;
	}

	public void setHalfPortion(boolean halfPortion) {
		this.halfPortion = halfPortion;
	}

	@ManyToOne
    @JoinColumn(name = "ingredient_id")
    private Ingredient ingredient;

    @Column(name = "sold_quantity",precision = 10, scale=1)
    private BigDecimal soldQuantity;
    @Column(name = "price",precision = 10, scale=1)
    private BigDecimal price;
    
    @Transient
	public BigDecimal getTotalPrice() {
		return soldQuantity.multiply(price);
	}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Income getIncome() {
        return income;
    }

    public void setIncome(Income income) {
        this.income = income;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
 
    }

    public BigDecimal getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(BigDecimal soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    // Calculate soldQuantity based on OrderItems
    public void calculateSoldQuantity() {
        BigDecimal totalSoldQuantity = BigDecimal.ZERO;
        for (OrderItem orderItem : this.income.getOrder().getOrderItems()) {
            if (orderItem.getIngredient().equals(this.ingredient) && orderItem.getOrder().getOrdertime().equals(this.income.getDay())) {
                totalSoldQuantity = totalSoldQuantity.add(orderItem.getQuantity());
            }
        }
        this.soldQuantity = totalSoldQuantity;
    }

//    public void calculateTotalPrice() {
//        BigDecimal totalTotalPrice = BigDecimal.ZERO;
//        for (OrderItem orderItem : this.income.getOrder().getOrderItems()) {
//            if (orderItem.getIngredient().equals(this.ingredient) && orderItem.getOrder().getOrdertime().equals(this.income.getDay())) {
//                totalTotalPrice = totalTotalPrice.add(orderItem.getPrice());
//            }
//        }
//        this.totalPrice = totalTotalPrice;
//    }
}
