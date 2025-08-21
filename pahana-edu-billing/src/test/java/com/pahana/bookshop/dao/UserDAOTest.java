package com.pahana.bookshop.dao;

import com.pahana.bookshop.config.DatabaseConnection;
import com.pahana.bookshop.model.User;
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
public class UserDAOTest {
    @Mock
    private DatabaseConnection dbConnection;

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private ResultSet resultSet;

    @InjectMocks
    private UserDAO userDAO;

    private User testUser;

    @BeforeEach
    void setUp() throws SQLException {
        // Initialize a test User instance
        testUser = new User();
        testUser.setId(1);
        testUser.setUsername("johndoe");
        testUser.setPassword("hashedPassword"); // Simulating hashed password
        testUser.setEmail("john@example.com");
        testUser.setRole("STAFF");

        // Mock DatabaseConnection to return mocked Connection
        when(dbConnection.getConnection()).thenReturn(connection);
    }

    @Test
    void testCreateSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful user creation
        when(connection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);
        when(preparedStatement.getGeneratedKeys()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt(1)).thenReturn(1);

        boolean result = userDAO.create(testUser);

        assertTrue(result, "Create should return true for successful insertion");
        assertEquals(1, testUser.getId(), "User ID should be set from generated keys");
        verify(preparedStatement, times(1)).setString(1, testUser.getUsername());
        verify(preparedStatement, times(1)).setString(2, testUser.getPassword());
        verify(preparedStatement, times(1)).setString(3, testUser.getEmail());
        verify(preparedStatement, times(1)).setString(4, testUser.getRole());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testCreateSQLException() throws SQLException {
        // Test ID: T2
        // Test: Create with SQL exception
        when(connection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> userDAO.create(testUser), "Create should throw SQLException");
    }

    @Test
    void testCreateNullUser() throws SQLException {
        // Test ID: T3
        // Test: Create with null User object
        assertThrows(NullPointerException.class, () -> userDAO.create(null), "Create with null User should throw NullPointerException");
    }

    @Test
    void testFindByIdSuccess() throws SQLException {
        // Test ID: T4
        // Test: Finding a user by valid ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt("id")).thenReturn(1);
        when(resultSet.getString("username")).thenReturn(testUser.getUsername());
        when(resultSet.getString("password")).thenReturn(testUser.getPassword());
        when(resultSet.getString("email")).thenReturn(testUser.getEmail());
        when(resultSet.getString("role")).thenReturn(testUser.getRole());
        when(resultSet.getTimestamp("created_at")).thenReturn(testUser.getCreatedAt());
        when(resultSet.getTimestamp("updated_at")).thenReturn(testUser.getUpdatedAt());

        User result = userDAO.findById(1);

        assertNotNull(result, "User should be found");
        assertEquals(testUser.getId(), result.getId(), "User ID should match");
        assertEquals(testUser.getUsername(), result.getUsername(), "User username should match");
        verify(preparedStatement, times(1)).setInt(1, 1);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdNotFound() throws SQLException {
        // Test ID: T5
        // Test: Finding a user by non-existent ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        User result = userDAO.findById(999);

        assertNull(result, "Non-existent user should return null");
        verify(preparedStatement, times(1)).setInt(1, 999);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdSQLException() throws SQLException {
        // Test ID: T6
        // Test: FindById with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> userDAO.findById(1), "FindById should throw SQLException");
    }

    @Test
    void testFindAllSuccess() throws SQLException {
        // Test ID: T7
        // Test: Retrieving all users
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false); // Two users
        when(resultSet.getInt("id")).thenReturn(1, 2);
        when(resultSet.getString("username")).thenReturn("johndoe", "janedoe");
        when(resultSet.getString("role")).thenReturn("STAFF", "STAFF");

        List<User> users = userDAO.findAll();

        assertEquals(2, users.size(), "Should return two users");
        assertEquals(1, users.get(0).getId(), "First user ID should be 1");
        assertEquals("johndoe", users.get(0).getUsername(), "First user username should be johndoe");
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindAllEmpty() throws SQLException {
        // Test ID: T8
        // Test: FindAll with no users
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        List<User> users = userDAO.findAll();

        assertTrue(users.isEmpty(), "Should return empty list when no users exist");
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindAllSQLException() throws SQLException {
        // Test ID: T9
        // Test: FindAll with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> userDAO.findAll(), "FindAll should throw SQLException");
    }

    @Test
    void testUpdateSuccess() throws SQLException {
        // Test ID: T10
        // Test: Updating a user’s details
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = userDAO.update(testUser);

        assertTrue(result, "Update should return true for successful update");
        verify(preparedStatement, times(1)).setString(1, testUser.getUsername());
        verify(preparedStatement, times(1)).setString(2, testUser.getEmail());
        verify(preparedStatement, times(1)).setString(3, testUser.getRole());
        verify(preparedStatement, times(1)).setInt(4, testUser.getId());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testUpdateSQLException() throws SQLException {
        // Test ID: T11
        // Test: Update with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> userDAO.update(testUser), "Update should throw SQLException");
    }

    @Test
    void testUpdateNullUser() throws SQLException {
        // Test ID: T12
        // Test: Update with null User object
        assertThrows(NullPointerException.class, () -> userDAO.update(null), "Update with null User should throw NullPointerException");
    }

    @Test
    void testDeleteSuccess() throws SQLException {
        // Test ID: T13
        // Test: Deleting a non-admin user by ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = userDAO.delete(1);

        assertTrue(result, "Delete should return true for successful deletion");
        verify(preparedStatement, times(1)).setInt(1, 1);
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testDeleteSQLException() throws SQLException {
        // Test ID: T14
        // Test: Delete with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> userDAO.delete(1), "Delete should throw SQLException");
    }
}