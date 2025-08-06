package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.User;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.service.OrderService;
import com.pahana.bookshop.service.CustomerService;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrderController extends HttpServlet {
    private OrderService orderService;
    private CustomerService customerService;
    private BookService bookService;
    
    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.orderService = serviceFactory.createOrderService();
        this.customerService = serviceFactory.createCustomerService();
        this.bookService = serviceFactory.createBookService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("view".equals(action)) {
                handleView(request, response);
            } else if ("admin".equals(action)) {
                handleAdminView(request, response);
            } else if ("customer".equals(action)) {
                handleCustomerOrders(request, response);
            } else {
                handleList(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                handleCreate(request, response);
            } else if ("updateStatus".equals(action)) {
                handleUpdateStatus(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        }
    }
    
    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        List<Order> orders = orderService.getAllOrders();
        List<Customer> customers = customerService.getAllCustomers();
        List<Book> books = bookService.getAllBooks();
        
        request.setAttribute("orders", orders);
        request.setAttribute("customers", customers);
        request.setAttribute("books", books);
        request.getRequestDispatcher("/orders.jsp").forward(request, response);
    }
    
    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderService.getOrderById(orderId);
        
        request.setAttribute("order", order);
        request.getRequestDispatcher("/order-details.jsp").forward(request, response);
    }
    
    private void handleAdminView(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        List<Order> orders = orderService.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
    }
    
    private void handleCustomerOrders(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        List<Order> orders = orderService.getOrdersByCustomerId(customerId);
        Customer customer = customerService.getCustomerById(customerId);
        
        request.setAttribute("orders", orders);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/customer-orders.jsp").forward(request, response);
    }
    
    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String[] bookIds = request.getParameterValues("bookId");
        String[] quantities = request.getParameterValues("quantity");
        
        if (bookIds == null || quantities == null || bookIds.length != quantities.length) {
            request.setAttribute("error", "Invalid order data");
            handleList(request, response);
            return;
        }
        
        Order order = new Order(customerId, user.getId(), null, "PENDING");
        List<OrderItem> orderItems = new ArrayList<>();
        
        for (int i = 0; i < bookIds.length; i++) {
            int bookId = Integer.parseInt(bookIds[i]);
            int quantity = Integer.parseInt(quantities[i]);
            
            if (quantity > 0) { // Only add items with positive quantity
                OrderItem orderItem = new OrderItem(0, bookId, quantity, null);
                orderItems.add(orderItem);
            }
        }
        
        if (orderItems.isEmpty()) {
            request.setAttribute("error", "No valid items in order");
            handleList(request, response);
            return;
        }
        
        order.setOrderItems(orderItems);
        
        int orderId = orderService.createOrder(order);
        
        if (orderId > 0) {
            request.setAttribute("success", "Order created successfully! Order ID: " + orderId + ". Confirmation email sent to customer.");
        } else {
            request.setAttribute("error", "Failed to create order.");
        }
        
        handleList(request, response);
    }
    
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        
        boolean success = orderService.updateOrderStatus(orderId, status);
        
        if (success) {
            String message = "Order status updated successfully!";
            if ("DELIVERED".equals(status)) {
                message += " Bill email sent to customer.";
            }
            request.setAttribute("success", message);
        } else {
            request.setAttribute("error", "Failed to update order status.");
        }
        
        handleAdminView(request, response);
    }
}