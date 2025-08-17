package com.pahana.bookshop.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.service.CustomerService;

@WebServlet({"/register", "/registration"})
public class CustomerRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CustomerService customerService;
    
    public CustomerRegistrationServlet() {
        this.customerService = new CustomerService();
    }
    
    // Constructor for dependency injection (testing)
    public CustomerRegistrationServlet(CustomerService customerService) {
        this.customerService = customerService;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to registration JSP page
        request.getRequestDispatcher("/WEB-INF/views/customer-registration.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String name = sanitizeInput(request.getParameter("name"));
            String address = sanitizeInput(request.getParameter("address"));
            String telephone = sanitizeInput(request.getParameter("telephone"));
            String email = sanitizeInput(request.getParameter("email"));
            String unitsConsumedStr = request.getParameter("unitsConsumed");
            
            // Validate required fields
            if (isNullOrEmpty(name)) {
                request.setAttribute("error", "Full name is required");
                forwardToRegistrationPage(request, response);
                return;
            }
            
            if (isNullOrEmpty(address)) {
                request.setAttribute("error", "Address is required");
                forwardToRegistrationPage(request, response);
                return;
            }
            
            if (isNullOrEmpty(telephone)) {
                request.setAttribute("error", "Telephone number is required");
                forwardToRegistrationPage(request, response);
                return;
            }
            
            // Validate telephone format (Sri Lankan format)
            String cleanedTelephone = telephone.replaceAll("[\\s\\-\\(\\)]", "");
            if (!cleanedTelephone.matches("^0\\d{9}$")) {
                request.setAttribute("error", "Please enter a valid 10-digit Sri Lankan phone number (e.g., 0771234567)");
                forwardToRegistrationPage(request, response);
                return;
            }
            
            // Validate email if provided
            if (!isNullOrEmpty(email) && !isValidEmail(email)) {
                request.setAttribute("error", "Please enter a valid email address");
                forwardToRegistrationPage(request, response);
                return;
            }
            
            // Check if customer with this telephone already exists
            Customer existingCustomer = customerService.getCustomerByTelephone(cleanedTelephone);
            if (existingCustomer != null) {
                request.setAttribute("error", "A customer with this telephone number already exists");
                forwardToRegistrationPage(request, response);
                return;
            }
            
            // Parse units consumed
            int unitsConsumed = 0;
            if (!isNullOrEmpty(unitsConsumedStr)) {
                try {
                    unitsConsumed = Integer.parseInt(unitsConsumedStr);
                    if (unitsConsumed < 0) {
                        request.setAttribute("error", "Units consumed cannot be negative");
                        forwardToRegistrationPage(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid units consumed value");
                    forwardToRegistrationPage(request, response);
                    return;
                }
            }
            
            // Create new customer object
            Customer newCustomer = new Customer();
            newCustomer.setName(name);
            newCustomer.setAddress(address);
            newCustomer.setTelephone(cleanedTelephone);
            newCustomer.setEmail(email);
            newCustomer.setUnitsConsumed(unitsConsumed);
            
            // Register the customer
            boolean success = customerService.addCustomer(newCustomer);
            
            if (success) {
                // Get the created customer to display account number
                Customer createdCustomer = customerService.getCustomerByTelephone(cleanedTelephone);
                
                // Set success message with account number
                String successMessage = "Account created successfully! Your account number is: " + 
                                      createdCustomer.getAccountNumber() + 
                                      ". Please save this number for future logins.";
                request.setAttribute("success", successMessage);
                request.setAttribute("accountNumber", createdCustomer.getAccountNumber());
                request.setAttribute("customerName", createdCustomer.getName());
                
                // Clear form data
                request.removeAttribute("name");
                request.removeAttribute("address");
                request.removeAttribute("telephone");
                request.removeAttribute("email");
                request.removeAttribute("unitsConsumed");
                
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                forwardToRegistrationPage(request, response);
                return;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            forwardToRegistrationPage(request, response);
            return;
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            forwardToRegistrationPage(request, response);
            return;
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            forwardToRegistrationPage(request, response);
            return;
        }
        
        // Forward to registration page with success message
        forwardToRegistrationPage(request, response);
    }
    
    private void forwardToRegistrationPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/customer-registration.jsp").forward(request, response);
    }
    
    private String sanitizeInput(String input) {
        if (input == null) return null;
        return input.trim();
    }
    
    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    private boolean isValidEmail(String email) {
        if (isNullOrEmpty(email)) return false;
        return email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    }
}