package com.pahana.bookshop.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;

import static org.junit.jupiter.api.Assertions.*;

public class BookTest {
    private Book book;
    private static final String TITLE = "Test Book";
    private static final String AUTHOR = "Test Author";
    private static final String ISBN = "1234567890123";
    private static final BigDecimal PRICE = new BigDecimal("29.99");
    private static final int STOCK_QUANTITY = 10;
    private static final String CATEGORY = "Fiction";
    private static final String DESCRIPTION = "A test book description";

    @BeforeEach
    void setUp() {
        // Initialize a Book instance before each test with valid data
        book = new Book(TITLE, AUTHOR, ISBN, PRICE, STOCK_QUANTITY, CATEGORY, DESCRIPTION);
    }

    @Test
    void testDefaultConstructor() {
        // Test: Verify default constructor initializes fields to null or zero
        Book emptyBook = new Book();
        assertNull(emptyBook.getTitle(), "Title should be null");
        assertNull(emptyBook.getAuthor(), "Author should be null");
        assertNull(emptyBook.getIsbn(), "ISBN should be null");
        assertNull(emptyBook.getPrice(), "Price should be null");
        assertEquals(0, emptyBook.getStockQuantity(), "Stock quantity should be 0");
        assertNull(emptyBook.getCategory(), "Category should be null");
        assertNull(emptyBook.getDescription(), "Description should be null");
        assertNull(emptyBook.getCreatedAt(), "CreatedAt should be null");
        assertNull(emptyBook.getUpdatedAt(), "UpdatedAt should be null");
    }

    @Test
    void testParameterizedConstructor() {
        // Test: Verify parameterized constructor sets fields correctly
        assertEquals(TITLE, book.getTitle(), "Title should match input");
        assertEquals(AUTHOR, book.getAuthor(), "Author should match input");
        assertEquals(ISBN, book.getIsbn(), "ISBN should match input");
        assertEquals(PRICE, book.getPrice(), "Price should match input");
        assertEquals(STOCK_QUANTITY, book.getStockQuantity(), "Stock quantity should match input");
        assertEquals(CATEGORY, book.getCategory(), "Category should match input");
        assertEquals(DESCRIPTION, book.getDescription(), "Description should match input");
    }

    @Test
    void testSettersAndGetters() {
        // Test: Verify setters and getters for all fields
        Book newBook = new Book();
        newBook.setId(1);
        newBook.setTitle("New Title");
        newBook.setAuthor("New Author");
        newBook.setIsbn("9876543210987");
        newBook.setPrice(new BigDecimal("19.99"));
        newBook.setStockQuantity(5);
        newBook.setCategory("Non-Fiction");
        newBook.setDescription("New Description");
        Timestamp now = Timestamp.from(Instant.now());
        newBook.setCreatedAt(now);
        newBook.setUpdatedAt(now);

        assertEquals(1, newBook.getId(), "ID should be 1");
        assertEquals("New Title", newBook.getTitle(), "Title should be updated");
        assertEquals("New Author", newBook.getAuthor(), "Author should be updated");
        assertEquals("9876543210987", newBook.getIsbn(), "ISBN should be updated");
        assertEquals(new BigDecimal("19.99"), newBook.getPrice(), "Price should be updated");
        assertEquals(5, newBook.getStockQuantity(), "Stock quantity should be updated");
        assertEquals("Non-Fiction", newBook.getCategory(), "Category should be updated");
        assertEquals("New Description", newBook.getDescription(), "Description should be updated");
        assertEquals(now, newBook.getCreatedAt(), "CreatedAt should be updated");
        assertEquals(now, newBook.getUpdatedAt(), "UpdatedAt should be updated");
    }

    @Test
    void testIsInStock() {
        // Test: Verify isInStock for positive, zero, and negative stock
        assertTrue(book.isInStock(), "Book should be in stock with positive quantity");

        book.setStockQuantity(0);
        assertFalse(book.isInStock(), "Book should not be in stock with zero quantity");

        book.setStockQuantity(-1);
        assertFalse(book.isInStock(), "Book should not be in stock with negative quantity");
    }

    @Test
    void testHasLowStock() {
        // Test: Verify hasLowStock for various thresholds
        book.setStockQuantity(5);
        assertTrue(book.hasLowStock(5), "Stock should be low at exact threshold");
        assertTrue(book.hasLowStock(10), "Stock should be low when below threshold");
        assertFalse(book.hasLowStock(3), "Stock should not be low when above threshold");

        book.setStockQuantity(0);
        assertTrue(book.hasLowStock(0), "Stock should be low at zero with zero threshold");
    }

    @Test
    void testToString() {
        // Test: Verify toString format
        book.setId(1);
        String expected = "Book{id=1, title='Test Book', author='Test Author', isbn='1234567890123', price=29.99, stockQuantity=10, category='Fiction'}";
        assertEquals(expected, book.toString(), "toString should match expected format");
    }

    @Test
    void testNullValues() {
        // Test: Verify handling of null values in parameterized constructor
        Book nullBook = new Book(null, null, null, null, 0, null, null);
        assertNull(nullBook.getTitle(), "Title should be null");
        assertNull(nullBook.getAuthor(), "Author should be null");
        assertNull(nullBook.getIsbn(), "ISBN should be null");
        assertNull(nullBook.getPrice(), "Price should be null");
        assertEquals(0, nullBook.getStockQuantity(), "Stock quantity should be 0");
        assertNull(nullBook.getCategory(), "Category should be null");
        assertNull(nullBook.getDescription(), "Description should be null");
    }

    @Test
    void testEdgeCaseNegativePrice() {
        // Test: Verify handling of negative price
        book.setPrice(new BigDecimal("-10.00"));
        assertEquals(new BigDecimal("-10.00"), book.getPrice(), "Negative price should be set correctly");
    }

    @Test
    void testEdgeCaseEmptyStrings() {
        // Test: Verify handling of empty strings
        Book emptyStringBook = new Book("", "", "", new BigDecimal("10.00"), 5, "", "");
        assertEquals("", emptyStringBook.getTitle(), "Title should be empty string");
        assertEquals("", emptyStringBook.getAuthor(), "Author should be empty string");
        assertEquals("", emptyStringBook.getIsbn(), "ISBN should be empty string");
        assertEquals("", emptyStringBook.getCategory(), "Category should be empty string");
        assertEquals("", emptyStringBook.getDescription(), "Description should be empty string");
    }
}