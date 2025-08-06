package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.CustomerDAO;
import com.pahana.bookshop.model.Customer;

import java.sql.SQLException;
import java.util.List;

public class CustomerService {
    private CustomerDAO customerDAO;
    
    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }
    
    public boolean addCustomer(Customer customer) throws SQLException {
        validateCustomer(customer);
        
        // Generate account number if not provided
        if (customer.getAccountNumber() == null || customer.getAccountNumber().trim().isEmpty()) {
            customer.setAccountNumber(customerDAO.generateAccountNumber());
        }
        
        return customerDAO.create(customer);
    }
    
    public Customer getCustomerById(int id) throws SQLException {
        return customerDAO.findById(id);
    }
    
    public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException {
        return customerDAO.findByAccountNumber(accountNumber);
    }
    
    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.findAll();
    }
    
    public List<Customer> searchCustomers(String searchTerm) throws SQLException {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllCustomers();
        }
        return customerDAO.searchCustomers(searchTerm.trim());
    }
    
    public boolean updateCustomer(Customer customer) throws SQLException {
        validateCustomer(customer);
        return customerDAO.update(customer);
    }
    
    public boolean deleteCustomer(int id) throws SQLException {
        return customerDAO.delete(id);
    }
    
    public String generateNewAccountNumber() throws SQLException {
        return customerDAO.generateAccountNumber();
    }
    
    private void validateCustomer(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }
        if (customer.getName() == null || customer.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Customer name is required");
        }
        if (customer.getAddress() == null || customer.getAddress().trim().isEmpty()) {
            throw new IllegalArgumentException("Customer address is required");
        }
        if (customer.getTelephone() == null || customer.getTelephone().trim().isEmpty()) {
            throw new IllegalArgumentException("Customer telephone is required");
        }
        if (customer.getEmail() != null && !customer.getEmail().trim().isEmpty() && !customer.getEmail().contains("@")) {
            throw new IllegalArgumentException("Invalid email format");
        }
    }
}
