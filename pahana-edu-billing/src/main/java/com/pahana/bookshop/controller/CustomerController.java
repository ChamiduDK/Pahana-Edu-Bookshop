package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.service.CustomerService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customers")
public class CustomerController extends HttpServlet {
    private CustomerService customerService;
    
    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.customerService = serviceFactory.createCustomerService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("search".equals(action)) {
                handleSearch(request, response);
            } else if ("edit".equals(action)) {
                handleEdit(request, response);
            } else if ("generateAccount".equals(action)) {
                handleGenerateAccount(request, response);
            } else {
                handleList(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/customers.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                handleAdd(request, response);
            } else if ("update".equals(action)) {
                handleUpdate(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/customers.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/customers.jsp").forward(request, response);
        }
    }
    
    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Customer> customers = customerService.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/customers.jsp").forward(request, response);
    }
    
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        List<Customer> customers = customerService.searchCustomers(searchTerm);
        request.setAttribute("customers", customers);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/customers.jsp").forward(request, response);
    }
    
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        
        Customer customer = new Customer(accountNumber, name, address, telephone, email);
        boolean success = customerService.addCustomer(customer);
        
        if (success) {
            request.setAttribute("success", "Customer added successfully!");
        } else {
            request.setAttribute("error", "Failed to add customer.");
        }
        
        handleList(request, response);
    }
    
    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerService.getCustomerById(customerId);
        request.setAttribute("editCustomer", customer);
        handleList(request, response);
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
        
        Customer customer = customerService.getCustomerById(id);
        customer.setName(name);
        customer.setAddress(address);
        customer.setTelephone(telephone);
        customer.setEmail(email);
        customer.setUnitsConsumed(unitsConsumed);
        
        boolean success = customerService.updateCustomer(customer);
        
        if (success) {
            request.setAttribute("success", "Customer updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update customer.");
        }
        
        handleList(request, response);
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("id"));
        boolean success = customerService.deleteCustomer(customerId);
        
        if (success) {
            request.setAttribute("success", "Customer deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete customer.");
        }
        
        handleList(request, response);
    }
    
    private void handleGenerateAccount(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String accountNumber = customerService.generateNewAccountNumber();
        response.setContentType("text/plain");
        response.getWriter().write(accountNumber);
    }
}
