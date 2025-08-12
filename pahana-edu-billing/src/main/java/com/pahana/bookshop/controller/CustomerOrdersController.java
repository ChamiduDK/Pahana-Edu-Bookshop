package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.service.OrderService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer-orders")
public class CustomerOrdersController extends HttpServlet {
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.orderService = serviceFactory.createOrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Check if customer is logged in
        if (customer == null) {
            request.setAttribute("error", "Please log in to view your orders");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        if (customer.getId() <= 0) {
            // Invalid customer ID - force re-login
            session.invalidate();
            request.setAttribute("error", "Invalid session. Please log in again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Get customer's orders
            List<Order> orders = orderService.getOrdersByCustomerId(customer.getId());
            
            // Check for success message from order placement
            String orderSuccess = (String) session.getAttribute("orderSuccess");
            if (orderSuccess != null) {
                request.setAttribute("success", orderSuccess);
                session.removeAttribute("orderSuccess"); // Remove after displaying
            }
            
            request.setAttribute("orders", orders);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/customer-orders.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("Database error while fetching customer orders: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load orders. Please try again later.");
            request.getRequestDispatcher("/customer-orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Unexpected error while fetching customer orders: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/customer-orders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle order actions like cancel, etc. (if needed in the future)
        doGet(request, response);
    }
}