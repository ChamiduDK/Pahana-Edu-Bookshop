package com.pahana.bookshop.model;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.sql.Timestamp;

class UserTest {

    @Test
    void testConstructorAndGetters() {
        User user = new User("john", "secret", "john@example.com", "ADMIN");

        assertEquals("john", user.getUsername());
        assertEquals("secret", user.getPassword());
        assertEquals("john@example.com", user.getEmail());
        assertEquals("ADMIN", user.getRole());
    }

    @Test
    void testIsAdminAndIsStaff() {
        User admin = new User("admin", "pass", "admin@example.com", "ADMIN");
        User staff = new User("staff", "pass", "staff@example.com", "STAFF");

        assertTrue(admin.isAdmin());
        assertFalse(admin.isStaff());

        assertTrue(staff.isStaff());
        assertFalse(staff.isAdmin());
    }

    @Test
    void testSettersAndTimestamps() {
        User user = new User();
        user.setId(1);
        user.setUsername("jane");
        user.setEmail("jane@example.com");
        user.setRole("STAFF");

        Timestamp now = new Timestamp(System.currentTimeMillis());
        user.setCreatedAt(now);
        user.setUpdatedAt(now);

        assertEquals(1, user.getId());
        assertEquals("jane", user.getUsername());
        assertEquals("jane@example.com", user.getEmail());
        assertEquals("STAFF", user.getRole());
        assertEquals(now, user.getCreatedAt());
        assertEquals(now, user.getUpdatedAt());
    }

    @Test
    void testToString() {
        User user = new User("john", "secret", "john@example.com", "ADMIN");
        user.setId(10);

        String result = user.toString();

        assertTrue(result.contains("id=10"));
        assertTrue(result.contains("username='john'"));
        assertTrue(result.contains("email='john@example.com'"));
        assertTrue(result.contains("role='ADMIN'"));
    }
}
