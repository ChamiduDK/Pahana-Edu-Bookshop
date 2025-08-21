package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.CustomerDAO;
import com.pahana.bookshop.model.Customer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CustomerServiceTest {
    @Mock
    private CustomerDAO customerDAO;

    @InjectMocks
    private CustomerService customerService;

    private Customer testCustomer;

    @BeforeEach
    void setUp() {
        // Initialize a test Customer instance
        testCustomer = new Customer("ACC001", "John Doe", "123 Main St", "0771234567", "john@example.com");
        testCustomer.setId(1);
        testCustomer.setUnitsConsumed(100);
    }

    @Test
    void testAddCustomerSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful customer creation
        when(customerDAO.create(testCustomer)).thenReturn(true);

        boolean result = customerService.addCustomer(testCustomer);

        assertTrue(result, "AddCustomer should return true for successful insertion");
        assertEquals("0771234567", testCustomer.getTelephone(), "Telephone should be normalized");
        verify(customerDAO, times(1)).create(testCustomer);
    }

    @Test
    void testAddCustomerSQLException() throws SQLException {
        // Test ID: T2
        // Test: AddCustomer with SQL exception
        when(customerDAO.create(testCustomer)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer should throw SQLException");
    }

    @Test
    void testAddCustomerNullCustomer() {
        // Test ID: T3
        // Test: AddCustomer with null Customer object
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(null), "AddCustomer with null Customer should throw IllegalArgumentException");
    }

    @Test
    void testAddCustomerInvalidName() {
        // Test ID: T4
        // Test: AddCustomer with invalid (null/empty) name
        testCustomer.setName("");
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with empty name should throw IllegalArgumentException");

        testCustomer.setName(null);
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with null name should throw IllegalArgumentException");
    }

    @Test
    void testAddCustomerInvalidAddress() {
        // Test ID: T5
        // Test: AddCustomer with invalid (null/empty) address
        testCustomer.setAddress("");
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with empty address should throw IllegalArgumentException");

        testCustomer.setAddress(null);
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with null address should throw IllegalArgumentException");
    }

    @Test
    void testAddCustomerInvalidTelephone() {
        // Test ID: T6
        // Test: AddCustomer with invalid telephone format
        testCustomer.setTelephone("12345"); // Invalid format
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with invalid telephone should throw IllegalArgumentException");

        testCustomer.setTelephone(""); // Empty
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with empty telephone should throw IllegalArgumentException");
    }

    @Test
    void testAddCustomerInvalidEmail() {
        // Test ID: T7
        // Test: AddCustomer with invalid email format
        testCustomer.setEmail("invalid-email"); // No @
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with invalid email should throw IllegalArgumentException");
    }

    @Test
    void testAddCustomerNegativeUnits() {
        // Test ID: T8
        // Test: AddCustomer with negative units consumed
        testCustomer.setUnitsConsumed(-1);
        assertThrows(IllegalArgumentException.class, () -> customerService.addCustomer(testCustomer), "AddCustomer with negative units consumed should throw IllegalArgumentException");
    }

    @Test
    void testGetCustomerByIdSuccess() throws SQLException {
        // Test ID: T9
        // Test: Retrieving a customer by valid ID
        when(customerDAO.findById(1)).thenReturn(testCustomer);

        Customer result = customerService.getCustomerById(1);

        assertNotNull(result, "GetCustomerById should return a Customer");
        assertEquals(testCustomer, result, "Returned Customer should match expected");
        verify(customerDAO, times(1)).findById(1);
    }

    @Test
    void testGetCustomerByIdSQLException() throws SQLException {
        // Test ID: T10
        // Test: GetCustomerById with SQL exception
        when(customerDAO.findById(1)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> customerService.getCustomerById(1), "GetCustomerById should throw SQLException");
    }

    @Test
    void testGetAllCustomersSuccess() throws SQLException {
        // Test ID: T11
        // Test: Retrieving all customers
        List<Customer> customers = new ArrayList<>();
        customers.add(testCustomer);
        when(customerDAO.findAll()).thenReturn(customers);

        List<Customer> result = customerService.getAllCustomers();

        assertEquals(1, result.size(), "GetAllCustomers should return one customer");
        assertEquals(testCustomer, result.get(0), "Returned Customer should match expected");
        verify(customerDAO, times(1)).findAll();
    }

    @Test
    void testGetAllCustomersEmpty() throws SQLException {
        // Test ID: T12
        // Test: GetAllCustomers with no customers
        when(customerDAO.findAll()).thenReturn(new ArrayList<>());

        List<Customer> result = customerService.getAllCustomers();

        assertTrue(result.isEmpty(), "GetAllCustomers should return empty list when no customers exist");
        verify(customerDAO, times(1)).findAll();
    }

    @Test
    void testGetAllCustomersSQLException() throws SQLException {
        // Test ID: T13
        // Test: GetAllCustomers with SQL exception
        when(customerDAO.findAll()).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> customerService.getAllCustomers(), "GetAllCustomers should throw SQLException");
    }

    @Test
    void testUpdateCustomerSuccess() throws SQLException {
        // Test ID: T14
        // Test: Updating a customer’s details
        when(customerDAO.update(testCustomer)).thenReturn(true);

        boolean result = customerService.updateCustomer(testCustomer);

        assertTrue(result, "UpdateCustomer should return true for successful update");
        assertEquals("0771234567", testCustomer.getTelephone(), "Telephone should be normalized");
        verify(customerDAO, times(1)).update(testCustomer);
    }

    @Test
    void testUpdateCustomerSQLException() throws SQLException {
        // Test ID: T15
        // Test: UpdateCustomer with SQL exception
        when(customerDAO.update(testCustomer)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> customerService.updateCustomer(testCustomer), "UpdateCustomer should throw SQLException");
    }

    @Test
    void testUpdateCustomerNullCustomer() {
        // Test ID: T16
        // Test: UpdateCustomer with null Customer object
        assertThrows(IllegalArgumentException.class, () -> customerService.updateCustomer(null), "UpdateCustomer with null Customer should throw IllegalArgumentException");
    }

    @Test
    void testUpdateCustomerInvalidData() {
        // Test ID: T17
        // Test: UpdateCustomer with invalid data (e.g., empty name)
        testCustomer.setName("");
        assertThrows(IllegalArgumentException.class, () -> customerService.updateCustomer(testCustomer), "UpdateCustomer with empty name should throw IllegalArgumentException");

        testCustomer.setName("John Doe");
        testCustomer.setTelephone("12345"); // Invalid format
        assertThrows(IllegalArgumentException.class, () -> customerService.updateCustomer(testCustomer), "UpdateCustomer with invalid telephone should throw IllegalArgumentException");
    }

    @Test
    void testDeleteCustomerSuccess() throws SQLException {
        // Test ID: T18
        // Test: Deleting a customer by ID
        when(customerDAO.delete(1)).thenReturn(true);

        boolean result = customerService.deleteCustomer(1);

        assertTrue(result, "DeleteCustomer should return true for successful deletion");
        verify(customerDAO, times(1)).delete(1);
    }

    @Test
    void testDeleteCustomerSQLException() throws SQLException {
        // Test ID: T19
        // Test: DeleteCustomer with SQL exception
        when(customerDAO.delete(1)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> customerService.deleteCustomer(1), "DeleteCustomer should throw SQLException");
    }
}