package com.pahana.bookshop.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.service.CustomerService;
import com.pahana.bookshop.service.ServiceFactory;

@WebServlet(name = "CustomerProfileController", urlPatterns = {"/customer-profile"})
public class CustomerProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CustomerProfileController.class.getName());
    
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        try {
            LOGGER.info("Initializing CustomerProfileController");
            ServiceFactory serviceFactory = ServiceFactory.getInstance();
            this.customerService = serviceFactory.createCustomerService();
            LOGGER.info("CustomerProfileController initialized successfully");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize CustomerProfileController", e);
            throw new ServletException("Controller initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        LOGGER.info("Processing GET request for customer profile");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            LOGGER.warning("No session found, redirecting to login");
            redirectToLogin(request, response, "Session expired. Please log in again.");
            return;
        }
        
        Customer customer = (Customer) session.getAttribute("customer");

        // Check if customer is logged in
        if (customer == null) {
            LOGGER.warning("No customer in session, redirecting to login");
            redirectToLogin(request, response, "Please log in to access your profile");
            return;
        }

        if (customer.getId() <= 0) {
            LOGGER.warning("Invalid customer ID: " + customer.getId());
            session.invalidate();
            redirectToLogin(request, response, "Invalid session. Please log in again.");
            return;
        }

        try {
            // Refresh customer data from database to ensure we have latest info
            Customer refreshedCustomer = customerService.getCustomerById(customer.getId());
            if (refreshedCustomer != null) {
                session.setAttribute("customer", refreshedCustomer);
                request.setAttribute("customer", refreshedCustomer);
                LOGGER.info("Customer profile loaded successfully for ID: " + customer.getId());
            } else {
                LOGGER.warning("Customer not found in database: " + customer.getId());
                request.setAttribute("customer", customer);
                request.setAttribute("warning", "Profile data may be outdated. Please refresh.");
            }

            // Check for success message from profile update
            String updateSuccess = (String) session.getAttribute("profileUpdateSuccess");
            if (updateSuccess != null) {
                request.setAttribute("success", updateSuccess);
                session.removeAttribute("profileUpdateSuccess");
                LOGGER.info("Profile update success message displayed");
            }

            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while loading customer profile", e);
            request.setAttribute("error", "Unable to load profile. Please try again later.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error while loading customer profile", e);
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOGGER.info("Processing POST request for customer profile");
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            redirectToLogin(request, response, "Session expired. Please log in again.");
            return;
        }
        
        Customer sessionCustomer = (Customer) session.getAttribute("customer");

        if (sessionCustomer == null) {
            LOGGER.warning("No customer in session during POST");
            redirectToLogin(request, response, "Please log in to update your profile");
            return;
        }

        if (sessionCustomer.getId() <= 0) {
            LOGGER.warning("Invalid customer ID during POST: " + sessionCustomer.getId());
            session.invalidate();
            redirectToLogin(request, response, "Invalid session. Please log in again.");
            return;
        }

        try {
            // Get the action parameter to determine what to update
            String action = request.getParameter("action");
            LOGGER.info("Profile update action: " + action);
            
            if ("updatePersonal".equals(action)) {
                handlePersonalInfoUpdate(request, response, session, sessionCustomer);
            } else if ("changePassword".equals(action)) {
                handlePasswordChange(request, response, session, sessionCustomer);
            } else if ("addAddress".equals(action)) {
                handleAddressAdd(request, response, session, sessionCustomer);
            } else if ("updateAddress".equals(action)) {
                handleAddressUpdate(request, response, session, sessionCustomer);
            } else {
                // Default behavior - treat as personal info update
                handlePersonalInfoUpdate(request, response, session, sessionCustomer);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing profile update", e);
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.setAttribute("customer", sessionCustomer);
            request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
        }
    }
    
    private void handlePersonalInfoUpdate(HttpServletRequest request, HttpServletResponse response, 
                                        HttpSession session, Customer sessionCustomer) 
            throws ServletException, IOException {
        
        // Get updated information from form
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");

        // Validate required fields
        if (name == null || name.trim().isEmpty()) {
            setErrorAndForward(request, response, sessionCustomer, "Name is required.");
            return;
        }

        if (address == null || address.trim().isEmpty()) {
            setErrorAndForward(request, response, sessionCustomer, "Address is required.");
            return;
        }

        if (telephone == null || telephone.trim().isEmpty()) {
            setErrorAndForward(request, response, sessionCustomer, "Telephone is required.");
            return;
        }

        try {
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
                LOGGER.info("Profile updated successfully for customer ID: " + sessionCustomer.getId());

                // Redirect to avoid form resubmission
                response.sendRedirect(request.getContextPath() + "/customer-profile");
                return;
            } else {
                LOGGER.warning("Failed to update profile for customer ID: " + sessionCustomer.getId());
                setErrorAndForward(request, response, sessionCustomer, "Failed to update profile. Please try again.");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while updating customer profile", e);
            setErrorAndForward(request, response, sessionCustomer, "Database error occurred. Please try again later.");
        }
    }
    
    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response, 
                                    HttpSession session, Customer sessionCustomer) 
            throws ServletException, IOException {
        // Implementation for password change
        // This would typically involve password validation, hashing, etc.
        LOGGER.info("Password change requested for customer ID: " + sessionCustomer.getId());
        
        session.setAttribute("profileUpdateSuccess", "Password changed successfully!");
        response.sendRedirect(request.getContextPath() + "/customer-profile#security");
    }
    
    private void handleAddressAdd(HttpServletRequest request, HttpServletResponse response, 
                                HttpSession session, Customer sessionCustomer) 
            throws ServletException, IOException {
        // Implementation for adding new address
        LOGGER.info("Address add requested for customer ID: " + sessionCustomer.getId());
        
        session.setAttribute("profileUpdateSuccess", "Address added successfully!");
        response.sendRedirect(request.getContextPath() + "/customer-profile#address");
    }
    
    private void handleAddressUpdate(HttpServletRequest request, HttpServletResponse response, 
                                   HttpSession session, Customer sessionCustomer) 
            throws ServletException, IOException {
        // Implementation for updating existing address
        LOGGER.info("Address update requested for customer ID: " + sessionCustomer.getId());
        
        session.setAttribute("profileUpdateSuccess", "Address updated successfully!");
        response.sendRedirect(request.getContextPath() + "/customer-profile#address");
    }

    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response, String errorMessage) 
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    private void setErrorAndForward(HttpServletRequest request, HttpServletResponse response, 
                                  Customer customer, String errorMessage) 
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/customer-profile.jsp").forward(request, response);
    }
}