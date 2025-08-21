package com.pahana.bookshop.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.pahana.bookshop.model.Book;
import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class OrderItemTest {
    private OrderItem orderItem;
    private static final int ORDER_ID = 1;
    private static final int BOOK_ID = 2;
    private static final int QUANTITY = 3;
    private static final BigDecimal UNIT_PRICE = new BigDecimal("29.99");

    @BeforeEach
    void setUp() {
        // Initialize an OrderItem instance before each test with valid data
        orderItem = new OrderItem(ORDER_ID, BOOK_ID, QUANTITY, UNIT_PRICE);
    }

    @Test
    void testDefaultConstructor() {
        // Test: Verify default constructor initializes fields to null or zero
        OrderItem emptyOrderItem = new OrderItem();
        assertEquals(0, emptyOrderItem.getId(), "ID should be 0");
        assertEquals(0, emptyOrderItem.getOrderId(), "OrderId should be 0");
        assertEquals(0, emptyOrderItem.getBookId(), "BookId should be 0");
        assertEquals(0, emptyOrderItem.getQuantity(), "Quantity should be 0");
        assertNull(emptyOrderItem.getUnitPrice(), "UnitPrice should be null");
        assertNull(emptyOrderItem.getBook(), "Book should be null");
    }

    @Test
    void testParameterizedConstructor() {
        // Test: Verify parameterized constructor sets fields correctly
        assertEquals(0, orderItem.getId(), "ID should be 0");
        assertEquals(ORDER_ID, orderItem.getOrderId(), "OrderId should match input");
        assertEquals(BOOK_ID, orderItem.getBookId(), "BookId should match input");
        assertEquals(QUANTITY, orderItem.getQuantity(), "Quantity should match input");
        assertEquals(UNIT_PRICE, orderItem.getUnitPrice(), "UnitPrice should match input");
        assertNull(orderItem.getBook(), "Book should be null");
    }

    @Test
    void testSettersAndGetters() {
        // Test: Verify setters and getters for all fields
        OrderItem newOrderItem = new OrderItem();
        newOrderItem.setId(1);
        newOrderItem.setOrderId(3);
        newOrderItem.setBookId(4);
        newOrderItem.setQuantity(5);
        newOrderItem.setUnitPrice(new BigDecimal("19.99"));
        Book book = new Book();
        newOrderItem.setBook(book);

        assertEquals(1, newOrderItem.getId(), "ID should be 1");
        assertEquals(3, newOrderItem.getOrderId(), "OrderId should be updated");
        assertEquals(4, newOrderItem.getBookId(), "BookId should be updated");
        assertEquals(5, newOrderItem.getQuantity(), "Quantity should be updated");
        assertEquals(new BigDecimal("19.99"), newOrderItem.getUnitPrice(), "UnitPrice should be updated");
        assertEquals(book, newOrderItem.getBook(), "Book should be updated");
    }

    @Test
    void testGetSubtotal() {
        // Test: Verify getSubtotal for valid case
        BigDecimal expectedSubtotal = UNIT_PRICE.multiply(BigDecimal.valueOf(QUANTITY));
        assertEquals(expectedSubtotal, orderItem.getSubtotal(), "Subtotal should be unitPrice * quantity");

        // Test: Verify getSubtotal with null unitPrice
        orderItem.setUnitPrice(null);
        assertEquals(BigDecimal.ZERO, orderItem.getSubtotal(), "Subtotal should be zero for null unitPrice");

        // Test: Verify getSubtotal with zero quantity
        orderItem.setUnitPrice(UNIT_PRICE);
        orderItem.setQuantity(0);
        assertEquals(BigDecimal.ZERO, orderItem.getSubtotal(), "Subtotal should be zero for zero quantity");
    }

    @Test
    void testToString() {
        // Test: Verify toString format
        orderItem.setId(1);
        BigDecimal subtotal = orderItem.getSubtotal();
        String result = orderItem.toString();
        assertTrue(result.contains("id=1"), "toString should contain ID");
        assertTrue(result.contains("orderId=1"), "toString should contain orderId");
        assertTrue(result.contains("bookId=2"), "toString should contain bookId");
        assertTrue(result.contains("quantity=3"), "toString should contain quantity");
        assertTrue(result.contains("unitPrice=29.99"), "toString should contain unitPrice");
        assertTrue(result.contains("subtotal=" + subtotal), "toString should contain subtotal");
    }

    @Test
    void testNullValues() {
        // Test: Verify handling of null unitPrice in parameterized constructor
        OrderItem nullOrderItem = new OrderItem(ORDER_ID, BOOK_ID, QUANTITY, null);
        assertEquals(0, nullOrderItem.getId(), "ID should be 0");
        assertEquals(ORDER_ID, nullOrderItem.getOrderId(), "OrderId should match input");
        assertEquals(BOOK_ID, nullOrderItem.getBookId(), "BookId should match input");
        assertEquals(QUANTITY, nullOrderItem.getQuantity(), "Quantity should match input");
        assertNull(nullOrderItem.getUnitPrice(), "UnitPrice should be null");
        assertNull(nullOrderItem.getBook(), "Book should be null");
        assertEquals(BigDecimal.ZERO, nullOrderItem.getSubtotal(), "Subtotal should be zero for null unitPrice");
    }

    @Test
    void testEdgeCaseNegativeQuantity() {
        // Test: Verify handling of negative quantity in getSubtotal
        orderItem.setQuantity(-1);
        assertEquals(-1, orderItem.getQuantity(), "Negative quantity should be set correctly");
        assertEquals(BigDecimal.ZERO, orderItem.getSubtotal(), "Subtotal should be zero for negative quantity");
    }

    @Test
    void testEdgeCaseZeroQuantity() {
        // Test: Verify handling of zero quantity in getSubtotal
        orderItem.setQuantity(0);
        assertEquals(0, orderItem.getQuantity(), "Zero quantity should be set correctly");
        assertEquals(BigDecimal.ZERO, orderItem.getSubtotal(), "Subtotal should be zero for zero quantity");
    }

    @Test
    void testEdgeCaseNegativeUnitPrice() {
        // Test: Verify handling of negative unitPrice in getSubtotal
        orderItem.setUnitPrice(new BigDecimal("-10.00"));
        assertEquals(new BigDecimal("-10.00"), orderItem.getUnitPrice(), "Negative unitPrice should be set correctly");
        BigDecimal expectedSubtotal = new BigDecimal("-10.00").multiply(BigDecimal.valueOf(QUANTITY));
        assertEquals(expectedSubtotal, orderItem.getSubtotal(), "Subtotal should be negative unitPrice * quantity");
    }

    @Test
    void testEdgeCaseNegativeIds() {
        // Test: Verify handling of negative orderId and bookId
        OrderItem negativeIdOrderItem = new OrderItem(-1, -2, QUANTITY, UNIT_PRICE);
        assertEquals(-1, negativeIdOrderItem.getOrderId(), "Negative orderId should be set correctly");
        assertEquals(-2, negativeIdOrderItem.getBookId(), "Negative bookId should be set correctly");
    }
}