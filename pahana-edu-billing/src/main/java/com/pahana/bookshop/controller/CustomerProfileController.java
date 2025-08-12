package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Customer;
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

@WebServlet("/customer-profile")
public class CustomerProfileController extends HttpServlet {
    private CustomerService customerService;
    
    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.customerService = serviceFactory.createCustomerService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Check if customer is logged in
        if (customer == null) {
            request.setAttribute("error", "Please log in to access your profile");
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
            // Refresh customer data from database to ensure we have latest info
            Customer refreshedCustomer = customerService.getCustomerById(customer.getId());
            if (refreshedCustomer != null) {
                session.setAttribute("customer", refreshedCustomer);
                request.setAttribute("customer", refreshedCustomer);
            } else {
                request.setAttribute("customer", customer);
            }
            
            // Check for success message from profile update
            String updateSuccess = (String) session.getAttribute("profileUpdateSuccess");
            if (updateSuccess != null) {
                request.setAttribute("success", updateSuccess);
                session.removeAttribute("profileUpdateSuccess"); // Remove after displaying
            }
            
            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("Database error while loading customer profile: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load profile. Please try again later.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Unexpected error while loading customer profile: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer sessionCustomer = (Customer) session.getAttribute("customer");
        
        if (sessionCustomer == null) {
            request.setAttribute("error", "Please log in to update your profile");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        if (sessionCustomer.getId() <= 0) {
            session.invalidate();
            request.setAttribute("error", "Invalid session. Please log in again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Get updated information from form
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            
            // Validate required fields
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Name is required.");
                request.setAttribute("customer", sessionCustomer);
                request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
                return;
            }
            
            if (address == null || address.trim().isEmpty()) {
                request.setAttribute("error", "Address is required.");
                request.setAttribute("customer", sessionCustomer);
                request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
                return;
            }
            
            if (telephone == null || telephone.trim().isEmpty()) {
                request.setAttribute("error", "Telephone is required.");
                request.setAttribute("customer", sessionCustomer);
                request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
                return;
            }
            
            // Create updated customer object
            Customer updatedCustomer = new Customer();
            updatedCustomer.setId(sessionCustomer.getId());
            updatedCustomer.setAccountNumber(sessionCustomer.getAccountNumber());
            updatedCustomer.setName(name.trim());
            updatedCustomer.setAddress(address.trim());
            updatedCustomer.setTelephone(telephone.trim());
            updatedCustomer.setEmail(email != null ? email.trim() : "");
            updatedCustomer.setUnitsConsumed(sessionCustomer.getUnitsConsumed());
            updatedCustomer.setCreatedAt(sessionCustomer.getCreatedAt());
            
            // Update in database
            boolean success = customerService.updateCustomer(updatedCustomer);
            
            if (success) {
                // Update session with new data
                session.setAttribute("customer", updatedCustomer);
                session.setAttribute("profileUpdateSuccess", "Profile updated successfully!");
                
                // Redirect to avoid form resubmission
                response.sendRedirect(request.getContextPath() + "/customer-profile");
                return;
            } else {
                request.setAttribute("error", "Failed to update profile. Please try again.");
                request.setAttribute("customer", sessionCustomer);
            }
            
        } catch (SQLException e) {
            System.err.println("Database error while updating customer profile: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.setAttribute("customer", sessionCustomer);
            
        } catch (Exception e) {
            System.err.println("Unexpected error while updating customer profile: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.setAttribute("customer", sessionCustomer);
        }
        
        // Forward back to the profile page
        request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
    }
}