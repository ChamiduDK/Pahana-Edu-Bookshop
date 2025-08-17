package com.pahana.bookshop.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int customerId;
    private Integer placedByUserId; // Changed from int to Integer to allow null
    private BigDecimal totalAmount;
    private String status;
    private Timestamp orderDate;
    private List<OrderItem> orderItems;
    private Customer customer;
    private User placedByUser;

    // Constructors
    public Order() {}

    public Order(int customerId, Integer placedByUserId, BigDecimal totalAmount, String status) {
        this.customerId = customerId;
        this.placedByUserId = placedByUserId;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Constructor for customer orders (without placedByUserId)
    public Order(int customerId, BigDecimal totalAmount, String status) {
        this.customerId = customerId;
        this.placedByUserId = null; // Explicitly set to null for customer orders
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Integer getPlacedByUserId() { return placedByUserId; }
    public void setPlacedByUserId(Integer placedByUserId) { this.placedByUserId = placedByUserId; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }

    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }

    public User getPlacedByUser() { return placedByUser; }
    public void setPlacedByUser(User placedByUser) { this.placedByUser = placedByUser; }

    // Utility methods
    public boolean isCustomerOrder() {
        return placedByUserId == null;
    }

    public boolean isAdminOrder() {
        return placedByUserId != null && placedByUserId > 0;
    }
}