package com.pahana.bookshop.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int customerId;
    private int placedByUserId;
    private BigDecimal totalAmount;
    private String status;
    private Timestamp orderDate;
    private List<OrderItem> orderItems;
    private Customer customer;
    private User placedByUser;
    
    // Constructors
    public Order() {}
    
    public Order(int customerId, int placedByUserId, BigDecimal totalAmount, String status) {
        this.customerId = customerId;
        this.placedByUserId = placedByUserId;
        this.totalAmount = totalAmount;
        this.status = status;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    
    public int getPlacedByUserId() { return placedByUserId; }
    public void setPlacedByUserId(int placedByUserId) { this.placedByUserId = placedByUserId; }
    
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
}