package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.BookDAO;
import com.pahana.bookshop.dao.OrderDAO;
import com.pahana.bookshop.dao.CustomerDAO;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.util.EmailUtil;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private OrderDAO orderDAO;
    private BookDAO bookDAO;
    private CustomerDAO customerDAO;
    private EmailUtil emailUtil;
    
    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.bookDAO = new BookDAO();
        this.customerDAO = new CustomerDAO();
        this.emailUtil = new EmailUtil();
    }
    
    public int createOrder(Order order) throws SQLException {
        validateOrder(order);
        
        // Get customer details
        Customer customer = customerDAO.findById(order.getCustomerId());
        if (customer == null) {
            throw new IllegalArgumentException("Customer not found");
        }
        
        // Calculate total amount
        BigDecimal totalAmount = BigDecimal.ZERO;
        int totalUnits = 0;
        
        for (OrderItem item : order.getOrderItems()) {
            // Verify book availability
            Book book = bookDAO.findById(item.getBookId());
            if (book == null) {
                throw new IllegalArgumentException("Book with ID " + item.getBookId() + " not found");
            }
            if (book.getStockQuantity() < item.getQuantity()) {
                throw new IllegalArgumentException("Insufficient stock for book: " + book.getTitle());
            }
            
            // Set unit price from current book price
            item.setUnitPrice(book.getPrice());
            totalAmount = totalAmount.add(item.getSubtotal());
            totalUnits += item.getQuantity();
        }
        
        order.setTotalAmount(totalAmount);
        order.setStatus("PENDING");
        
        // Create order
        int orderId = orderDAO.create(order);
        if (orderId > 0) {
            // Create order items and update stock
            for (OrderItem item : order.getOrderItems()) {
                item.setOrderId(orderId);
                orderDAO.createOrderItem(item);
                
                // Update book stock
                Book book = bookDAO.findById(item.getBookId());
                int newQuantity = book.getStockQuantity() - item.getQuantity();
                bookDAO.updateStock(item.getBookId(), newQuantity);
            }
            
            // Update customer units consumed
            customer.setUnitsConsumed(customer.getUnitsConsumed() + totalUnits);
            customerDAO.update(customer);
            
            // Send order confirmation email
            try {
                Order fullOrder = orderDAO.findById(orderId);
                emailUtil.sendOrderConfirmation(fullOrder);
            } catch (Exception e) {
                // Log error but don't fail the order
                System.err.println("Failed to send confirmation email: " + e.getMessage());
            }
        }
        
        return orderId;
    }
    
    public Order getOrderById(int id) throws SQLException {
        return orderDAO.findById(id);
    }
    
    public List<Order> getOrdersByCustomerId(int customerId) throws SQLException {
        return orderDAO.findByCustomerId(customerId);
    }
    
    public List<Order> getAllOrders() throws SQLException {
        return orderDAO.findAll();
    }
    
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        if (!isValidStatus(status)) {
            throw new IllegalArgumentException("Invalid order status: " + status);
        }
        
        boolean updated = orderDAO.updateStatus(orderId, status);
        
        // Send bill email when order is delivered
        if (updated && "DELIVERED".equals(status)) {
            try {
                Order order = orderDAO.findById(orderId);
                emailUtil.sendBillEmail(order);
            } catch (Exception e) {
                System.err.println("Failed to send bill email: " + e.getMessage());
            }
        }
        
        return updated;
    }
    
    private void validateOrder(Order order) {
        if (order == null) {
            throw new IllegalArgumentException("Order cannot be null");
        }
        if (order.getCustomerId() <= 0) {
            throw new IllegalArgumentException("Valid customer ID is required");
        }
        if (order.getPlacedByUserId() <= 0) {
            throw new IllegalArgumentException("Valid user ID is required");
        }
        if (order.getOrderItems() == null || order.getOrderItems().isEmpty()) {
            throw new IllegalArgumentException("Order must contain at least one item");
        }
        
        for (OrderItem item : order.getOrderItems()) {
            if (item.getBookId() <= 0) {
                throw new IllegalArgumentException("Valid book ID is required for all items");
            }
            if (item.getQuantity() <= 0) {
                throw new IllegalArgumentException("Quantity must be greater than zero for all items");
            }
        }
    }
    
    private boolean isValidStatus(String status) {
        return status != null && 
               (status.equals("PENDING") || status.equals("CONFIRMED") || 
                status.equals("SHIPPED") || status.equals("DELIVERED") || 
                status.equals("CANCELLED"));
    }
}
