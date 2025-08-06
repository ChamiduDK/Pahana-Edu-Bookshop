package com.pahana.bookshop.dao;

import com.pahana.bookshop.config.DatabaseConnection;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.User;
import com.pahana.bookshop.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private DatabaseConnection dbConnection;
    
    public OrderDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }
    
    public int create(Order order) throws SQLException {
        String sql = "INSERT INTO orders (customer_id, placed_by_user_id, total_amount, status) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, order.getCustomerId());
            pstmt.setInt(2, order.getPlacedByUserId());
            pstmt.setBigDecimal(3, order.getTotalAmount());
            pstmt.setString(4, order.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        return -1;
    }
    
    public boolean createOrderItem(OrderItem orderItem) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, book_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getBookId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setBigDecimal(4, orderItem.getUnitPrice());
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    public Order findById(int id) throws SQLException {
        String sql = "SELECT o.*, c.account_number, c.name as customer_name, c.address, c.telephone, c.email as customer_email, " +
                    "u.username as placed_by_username FROM orders o " +
                    "JOIN customers c ON o.customer_id = c.id " +
                    "JOIN users u ON o.placed_by_user_id = u.id " +
                    "WHERE o.id = ?";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    order.setOrderItems(findOrderItemsByOrderId(id));
                    return order;
                }
            }
        }
        return null;
    }
    
    public List<Order> findByCustomerId(int customerId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.account_number, c.name as customer_name, c.address, c.telephone, c.email as customer_email, " +
                    "u.username as placed_by_username FROM orders o " +
                    "JOIN customers c ON o.customer_id = c.id " +
                    "JOIN users u ON o.placed_by_user_id = u.id " +
                    "WHERE o.customer_id = ? ORDER BY o.order_date DESC";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    order.setOrderItems(findOrderItemsByOrderId(order.getId()));
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    
    public List<Order> findAll() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.account_number, c.name as customer_name, c.address, c.telephone, c.email as customer_email, " +
                    "u.username as placed_by_username FROM orders o " +
                    "JOIN customers c ON o.customer_id = c.id " +
                    "JOIN users u ON o.placed_by_user_id = u.id " +
                    "ORDER BY o.order_date DESC";
        
        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setOrderItems(findOrderItemsByOrderId(order.getId()));
                orders.add(order);
            }
        }
        return orders;
    }
    
    public boolean updateStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    private List<OrderItem> findOrderItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT oi.*, b.title, b.author FROM order_items oi " +
                    "JOIN books b ON oi.book_id = b.id WHERE oi.order_id = ?";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setId(rs.getInt("id"));
                    orderItem.setOrderId(rs.getInt("order_id"));
                    orderItem.setBookId(rs.getInt("book_id"));
                    orderItem.setQuantity(rs.getInt("quantity"));
                    orderItem.setUnitPrice(rs.getBigDecimal("unit_price"));
                    
                    // Create a minimal book object for display purposes
                    Book book = new Book();
                    book.setId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    orderItem.setBook(book);
                    
                    orderItems.add(orderItem);
                }
            }
        }
        return orderItems;
    }
    
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setCustomerId(rs.getInt("customer_id"));
        order.setPlacedByUserId(rs.getInt("placed_by_user_id"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        
        // Set customer information
        Customer customer = new Customer();
        customer.setId(rs.getInt("customer_id"));
        customer.setAccountNumber(rs.getString("account_number"));
        customer.setName(rs.getString("customer_name"));
        customer.setAddress(rs.getString("address"));
        customer.setTelephone(rs.getString("telephone"));
        customer.setEmail(rs.getString("customer_email"));
        order.setCustomer(customer);
        
        // Set user information
        User user = new User();
        user.setId(rs.getInt("placed_by_user_id"));
        user.setUsername(rs.getString("placed_by_username"));
        order.setPlacedByUser(user);
        
        return order;
    }
}