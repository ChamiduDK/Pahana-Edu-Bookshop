package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.User;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.service.UserService;
import com.pahana.bookshop.service.CustomerService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserService userService;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.userService = serviceFactory.createUserService();
        this.customerService = serviceFactory.createCustomerService(); // Initialize CustomerService
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String loginType = request.getParameter("loginType");
        HttpSession session = request.getSession();

        try {
            if ("customer".equals(loginType)) {
                // Customer login
                String accountNumber = request.getParameter("accountNumber");
                String telephone = request.getParameter("telephone");

                // Validate customer credentials
                Customer customer = customerService.authenticate(accountNumber, telephone);
                if (customer != null) {
                    session.setAttribute("customer", customer);
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes
                    response.sendRedirect(request.getContextPath() + "/customer-dashboard");
                } else {
                    request.setAttribute("error", "Invalid account number or telephone number");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else {
                // Admin/Staff login (existing logic)
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                User user = userService.authenticate(username, password);
                if (user != null) {
                    session.setAttribute("user", user);
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else {
                    request.setAttribute("error", "Invalid username or password");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user or customer is already logged in
        HttpSession session = request.getSession(false);
        if (session != null) {
            if (session.getAttribute("user") != null) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            } else if (session.getAttribute("customer") != null) {
                response.sendRedirect(request.getContextPath() + "/customer-dashboard");
                return;
            }
        }

        // If logout parameter is present, show success message
        if ("true".equals(request.getParameter("logout"))) {
            request.setAttribute("success", "You have been successfully logged out.");
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}