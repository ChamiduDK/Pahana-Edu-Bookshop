package com.pahana.bookshop.controller;

import com.pahana.bookshop.service.*;
import com.pahana.bookshop.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private CustomerService customerService;
    private OrderService orderService;
    private BookService bookService;
    
    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.customerService = serviceFactory.createCustomerService();
        this.orderService = serviceFactory.createOrderService();
        this.bookService = serviceFactory.createBookService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get dashboard statistics
            List<Customer> customers = customerService.getAllCustomers();
            List<Order> orders = orderService.getAllOrders();
            List<Book> books = bookService.getAllBooks();
            
            // Calculate statistics
            int totalCustomers = customers.size();
            int totalOrders = orders.size();
            int totalBooks = books.size();
            
            // Recent orders (last 5)
            List<Order> recentOrders = orders.size() > 5 ? 
                orders.subList(0, 5) : orders;
            
            // Low stock books (stock <= 10)
            List<Book> lowStockBooks = books.stream()
                .filter(book -> book.getStockQuantity() <= 10)
                .collect(java.util.stream.Collectors.toList());
            
            // Pending orders count
            long pendingOrdersCount = orders.stream()
                .filter(order -> !"DELIVERED".equals(order.getStatus()) && !"CANCELLED".equals(order.getStatus()))
                .count();
            
            // Set attributes
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalBooks", totalBooks);
            request.setAttribute("pendingOrders", pendingOrdersCount);
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("lowStockBooks", lowStockBooks);
            
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        }
    }
}