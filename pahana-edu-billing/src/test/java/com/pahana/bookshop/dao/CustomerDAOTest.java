package com.pahana.bookshop.dao;

import com.pahana.bookshop.config.DatabaseConnection;
import com.pahana.bookshop.model.Customer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.sql.*;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CustomerDAOTest {
    @Mock
    private DatabaseConnection dbConnection;

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private Statement statement;

    @Mock
    private ResultSet resultSet;

    @InjectMocks
    private CustomerDAO customerDAO;

    private Customer testCustomer;

    @BeforeEach
    void setUp() throws SQLException {
        // Initialize a test Customer instance
        testCustomer = new Customer("ACC001", "John Doe", "123 Main St", "555-0123", "john@example.com");
        testCustomer.setId(1);
        testCustomer.setUnitsConsumed(100);

        // Mock DatabaseConnection to return mocked Connection
        when(dbConnection.getConnection()).thenReturn(connection);
    }

    @Test
    void testCreateSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful customer creation
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = customerDAO.create(testCustomer);

        assertTrue(result, "Create should return true for successful insertion");
        verify(preparedStatement, times(1)).setString(1, testCustomer.getAccountNumber());
        verify(preparedStatement, times(1)).setString(2, testCustomer.getName());
        verify(preparedStatement, times(1)).setString(3, testCustomer.getAddress());
        verify(preparedStatement, times(1)).setString(4, testCustomer.getTelephone());
        verify(preparedStatement, times(1)).setString(5, testCustomer.getEmail());
        verify(preparedStatement, times(1)).setInt(6, testCustomer.getUnitsConsumed());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testCreateSQLException() throws SQLException {
        // Test ID: T2
        // Test: Create with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> customerDAO.create(testCustomer), "Create should throw SQLException");
    }

    @Test
    void testCreateNullCustomer() throws SQLException {
        // Test ID: T3
        // Test: Create with null Customer object
        assertThrows(NullPointerException.class, () -> customerDAO.create(null), "Create with null Customer should throw NullPointerException");
    }

    @Test
    void testFindByIdSuccess() throws SQLException {
        // Test ID: T4
        // Test: Finding a customer by valid ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt("id")).thenReturn(1);
        when(resultSet.getString("account_number")).thenReturn(testCustomer.getAccountNumber());
        when(resultSet.getString("name")).thenReturn(testCustomer.getName());
        when(resultSet.getString("address")).thenReturn(testCustomer.getAddress());
        when(resultSet.getString("telephone")).thenReturn(testCustomer.getTelephone());
        when(resultSet.getString("email")).thenReturn(testCustomer.getEmail());
        when(resultSet.getInt("units_consumed")).thenReturn(testCustomer.getUnitsConsumed());
        when(resultSet.getTimestamp("created_at")).thenReturn(testCustomer.getCreatedAt());
        when(resultSet.getTimestamp("updated_at")).thenReturn(testCustomer.getUpdatedAt());

        Customer result = customerDAO.findById(1);

        assertNotNull(result, "Customer should be found");
        assertEquals(testCustomer.getId(), result.getId(), "Customer ID should match");
        assertEquals(testCustomer.getAccountNumber(), result.getAccountNumber(), "Customer account number should match");
        verify(preparedStatement, times(1)).setInt(1, 1);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdNotFound() throws SQLException {
        // Test ID: T5
        // Test: Finding a customer by non-existent ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        Customer result = customerDAO.findById(999);

        assertNull(result, "Non-existent customer should return null");
        verify(preparedStatement, times(1)).setInt(1, 999);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdSQLException() throws SQLException {
        // Test ID: T6
        // Test: FindById with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> customerDAO.findById(1), "FindById should throw SQLException");
    }

    @Test
    void testFindAllSuccess() throws SQLException {
        // Test ID: T7
        // Test: Retrieving all customers
        when(connection.createStatement()).thenReturn(statement);
        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false); // Two customers
        when(resultSet.getInt("id")).thenReturn(1, 2);
        when(resultSet.getString("account_number")).thenReturn("ACC001", "ACC002");
        when(resultSet.getString("name")).thenReturn("John Doe", "Jane Doe");

        List<Customer> customers = customerDAO.findAll();

        assertEquals(2, customers.size(), "Should return two customers");
        assertEquals(1, customers.get(0).getId(), "First customer ID should be 1");
        assertEquals("ACC001", customers.get(0).getAccountNumber(), "First customer account number should be ACC001");
        verify(statement, times(1)).executeQuery(anyString());
    }

    @Test
    void testFindAllEmpty() throws SQLException {
        // Test ID: T8
        // Test: FindAll with no customers
        when(connection.createStatement()).thenReturn(statement);
        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        List<Customer> customers = customerDAO.findAll();

        assertTrue(customers.isEmpty(), "Should return empty list when no customers exist");
        verify(statement, times(1)).executeQuery(anyString());
    }

    @Test
    void testFindAllSQLException() throws SQLException {
        // Test ID: T9
        // Test: FindAll with SQL exception
        when(connection.createStatement()).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> customerDAO.findAll(), "FindAll should throw SQLException");
    }

    @Test
    void testUpdateSuccess() throws SQLException {
        // Test ID: T10
        // Test: Updating a customer’s details
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = customerDAO.update(testCustomer);

        assertTrue(result, "Update should return true for successful update");
        verify(preparedStatement, times(1)).setString(1, testCustomer.getName());
        verify(preparedStatement, times(1)).setString(2, testCustomer.getAddress());
        verify(preparedStatement, times(1)).setString(3, testCustomer.getTelephone());
        verify(preparedStatement, times(1)).setString(4, testCustomer.getEmail());
        verify(preparedStatement, times(1)).setInt(5, testCustomer.getUnitsConsumed());
        verify(preparedStatement, times(1)).setInt(6, testCustomer.getId());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testUpdateSQLException() throws SQLException {
        // Test ID: T11
        // Test: Update with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> customerDAO.update(testCustomer), "Update should throw SQLException");
    }

    @Test
    void testUpdateNullCustomer() throws SQLException {
        // Test ID: T12
        // Test: Update with null Customer object
        assertThrows(NullPointerException.class, () -> customerDAO.update(null), "Update with null Customer should throw NullPointerException");
    }

    @Test
    void testDeleteSuccess() throws SQLException {
        // Test ID: T13
        // Test: Deleting a customer by ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = customerDAO.delete(1);

        assertTrue(result, "Delete should return true for successful deletion");
        verify(preparedStatement, times(1)).setInt(1, 1);
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testDeleteSQLException() throws SQLException {
        // Test ID: T14
        // Test: Delete with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> customerDAO.delete(1), "Delete should throw SQLException");
    }
}