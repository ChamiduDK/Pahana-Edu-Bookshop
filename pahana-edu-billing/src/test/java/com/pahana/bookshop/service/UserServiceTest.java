package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.UserDAO;
import com.pahana.bookshop.model.User;
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
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserServiceTest {
    @Mock
    private UserDAO userDAO;

    @InjectMocks
    private UserService userService;

    private User testUser;
    private User adminUser;

    @BeforeEach
    void setUp() {
        // Initialize test data
        testUser = new User();
        testUser.setId(1);
        testUser.setUsername("johndoe");
        testUser.setPassword("password123");
        testUser.setEmail("john@example.com");
        testUser.setRole("STAFF");

        adminUser = new User();
        adminUser.setId(2);
        adminUser.setUsername("admin");
        adminUser.setPassword("adminpass");
        adminUser.setEmail("admin@example.com");
        adminUser.setRole("ADMIN");
    }

    @Test
    void testCreateUserSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful user creation by admin
        when(userDAO.findByUsername("johndoe")).thenReturn(null);
        when(userDAO.findByEmail("john@example.com")).thenReturn(null);
        when(userDAO.create(any(User.class))).thenReturn(true);

        boolean result = userService.createUser(testUser);

        assertTrue(result, "CreateUser should return true for successful creation");
        verify(userDAO, times(1)).findByUsername("johndoe");
        verify(userDAO, times(1)).findByEmail("john@example.com");
        verify(userDAO, times(1)).create(any(User.class));
    }

    @Test
    void testCreateUserSQLException() throws SQLException {
        // Test ID: T2
        // Test: CreateUser with SQL exception
        when(userDAO.findByUsername("johndoe")).thenReturn(null);
        when(userDAO.findByEmail("john@example.com")).thenReturn(null);
        when(userDAO.create(any(User.class))).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> userService.createUser(testUser), "CreateUser should throw SQLException");
    }

    @Test
    void testCreateUserNullUser() {
        // Test ID: T3
        // Test: CreateUser with null User object
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(null), "CreateUser with null User should throw IllegalArgumentException");
    }

    @Test
    void testCreateUserInvalidUsername() {
        // Test ID: T4
        // Test: CreateUser with invalid username
        testUser.setUsername(""); // Empty
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with empty username should throw IllegalArgumentException");

        testUser.setUsername("ab"); // Too short
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with short username should throw IllegalArgumentException");

        testUser.setUsername("user@name"); // Invalid format
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with invalid username format should throw IllegalArgumentException");
    }

    @Test
    void testCreateUserInvalidEmail() {
        // Test ID: T5
        // Test: CreateUser with invalid email
        testUser.setEmail(""); // Empty
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with empty email should throw IllegalArgumentException");

        testUser.setEmail("invalid-email"); // Invalid format
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with invalid email format should throw IllegalArgumentException");
    }

    @Test
    void testCreateUserInvalidPassword() {
        // Test ID: T6
        // Test: CreateUser with invalid password
        testUser.setPassword(""); // Empty
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with empty password should throw IllegalArgumentException");

        testUser.setPassword("pass"); // Too short
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with short password should throw IllegalArgumentException");
    }

    @Test
    void testCreateUserInvalidRole() {
        // Test ID: T7
        // Test: CreateUser with invalid role
        testUser.setRole("USER"); // Invalid role
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with invalid role should throw IllegalArgumentException");
    }

    @Test
    void testCreateUserUsernameExists() throws SQLException {
        // Test ID: T8
        // Test: CreateUser with existing username
        when(userDAO.findByUsername("johndoe")).thenReturn(new User());

        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with existing username should throw IllegalArgumentException");
    }

    @Test
    void testCreateUserEmailExists() throws SQLException {
        // Test ID: T9
        // Test: CreateUser with existing email
        when(userDAO.findByUsername("johndoe")).thenReturn(null);
        when(userDAO.findByEmail("john@example.com")).thenReturn(new User());

        assertThrows(IllegalArgumentException.class, () -> userService.createUser(testUser), "CreateUser with existing email should throw IllegalArgumentException");
    }

    @Test
    void testGetUserByIdSuccess() throws SQLException {
        // Test ID: T10
        // Test: Retrieving a user by valid ID
        when(userDAO.findById(1)).thenReturn(testUser);

        User result = userService.getUserById(1);

        assertNotNull(result, "GetUserById should return a User");
        assertEquals(testUser, result, "Returned User should match expected");
        verify(userDAO, times(1)).findById(1);
    }

    @Test
    void testGetUserByIdSQLException() throws SQLException {
        // Test ID: T11
        // Test: GetUserById with SQL exception
        when(userDAO.findById(1)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> userService.getUserById(1), "GetUserById should throw SQLException");
    }

    @Test
    void testGetAllUsersSuccess() throws SQLException {
        // Test ID: T12
        // Test: Retrieving all users
        List<User> users = new ArrayList<>();
        users.add(testUser);
        when(userDAO.findAll()).thenReturn(users);

        List<User> result = userService.getAllUsers();

        assertEquals(1, result.size(), "GetAllUsers should return one user");
        assertEquals(testUser, result.get(0), "Returned User should match expected");
        verify(userDAO, times(1)).findAll();
    }

    @Test
    void testGetAllUsersEmpty() throws SQLException {
        // Test ID: T13
        // Test: GetAllUsers with no users
        when(userDAO.findAll()).thenReturn(new ArrayList<>());

        List<User> result = userService.getAllUsers();

        assertTrue(result.isEmpty(), "GetAllUsers should return empty list when no users exist");
        verify(userDAO, times(1)).findAll();
    }

    @Test
    void testGetAllUsersSQLException() throws SQLException {
        // Test ID: T14
        // Test: GetAllUsers with SQL exception
        when(userDAO.findAll()).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> userService.getAllUsers(), "GetAllUsers should throw SQLException");
    }

    @Test
    void testUpdateUserSuccess() throws SQLException {
        // Test ID: T15
        // Test: Updating a user’s details by admin
        when(userDAO.findByUsername("johndoe")).thenReturn(testUser);
        when(userDAO.findByEmail("john@example.com")).thenReturn(testUser);
        when(userDAO.update(testUser)).thenReturn(true);

        boolean result = userService.updateUser(testUser, adminUser);

        assertTrue(result, "UpdateUser should return true for successful update");
        verify(userDAO, times(1)).findByUsername("johndoe");
        verify(userDAO, times(1)).findByEmail("john@example.com");
        verify(userDAO, times(1)).update(testUser);
    }

    @Test
    void testUpdateUserSQLException() throws SQLException {
        // Test ID: T16
        // Test: UpdateUser with SQL exception
        when(userDAO.findByUsername("johndoe")).thenReturn(testUser);
        when(userDAO.findByEmail("john@example.com")).thenReturn(testUser);
        when(userDAO.update(testUser)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> userService.updateUser(testUser, adminUser), "UpdateUser should throw SQLException");
    }

    @Test
    void testUpdateUserNullUser() {
        // Test ID: T17
        // Test: UpdateUser with null User object
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(null, adminUser), "UpdateUser with null User should throw IllegalArgumentException");
    }

    @Test
    void testUpdateUserInvalidData() {
        // Test ID: T18
        // Test: UpdateUser with invalid data
        testUser.setUsername(""); // Empty
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(testUser, adminUser), "UpdateUser with empty username should throw IllegalArgumentException");

        testUser.setUsername("johndoe");
        testUser.setEmail("invalid-email"); // Invalid format
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(testUser, adminUser), "UpdateUser with invalid email should throw IllegalArgumentException");

        testUser.setEmail("john@example.com");
        testUser.setRole("USER"); // Invalid role
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(testUser, adminUser), "UpdateUser with invalid role should throw IllegalArgumentException");
    }

    @Test
    void testUpdateUserNonAdmin() {
        // Test ID: T19
        // Test: UpdateUser by non-admin user
        User nonAdmin = new User();
        nonAdmin.setRole("STAFF");

        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(testUser, nonAdmin), "UpdateUser by non-admin should throw IllegalArgumentException");
    }

    @Test
    void testUpdateUserUsernameExists() throws SQLException {
        // Test ID: T20
        // Test: UpdateUser with existing username (different user)
        User otherUser = new User();
        otherUser.setId(3);
        otherUser.setUsername("johndoe");
        when(userDAO.findByUsername("johndoe")).thenReturn(otherUser);

        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(testUser, adminUser), "UpdateUser with existing username should throw IllegalArgumentException");
    }

    @Test
    void testUpdateUserEmailExists() throws SQLException {
        // Test ID: T21
        // Test: UpdateUser with existing email (different user)
        User otherUser = new User();
        otherUser.setId(3);
        otherUser.setEmail("john@example.com");
        when(userDAO.findByUsername("johndoe")).thenReturn(testUser);
        when(userDAO.findByEmail("john@example.com")).thenReturn(otherUser);

        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(testUser, adminUser), "UpdateUser with existing email should throw IllegalArgumentException");
    }

    @Test
    void testDeleteUserSuccess() throws SQLException {
        // Test ID: T22
        // Test: Deleting a non-admin user by admin
        when(userDAO.findById(1)).thenReturn(testUser);
        when(userDAO.delete(1)).thenReturn(true);

        boolean result = userService.deleteUser(1, adminUser);

        assertTrue(result, "DeleteUser should return true for successful deletion");
        verify(userDAO, times(1)).findById(1);
        verify(userDAO, times(1)).delete(1);
    }

    @Test
    void testDeleteUserSQLException() throws SQLException {
        // Test ID: T23
        // Test: DeleteUser with SQL exception
        when(userDAO.findById(1)).thenReturn(testUser);
        when(userDAO.delete(1)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> userService.deleteUser(1, adminUser), "DeleteUser should throw SQLException");
    }

    @Test
    void testDeleteUserNonAdmin() {
        // Test ID: T24
        // Test: DeleteUser by non-admin user
        User nonAdmin = new User();
        nonAdmin.setRole("STAFF");

        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(1, nonAdmin), "DeleteUser by non-admin should throw IllegalArgumentException");
    }

    @Test
    void testDeleteUserNotFound() throws SQLException {
        // Test ID: T25
        // Test: DeleteUser with non-existent user ID
        when(userDAO.findById(999)).thenReturn(null);

        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(999, adminUser), "DeleteUser with non-existent ID should throw IllegalArgumentException");
    }

    @Test
    void testDeleteUserAdminAccount() throws SQLException {
        // Test ID: T26
        // Test: DeleteUser for admin account
        User adminToDelete = new User();
        adminToDelete.setId(3);
        adminToDelete.setRole("ADMIN");
        when(userDAO.findById(3)).thenReturn(adminToDelete);

        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(3, adminUser), "DeleteUser for admin account should throw IllegalArgumentException");
    }

    @Test
    void testDeleteUserSelf() throws SQLException {
        // Test ID: T27
        // Test: DeleteUser for own account
        when(userDAO.findById(2)).thenReturn(adminUser);

        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(2, adminUser), "DeleteUser for own account should throw IllegalArgumentException");
    }
}