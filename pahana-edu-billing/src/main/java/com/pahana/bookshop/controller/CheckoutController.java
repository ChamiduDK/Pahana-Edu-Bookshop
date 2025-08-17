package com.pahana.bookshop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.service.OrderService;
import com.pahana.bookshop.service.ServiceFactory;

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

        // Check if customer is logged in and has valid ID
        if (customer == null) {
            request.setAttribute("error", "Please log in to proceed to checkout");
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

        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("error", "Your cart is empty");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        // Calculate total for display
        BigDecimal cartTotal = BigDecimal.ZERO;
        for (OrderItem item : cartItems) {
            if (item.getSubtotal() != null) {
                cartTotal = cartTotal.add(item.getSubtotal());
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        // Comprehensive customer validation
        if (customer == null) {
            session.invalidate();
            request.setAttribute("error", "Session expired. Please log in again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (customer.getId() <= 0) {
            session.invalidate();
            request.setAttribute("error", "Invalid customer session. Please log in again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("error", "Your cart is empty");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
            return;
        }

        // Validate cart items have valid quantities and prices
        for (OrderItem item : cartItems) {
            if (item.getQuantity() <= 0 ||
                item.getUnitPrice() == null ||
                item.getUnitPrice().compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("error", "Invalid item in cart. Please refresh your cart.");
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
                return;
            }
        }

        try {
            // Create order object
            Order order = new Order();
            order.setCustomerId(customer.getId());
            // Do NOT set placedByUserId for customer orders - it's only for admin-placed orders
            // order.setPlacedByUserId(0); // Remove this line
            order.setOrderItems(cartItems);

            // Create the order
            int orderId = orderService.createOrder(order);

            if (orderId > 0) {
                // Clear the cart after successful order
                session.removeAttribute("cart");

                // Set success message in session to survive redirect
                session.setAttribute("orderSuccess", "Order placed successfully! Order ID: " + orderId);

                // Redirect to customer orders page
                response.sendRedirect(request.getContextPath() + "/customer-orders");
            } else {
                request.setAttribute("error", "Failed to place order. Please try again.");
                request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            System.err.println("Database error during checkout: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            System.err.println("Validation error during checkout: " + e.getMessage());
            request.setAttribute("error", "Order validation failed: " + e.getMessage());
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Unexpected error during checkout: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }
}