package com.pahana.bookshop.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Timestamp;
import java.time.Instant;

import static org.junit.jupiter.api.Assertions.*;

public class CustomerTest {
    private Customer customer;
    private static final String ACCOUNT_NUMBER = "ACC123";
    private static final String NAME = "John Doe";
    private static final String ADDRESS = "123 Main St";
    private static final String TELEPHONE = "555-0123";
    private static final String EMAIL = "john@example.com";

    @BeforeEach
    void setUp() {
        // Initialize a Customer instance before each test with valid data
        customer = new Customer(1, ACCOUNT_NUMBER, NAME, ADDRESS, TELEPHONE, EMAIL);
    }

    @Test
    void testDefaultConstructor() {
        // Test: Verify default constructor initializes fields to null or zero
        Customer emptyCustomer = new Customer();
        assertEquals(0, emptyCustomer.getId(), "ID should be 0");
        assertNull(emptyCustomer.getAccountNumber(), "AccountNumber should be null");
        assertNull(emptyCustomer.getName(), "Name should be null");
        assertNull(emptyCustomer.getAddress(), "Address should be null");
        assertNull(emptyCustomer.getTelephone(), "Telephone should be null");
        assertNull(emptyCustomer.getEmail(), "Email should be null");
        assertEquals(0, emptyCustomer.getUnitsConsumed(), "UnitsConsumed should be 0");
        assertNull(emptyCustomer.getCreatedAt(), "CreatedAt should be null");
        assertNull(emptyCustomer.getUpdatedAt(), "UpdatedAt should be null");
    }

    @Test
    void testParameterizedConstructorWithoutId() {
        // Test: Verify parameterized constructor without ID sets fields correctly
        Customer newCustomer = new Customer(ACCOUNT_NUMBER, NAME, ADDRESS, TELEPHONE, EMAIL);
        assertEquals(0, newCustomer.getId(), "ID should be 0");
        assertEquals(ACCOUNT_NUMBER, newCustomer.getAccountNumber(), "AccountNumber should match input");
        assertEquals(NAME, newCustomer.getName(), "Name should match input");
        assertEquals(ADDRESS, newCustomer.getAddress(), "Address should match input");
        assertEquals(TELEPHONE, newCustomer.getTelephone(), "Telephone should match input");
        assertEquals(EMAIL, newCustomer.getEmail(), "Email should match input");
        assertEquals(0, newCustomer.getUnitsConsumed(), "UnitsConsumed should be 0");
    }

    @Test
    void testParameterizedConstructorWithId() {
        // Test: Verify parameterized constructor with ID sets fields correctly
        assertEquals(1, customer.getId(), "ID should match input");
        assertEquals(ACCOUNT_NUMBER, customer.getAccountNumber(), "AccountNumber should match input");
        assertEquals(NAME, customer.getName(), "Name should match input");
        assertEquals(ADDRESS, customer.getAddress(), "Address should match input");
        assertEquals(TELEPHONE, customer.getTelephone(), "Telephone should match input");
        assertEquals(EMAIL, customer.getEmail(), "Email should match input");
        assertEquals(0, customer.getUnitsConsumed(), "UnitsConsumed should be 0");
    }

    @Test
    void testSettersAndGetters() {
        // Test: Verify setters and getters for all fields
        Customer newCustomer = new Customer();
        newCustomer.setId(2);
        newCustomer.setAccountNumber("ACC456");
        newCustomer.setName("Jane Doe");
        newCustomer.setAddress("456 Elm St");
        newCustomer.setTelephone("555-0456");
        newCustomer.setEmail("jane@example.com");
        newCustomer.setUnitsConsumed(100);
        Timestamp now = Timestamp.from(Instant.now());
        newCustomer.setCreatedAt(now);
        newCustomer.setUpdatedAt(now);

        assertEquals(2, newCustomer.getId(), "ID should be 2");
        assertEquals("ACC456", newCustomer.getAccountNumber(), "AccountNumber should be updated");
        assertEquals("Jane Doe", newCustomer.getName(), "Name should be updated");
        assertEquals("456 Elm St", newCustomer.getAddress(), "Address should be updated");
        assertEquals("555-0456", newCustomer.getTelephone(), "Telephone should be updated");
        assertEquals("jane@example.com", newCustomer.getEmail(), "Email should be updated");
        assertEquals(100, newCustomer.getUnitsConsumed(), "UnitsConsumed should be updated");
        assertEquals(now, newCustomer.getCreatedAt(), "CreatedAt should be updated");
        assertEquals(now, newCustomer.getUpdatedAt(), "UpdatedAt should be updated");
    }

    @Test
    void testIsValid() {
        // Test: Verify isValid for valid and invalid cases
        assertTrue(customer.isValid(), "Customer with valid ID, accountNumber, and name should be valid");

        Customer invalidId = new Customer(0, "ACC789", "Test", "123 St", "555-0789", "test@example.com");
        assertFalse(invalidId.isValid(), "Customer with ID=0 should be invalid");

        Customer nullAccount = new Customer(1, null, "Test", "123 St", "555-0789", "test@example.com");
        assertFalse(nullAccount.isValid(), "Customer with null accountNumber should be invalid");

        Customer emptyAccount = new Customer(1, "", "Test", "123 St", "555-0789", "test@example.com");
        assertFalse(emptyAccount.isValid(), "Customer with empty accountNumber should be invalid");

        Customer nullName = new Customer(1, "ACC789", null, "123 St", "555-0789", "test@example.com");
        assertFalse(nullName.isValid(), "Customer with null name should be invalid");

        Customer emptyName = new Customer(1, "ACC789", "", "123 St", "555-0789", "test@example.com");
        assertFalse(emptyName.isValid(), "Customer with empty name should be invalid");
    }

    @Test
    void testGetDisplayName() {
        // Test: Verify getDisplayName for valid and null name
        assertEquals(NAME, customer.getDisplayName(), "Display name should match name");

        Customer noName = new Customer(1, "ACC789", null, "123 St", "555-0789", "test@example.com");
        assertEquals("Unknown Customer", noName.getDisplayName(), "Null name should return 'Unknown Customer'");
    }

    @Test
    void testToString() {
        // Test: Verify toString format
        String result = customer.toString();
        assertTrue(result.contains("id=1"), "toString should contain ID");
        assertTrue(result.contains("accountNumber='ACC123'"), "toString should contain accountNumber");
        assertTrue(result.contains("name='John Doe'"), "toString should contain name");
        assertTrue(result.contains("email='john@example.com'"), "toString should contain email");
    }

    @Test
    void testEquals() {
        // Test: Verify equals method based on ID
        Customer sameId = new Customer(1, "ACC456", "Jane Doe", "456 Elm St", "555-0456", "jane@example.com");
        Customer differentId = new Customer(2, "ACC456", "Jane Doe", "456 Elm St", "555-0456", "jane@example.com");

        assertTrue(customer.equals(sameId), "Customers with same ID should be equal");
        assertFalse(customer.equals(differentId), "Customers with different IDs should not be equal");
        assertTrue(customer.equals(customer), "Customer should be equal to itself");
        assertFalse(customer.equals(null), "Customer should not be equal to null");
        assertFalse(customer.equals(new Object()), "Customer should not be equal to different class");
    }

    @Test
    void testHashCode() {
        // Test: Verify hashCode consistency for same/different IDs
        Customer sameId = new Customer(1, "ACC456", "Jane Doe", "456 Elm St", "555-0456", "jane@example.com");
        assertEquals(customer.hashCode(), sameId.hashCode(), "Customers with same ID should have same hashCode");

        Customer differentId = new Customer(2, "ACC456", "Jane Doe", "456 Elm St", "555-0456", "jane@example.com");
        assertNotEquals(customer.hashCode(), differentId.hashCode(), "Customers with different IDs should have different hashCodes");
    }

    @Test
    void testNullValues() {
        // Test: Verify handling of null values in parameterized constructor
        Customer nullCustomer = new Customer(null, null, null, null, null);
        assertEquals(0, nullCustomer.getId(), "ID should be 0");
        assertNull(nullCustomer.getAccountNumber(), "AccountNumber should be null");
        assertNull(nullCustomer.getName(), "Name should be null");
        assertNull(nullCustomer.getAddress(), "Address should be null");
        assertNull(nullCustomer.getTelephone(), "Telephone should be null");
        assertNull(nullCustomer.getEmail(), "Email should be null");
        assertEquals(0, nullCustomer.getUnitsConsumed(), "UnitsConsumed should be 0");
    }

    @Test
    void testEdgeCaseEmptyStrings() {
        // Test: Verify handling of empty strings
        Customer emptyStringCustomer = new Customer("", "", "", "", "");
        assertEquals("", emptyStringCustomer.getAccountNumber(), "AccountNumber should be empty string");
        assertEquals("", emptyStringCustomer.getName(), "Name should be empty string");
        assertEquals("", emptyStringCustomer.getAddress(), "Address should be empty string");
        assertEquals("", emptyStringCustomer.getTelephone(), "Telephone should be empty string");
        assertEquals("", emptyStringCustomer.getEmail(), "Email should be empty string");
        assertEquals(0, emptyStringCustomer.getUnitsConsumed(), "UnitsConsumed should be 0");
    }

    @Test
    void testEdgeCaseNegativeUnitsConsumed() {
        // Test: Verify handling of negative units consumed
        customer.setUnitsConsumed(-100);
        assertEquals(-100, customer.getUnitsConsumed(), "Negative unitsConsumed should be set correctly");
    }
}