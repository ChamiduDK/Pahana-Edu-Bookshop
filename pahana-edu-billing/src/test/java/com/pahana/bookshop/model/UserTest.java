package com.pahana.bookshop.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Timestamp;
import java.time.Instant;

import static org.junit.jupiter.api.Assertions.*;

public class UserTest {
    private User user;
    private static final String USERNAME = "john";
    private static final String PASSWORD = "secret";
    private static final String EMAIL = "john@example.com";
    private static final String ROLE = "ADMIN";

    @BeforeEach
    void setUp() {
        // Initialize a User instance before each test with valid data
        user = new User(USERNAME, PASSWORD, EMAIL, ROLE);
    }

    @Test
    void testDefaultConstructor() {
        // Test: Verify default constructor initializes fields to null or zero
        User emptyUser = new User();
        assertEquals(0, emptyUser.getId(), "ID should be 0");
        assertNull(emptyUser.getUsername(), "Username should be null");
        assertNull(emptyUser.getPassword(), "Password should be null");
        assertNull(emptyUser.getEmail(), "Email should be null");
        assertNull(emptyUser.getRole(), "Role should be null");
        assertNull(emptyUser.getCreatedAt(), "CreatedAt should be null");
        assertNull(emptyUser.getUpdatedAt(), "UpdatedAt should be null");
    }

    @Test
    void testParameterizedConstructor() {
        // Test: Verify parameterized constructor sets fields correctly
        assertEquals(USERNAME, user.getUsername(), "Username should match input");
        assertEquals(PASSWORD, user.getPassword(), "Password should match input");
        assertEquals(EMAIL, user.getEmail(), "Email should match input");
        assertEquals(ROLE, user.getRole(), "Role should match input");
    }

    @Test
    void testSettersAndGetters() {
        // Test: Verify setters and getters for all fields
        User newUser = new User();
        newUser.setId(1);
        newUser.setUsername("jane");
        newUser.setPassword("newpass");
        newUser.setEmail("jane@example.com");
        newUser.setRole("STAFF");
        Timestamp now = Timestamp.from(Instant.now());
        newUser.setCreatedAt(now);
        newUser.setUpdatedAt(now);

        assertEquals(1, newUser.getId(), "ID should be 1");
        assertEquals("jane", newUser.getUsername(), "Username should be updated");
        assertEquals("newpass", newUser.getPassword(), "Password should be updated");
        assertEquals("jane@example.com", newUser.getEmail(), "Email should be updated");
        assertEquals("STAFF", newUser.getRole(), "Role should be updated");
        assertEquals(now, newUser.getCreatedAt(), "CreatedAt should be updated");
        assertEquals(now, newUser.getUpdatedAt(), "UpdatedAt should be updated");
    }

    @Test
    void testIsAdminAndIsStaff() {
        // Test: Verify isAdmin and isStaff for ADMIN and STAFF roles
        User admin = new User("admin", "pass", "admin@example.com", "ADMIN");
        User staff = new User("staff", "pass", "staff@example.com", "STAFF");

        assertTrue(admin.isAdmin(), "User with ADMIN role should be admin");
        assertFalse(admin.isStaff(), "User with ADMIN role should not be staff");

        assertTrue(staff.isStaff(), "User with STAFF role should be staff");
        assertFalse(staff.isAdmin(), "User with STAFF role should not be admin");
    }

    @Test
    void testToString() {
        // Test: Verify toString format
        user.setId(10);
        String result = user.toString();
        assertTrue(result.contains("id=10"), "toString should contain ID");
        assertTrue(result.contains("username='john'"), "toString should contain username");
        assertTrue(result.contains("email='john@example.com'"), "toString should contain email");
        assertTrue(result.contains("role='ADMIN'"), "toString should contain role");
    }

    @Test
    void testNullValues() {
        // Test: Verify handling of null values in parameterized constructor
        User nullUser = new User(null, null, null, null);
        assertNull(nullUser.getUsername(), "Username should be null");
        assertNull(nullUser.getPassword(), "Password should be null");
        assertNull(nullUser.getEmail(), "Email should be null");
        assertNull(nullUser.getRole(), "Role should be null");
    }

    @Test
    void testEdgeCaseEmptyStrings() {
        // Test: Verify handling of empty strings
        User emptyStringUser = new User("", "", "", "");
        assertEquals("", emptyStringUser.getUsername(), "Username should be empty string");
        assertEquals("", emptyStringUser.getPassword(), "Password should be empty string");
        assertEquals("", emptyStringUser.getEmail(), "Email should be empty string");
        assertEquals("", emptyStringUser.getRole(), "Role should be empty string");
    }

    @Test
    void testRoleCaseInsensitivity() {
        // Test: Verify isAdmin and isStaff are case-insensitive
        User adminLower = new User("admin", "pass", "admin@example.com", "admin");
        User adminMixed = new User("admin", "pass", "admin@example.com", "Admin");
        User staffLower = new User("staff", "pass", "staff@example.com", "staff");
        User staffMixed = new User("staff", "pass", "staff@example.com", "Staff");

        assertTrue(adminLower.isAdmin(), "Lowercase 'admin' role should be recognized as admin");
        assertTrue(adminMixed.isAdmin(), "Mixed case 'Admin' role should be recognized as admin");
        assertTrue(staffLower.isStaff(), "Lowercase 'staff' role should be recognized as staff");
        assertTrue(staffMixed.isStaff(), "Mixed case 'Staff' role should be recognized as staff");
    }

    @Test
    void testInvalidRole() {
        // Test: Verify isAdmin and isStaff for non-ADMIN/STAFF role
        User user = new User("user", "pass", "user@example.com", "USER");
        assertFalse(user.isAdmin(), "Non-ADMIN role should not be admin");
        assertFalse(user.isStaff(), "Non-STAFF role should not be staff");
    }

    @Test
    void testNullRole() {
        // Test: Verify isAdmin and isStaff when role is null
        User user = new User("user", "pass", "user@example.com", null);
        assertFalse(user.isAdmin(), "Null role should not be admin");
        assertFalse(user.isStaff(), "Null role should not be staff");
    }
}