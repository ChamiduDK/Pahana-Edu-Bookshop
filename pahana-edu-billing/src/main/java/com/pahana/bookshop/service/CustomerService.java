package com.pahana.bookshop.service;

import java.sql.SQLException;
import java.util.List;

import com.pahana.bookshop.dao.CustomerDAO;
import com.pahana.bookshop.model.Customer;

public class CustomerService {

    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    // Constructor for dependency injection (optional, for testing or flexibility)
    public CustomerService(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    public boolean addCustomer(Customer customer) throws SQLException {
        validateCustomer(customer);
        
        // Generate account number if not provided
        if (customer.getAccountNumber() == null || customer.getAccountNumber().trim().isEmpty()) {
            customer.setAccountNumber(customerDAO.generateAccountNumber());
        }
        
        // Normalize telephone number before saving
        if (customer.getTelephone() != null) {
            customer.setTelephone(customer.getTelephone().replaceAll("[\\s-()]", ""));
        }

        return customerDAO.create(customer);
    }

    public Customer getCustomerById(int id) throws SQLException {
        return customerDAO.findById(id);
    }

    public Customer getCustomerByAccountNumber(String accountNumber) throws SQLException {
        return customerDAO.findByAccountNumber(accountNumber);
    }

    public Customer getCustomerByTelephone(String telephone) throws SQLException {
        if (telephone == null || telephone.trim().isEmpty()) {
            return null;
        }
        
        // Normalize telephone number for search
        String normalizedTelephone = telephone.replaceAll("[\\s-()]", "");
        return customerDAO.findByTelephone(normalizedTelephone);
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
        
        // Normalize telephone number before updating
        if (customer.getTelephone() != null) {
            customer.setTelephone(customer.getTelephone().replaceAll("[\\s-()]", ""));
        }
        
        return customerDAO.update(customer);
    }

    public boolean deleteCustomer(int id) throws SQLException {
        return customerDAO.delete(id);
    }

    public String generateNewAccountNumber() throws SQLException {
        return customerDAO.generateAccountNumber();
    }

    public Customer authenticate(String accountNumber, String telephone) throws SQLException {
        // Input validation
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Account number is required");
        }

        if (telephone == null || telephone.trim().isEmpty()) {
            throw new IllegalArgumentException("Telephone number is required");
        }

        // Normalize telephone number (remove spaces, dashes, etc.)
        String normalizedTelephone = telephone.replaceAll("[\\s-()]", "");

        // Query customer by account number and telephone
        Customer customer = customerDAO.findByAccountNumberAndTelephone(accountNumber.trim(), normalizedTelephone);

        return customer; // Returns null if no customer found
    }

    public boolean isAccountNumberExists(String accountNumber) throws SQLException {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return false;
        }
        Customer customer = customerDAO.findByAccountNumber(accountNumber.trim());
        return customer != null;
    }

    public boolean isTelephoneExists(String telephone) throws SQLException {
        if (telephone == null || telephone.trim().isEmpty()) {
            return false;
        }
        String normalizedTelephone = telephone.replaceAll("[\\s-()]", "");
        Customer customer = customerDAO.findByTelephone(normalizedTelephone);
        return customer != null;
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

        // Validate telephone format (Sri Lankan format)
        String cleanedTelephone = customer.getTelephone().replaceAll("[\\s-()]", "");
        if (!cleanedTelephone.matches("^0\\d{9}$")) {
            throw new IllegalArgumentException("Invalid telephone format. Please use Sri Lankan format (e.g., 0771234567)");
        }

        if (customer.getEmail() != null && !customer.getEmail().trim().isEmpty() && !customer.getEmail().contains("@")) {
            throw new IllegalArgumentException("Invalid email format");
        }

        if (customer.getUnitsConsumed() < 0) {
            throw new IllegalArgumentException("Units consumed cannot be negative");
        }
    }
}