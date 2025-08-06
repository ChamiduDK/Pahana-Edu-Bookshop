package com.pahana.bookshop.model;

import java.math.BigDecimal;

public class OrderItem {
    private int id;
    private int orderId;
    private int bookId;
    private int quantity;
    private BigDecimal unitPrice;
    private Book book; // For joined queries
    
    // Constructors
    public OrderItem() {}
    
    public OrderItem(int orderId, int bookId, int quantity, BigDecimal unitPrice) {
        this.orderId = orderId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    
    // Calculated properties
    public BigDecimal getSubtotal() {
        if (unitPrice != null && quantity > 0) {
            return unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }
    
    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", bookId=" + bookId +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}