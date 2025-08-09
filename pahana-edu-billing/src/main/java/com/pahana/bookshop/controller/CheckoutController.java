package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.Customer;
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

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
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
        if (customer == null || customer.getId() <= 0) {
            request.setAttribute("error", "Please log in to proceed to checkout");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("error", "Your cart is empty");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null || customer.getId() <= 0) {
            request.setAttribute("error", "Valid user ID is required. Please log in.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("error", "Your cart is empty");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        try {
            Order order = new Order();
            order.setCustomerId(customer.getId());
            order.setPlacedByUserId(0); // Customer-placed order
            order.setOrderItems(cartItems);
            int orderId = orderService.createOrder(order);
            if (orderId > 0) {
                session.removeAttribute("cart"); // Clear cart
                request.setAttribute("success", "Order placed successfully. Order ID: " + orderId);
                response.sendRedirect(request.getContextPath() + "/customer-orders");
            } else {
                request.setAttribute("error", "Failed to place order");
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
}