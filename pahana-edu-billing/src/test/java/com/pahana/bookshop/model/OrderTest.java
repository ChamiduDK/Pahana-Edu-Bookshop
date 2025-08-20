package com.pahana.bookshop.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.User;
import com.pahana.bookshop.model.OrderItem;

import static org.junit.jupiter.api.Assertions.*;

public class OrderTest {
    private Order order;
    private static final int CUSTOMER_ID = 1;
    private static final Integer PLACED_BY_USER_ID = 2;
    private static final BigDecimal TOTAL_AMOUNT = new BigDecimal("99.99");
    private static final String STATUS = "PENDING";

    @BeforeEach
    void setUp() {
        // Initialize an Order instance before each test with valid data
        order = new Order(CUSTOMER_ID, PLACED_BY_USER_ID, TOTAL_AMOUNT, STATUS);
    }

    @Test
    void testDefaultConstructor() {
        // Test: Verify default constructor initializes fields to null or zero
        Order emptyOrder = new Order();
        assertEquals(0, emptyOrder.getId(), "ID should be 0");
        assertEquals(0, emptyOrder.getCustomerId(), "CustomerId should be 0");
        assertNull(emptyOrder.getPlacedByUserId(), "PlacedByUserId should be null");
        assertNull(emptyOrder.getTotalAmount(), "TotalAmount should be null");
        assertNull(emptyOrder.getStatus(), "Status should be null");
        assertNull(emptyOrder.getOrderDate(), "OrderDate should be null");
        assertNull(emptyOrder.getOrderItems(), "OrderItems should be null");
        assertNull(emptyOrder.getCustomer(), "Customer should be null");
        assertNull(emptyOrder.getPlacedByUser(), "PlacedByUser should be null");
    }

    @Test
    void testParameterizedConstructorWithUserId() {
        // Test: Verify parameterized constructor with placedByUserId sets fields correctly
        assertEquals(0, order.getId(), "ID should be 0");
        assertEquals(CUSTOMER_ID, order.getCustomerId(), "CustomerId should match input");
        assertEquals(PLACED_BY_USER_ID, order.getPlacedByUserId(), "PlacedByUserId should match input");
        assertEquals(TOTAL_AMOUNT, order.getTotalAmount(), "TotalAmount should match input");
        assertEquals(STATUS, order.getStatus(), "Status should match input");
        assertNull(order.getOrderDate(), "OrderDate should be null");
        assertNull(order.getOrderItems(), "OrderItems should be null");
        assertNull(order.getCustomer(), "Customer should be null");
        assertNull(order.getPlacedByUser(), "PlacedByUser should be null");
    }

    @Test
    void testParameterizedConstructorWithoutUserId() {
        // Test: Verify parameterized constructor without placedByUserId sets fields correctly
        Order customerOrder = new Order(CUSTOMER_ID, TOTAL_AMOUNT, STATUS);
        assertEquals(0, customerOrder.getId(), "ID should be 0");
        assertEquals(CUSTOMER_ID, customerOrder.getCustomerId(), "CustomerId should match input");
        assertNull(customerOrder.getPlacedByUserId(), "PlacedByUserId should be null");
        assertEquals(TOTAL_AMOUNT, customerOrder.getTotalAmount(), "TotalAmount should match input");
        assertEquals(STATUS, customerOrder.getStatus(), "Status should match input");
        assertNull(customerOrder.getOrderDate(), "OrderDate should be null");
        assertNull(customerOrder.getOrderItems(), "OrderItems should be null");
        assertNull(customerOrder.getCustomer(), "Customer should be null");
        assertNull(customerOrder.getPlacedByUser(), "PlacedByUser should be null");
    }

    @Test
    void testSettersAndGetters() {
        // Test: Verify setters and getters for all fields
        Order newOrder = new Order();
        newOrder.setId(1);
        newOrder.setCustomerId(3);
        newOrder.setPlacedByUserId(4);
        newOrder.setTotalAmount(new BigDecimal("49.99"));
        newOrder.setStatus("CONFIRMED");
        Timestamp now = Timestamp.from(Instant.now());
        newOrder.setOrderDate(now);
        List<OrderItem> orderItems = new ArrayList<>();
        newOrder.setOrderItems(orderItems);
        Customer customer = new Customer();
        newOrder.setCustomer(customer);
        User user = new User();
        newOrder.setPlacedByUser(user);

        assertEquals(1, newOrder.getId(), "ID should be 1");
        assertEquals(3, newOrder.getCustomerId(), "CustomerId should be updated");
        assertEquals(4, newOrder.getPlacedByUserId(), "PlacedByUserId should be updated");
        assertEquals(new BigDecimal("49.99"), newOrder.getTotalAmount(), "TotalAmount should be updated");
        assertEquals("CONFIRMED", newOrder.getStatus(), "Status should be updated");
        assertEquals(now, newOrder.getOrderDate(), "OrderDate should be updated");
        assertEquals(orderItems, newOrder.getOrderItems(), "OrderItems should be updated");
        assertEquals(customer, newOrder.getCustomer(), "Customer should be updated");
        assertEquals(user, newOrder.getPlacedByUser(), "PlacedByUser should be updated");
    }

    @Test
    void testIsCustomerOrder() {
        // Test: Verify isCustomerOrder for null and non-null placedByUserId
        Order customerOrder = new Order(CUSTOMER_ID, TOTAL_AMOUNT, STATUS);
        assertTrue(customerOrder.isCustomerOrder(), "Order with null placedByUserId should be customer order");

        assertFalse(order.isCustomerOrder(), "Order with non-null placedByUserId should not be customer order");
    }

    @Test
    void testIsAdminOrder() {
        // Test: Verify isAdminOrder for null, zero, and positive placedByUserId
        Order customerOrder = new Order(CUSTOMER_ID, TOTAL_AMOUNT, STATUS);
        assertFalse(customerOrder.isAdminOrder(), "Order with null placedByUserId should not be admin order");

        Order zeroUserIdOrder = new Order(CUSTOMER_ID, 0, TOTAL_AMOUNT, STATUS);
        assertFalse(zeroUserIdOrder.isAdminOrder(), "Order with zero placedByUserId should not be admin order");

        assertTrue(order.isAdminOrder(), "Order with positive placedByUserId should be admin order");
    }

    @Test
    void testNullValues() {
        // Test: Verify handling of null values in parameterized constructor
        Order nullOrder = new Order(CUSTOMER_ID, null, null, null);
        assertEquals(0, nullOrder.getId(), "ID should be 0");
        assertEquals(CUSTOMER_ID, nullOrder.getCustomerId(), "CustomerId should match input");
        assertNull(nullOrder.getPlacedByUserId(), "PlacedByUserId should be null");
        assertNull(nullOrder.getTotalAmount(), "TotalAmount should be null");
        assertNull(nullOrder.getStatus(), "Status should be null");
        assertNull(nullOrder.getOrderDate(), "OrderDate should be null");
        assertNull(nullOrder.getOrderItems(), "OrderItems should be null");
        assertNull(nullOrder.getCustomer(), "Customer should be null");
        assertNull(nullOrder.getPlacedByUser(), "PlacedByUser should be null");
    }

    @Test
    void testEdgeCaseEmptyOrderItems() {
        // Test: Verify handling of empty order items list
        List<OrderItem> emptyItems = new ArrayList<>();
        order.setOrderItems(emptyItems);
        assertEquals(emptyItems, order.getOrderItems(), "OrderItems should be empty list");
        assertTrue(order.getOrderItems().isEmpty(), "OrderItems list should be empty");
    }

    @Test
    void testEdgeCaseNegativeTotalAmount() {
        // Test: Verify handling of negative total amount
        order.setTotalAmount(new BigDecimal("-10.00"));
        assertEquals(new BigDecimal("-10.00"), order.getTotalAmount(), "Negative totalAmount should be set correctly");
    }

    @Test
    void testEdgeCaseNegativeIds() {
        // Test: Verify handling of negative customerId and placedByUserId
        Order negativeIdOrder = new Order(-1, -2, TOTAL_AMOUNT, STATUS);
        assertEquals(-1, negativeIdOrder.getCustomerId(), "Negative customerId should be set correctly");
        assertEquals(-2, negativeIdOrder.getPlacedByUserId(), "Negative placedByUserId should be set correctly");
    }

    @Test
    void testEdgeCaseEmptyStatus() {
        // Test: Verify handling of empty status string
        Order emptyStatusOrder = new Order(CUSTOMER_ID, TOTAL_AMOUNT, "");
        assertEquals("", emptyStatusOrder.getStatus(), "Status should be empty string");
    }
}