package com.pahana.bookshop.dao;

import com.pahana.bookshop.config.DatabaseConnection;
import com.pahana.bookshop.model.Book;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class BookDAOTest {
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
    private BookDAO bookDAO;

    private Book testBook;

    @BeforeEach
    void setUp() throws SQLException {
        // Initialize a test Book instance
        testBook = new Book("Test Title", "Test Author", "1234567890123", new BigDecimal("29.99"), 10, "Fiction", "Test Description");
        testBook.setId(1);

        // Mock DatabaseConnection to return mocked Connection
        when(dbConnection.getConnection()).thenReturn(connection);
    }

    @Test
    void testCreateSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful book creation
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = bookDAO.create(testBook);

        assertTrue(result, "Create should return true for successful insertion");
        verify(preparedStatement, times(1)).setString(1, testBook.getTitle());
        verify(preparedStatement, times(1)).setString(2, testBook.getAuthor());
        verify(preparedStatement, times(1)).setString(3, testBook.getIsbn());
        verify(preparedStatement, times(1)).setBigDecimal(4, testBook.getPrice());
        verify(preparedStatement, times(1)).setInt(5, testBook.getStockQuantity());
        verify(preparedStatement, times(1)).setString(6, testBook.getCategory());
        verify(preparedStatement, times(1)).setString(7, testBook.getDescription());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testCreateSQLException() throws SQLException {
        // Test ID: T2
        // Test: Create with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> bookDAO.create(testBook), "Create should throw SQLException");
    }

    @Test
    void testCreateNullBook() throws SQLException {
        // Test ID: T3
        // Test: Create with null Book object
        assertThrows(NullPointerException.class, () -> bookDAO.create(null), "Create with null Book should throw NullPointerException");
    }

    @Test
    void testFindByIdSuccess() throws SQLException {
        // Test ID: T4
        // Test: Finding a book by valid ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt("id")).thenReturn(1);
        when(resultSet.getString("title")).thenReturn(testBook.getTitle());
        when(resultSet.getString("author")).thenReturn(testBook.getAuthor());
        when(resultSet.getString("isbn")).thenReturn(testBook.getIsbn());
        when(resultSet.getBigDecimal("price")).thenReturn(testBook.getPrice());
        when(resultSet.getInt("stock_quantity")).thenReturn(testBook.getStockQuantity());
        when(resultSet.getString("category")).thenReturn(testBook.getCategory());
        when(resultSet.getString("description")).thenReturn(testBook.getDescription());
        when(resultSet.getTimestamp("created_at")).thenReturn(testBook.getCreatedAt());
        when(resultSet.getTimestamp("updated_at")).thenReturn(testBook.getUpdatedAt());

        Book result = bookDAO.findById(1);

        assertNotNull(result, "Book should be found");
        assertEquals(testBook.getId(), result.getId(), "Book ID should match");
        assertEquals(testBook.getTitle(), result.getTitle(), "Book title should match");
        verify(preparedStatement, times(1)).setInt(1, 1);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdNotFound() throws SQLException {
        // Test ID: T5
        // Test: Finding a book by non-existent ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        Book result = bookDAO.findById(999);

        assertNull(result, "Non-existent book should return null");
        verify(preparedStatement, times(1)).setInt(1, 999);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdSQLException() throws SQLException {
        // Test ID: T6
        // Test: FindById with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> bookDAO.findById(1), "FindById should throw SQLException");
    }

    @Test
    void testFindAllSuccess() throws SQLException {
        // Test ID: T7
        // Test: Retrieving all books
        when(connection.createStatement()).thenReturn(statement);
        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false); // Two books
        when(resultSet.getInt("id")).thenReturn(1, 2);
        when(resultSet.getString("title")).thenReturn("Book 1", "Book 2");

        List<Book> books = bookDAO.findAll();

        assertEquals(2, books.size(), "Should return two books");
        assertEquals(1, books.get(0).getId(), "First book ID should be 1");
        assertEquals("Book 1", books.get(0).getTitle(), "First book title should be Book 1");
        verify(statement, times(1)).executeQuery(anyString());
    }

    @Test
    void testFindAllEmpty() throws SQLException {
        // Test ID: T8
        // Test: FindAll with no books
        when(connection.createStatement()).thenReturn(statement);
        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        List<Book> books = bookDAO.findAll();

        assertTrue(books.isEmpty(), "Should return empty list when no books exist");
        verify(statement, times(1)).executeQuery(anyString());
    }

    @Test
    void testFindAllSQLException() throws SQLException {
        // Test ID: T9
        // Test: FindAll with SQL exception
        when(connection.createStatement()).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> bookDAO.findAll(), "FindAll should throw SQLException");
    }

    @Test
    void testUpdateStockSuccess() throws SQLException {
        // Test ID: T10
        // Test: Updating stock quantity
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = bookDAO.updateStock(1, 20);

        assertTrue(result, "UpdateStock should return true for successful update");
        verify(preparedStatement, times(1)).setInt(1, 20);
        verify(preparedStatement, times(1)).setInt(2, 1);
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testUpdateStockSQLException() throws SQLException {
        // Test ID: T11
        // Test: UpdateStock with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> bookDAO.updateStock(1, 20), "UpdateStock should throw SQLException");
    }

    @Test
    void testUpdateSuccess() throws SQLException {
        // Test ID: T12
        // Test: Updating a book’s details
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = bookDAO.update(testBook);

        assertTrue(result, "Update should return true for successful update");
        verify(preparedStatement, times(1)).setString(1, testBook.getTitle());
        verify(preparedStatement, times(1)).setString(2, testBook.getAuthor());
        verify(preparedStatement, times(1)).setString(3, testBook.getIsbn());
        verify(preparedStatement, times(1)).setBigDecimal(4, testBook.getPrice());
        verify(preparedStatement, times(1)).setInt(5, testBook.getStockQuantity());
        verify(preparedStatement, times(1)).setString(6, testBook.getCategory());
        verify(preparedStatement, times(1)).setString(7, testBook.getDescription());
        verify(preparedStatement, times(1)).setInt(8, testBook.getId());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testUpdateSQLException() throws SQLException {
        // Test ID: T13
        // Test: Update with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> bookDAO.update(testBook), "Update should throw SQLException");
    }

    @Test
    void testUpdateNullBook() throws SQLException {
        // Test ID: T14
        // Test: Update with null Book object
        assertThrows(NullPointerException.class, () -> bookDAO.update(null), "Update with null Book should throw NullPointerException");
    }

    @Test
    void testDeleteSuccess() throws SQLException {
        // Test ID: T15
        // Test: Deleting a book by ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = bookDAO.delete(1);

        assertTrue(result, "Delete should return true for successful deletion");
        verify(preparedStatement, times(1)).setInt(1, 1);
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testDeleteSQLException() throws SQLException {
        // Test ID: T16
        // Test: Delete with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> bookDAO.delete(1), "Delete should throw SQLException");
    }
}