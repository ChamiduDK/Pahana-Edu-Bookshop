package com.pahana.bookshop.dao;

import com.pahana.bookshop.config.DatabaseConnection;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class OrderDAOTest {
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
    private OrderDAO orderDAO;

    private Order testOrder;
    private OrderItem testOrderItem;
    private Customer testCustomer;
    private User testUser;
    private Book testBook;

    @BeforeEach
    void setUp() throws SQLException {
        // Initialize test data
        testCustomer = new Customer("ACC001", "John Doe", "123 Main St", "0771234567", "john@example.com");
        testCustomer.setId(1);

        testUser = new User();
        testUser.setId(2);
        testUser.setUsername("admin");

        testBook = new Book();
        testBook.setId(1);
        testBook.setTitle("Test Book");
        testBook.setAuthor("Test Author");

        testOrderItem = new OrderItem(0, 1, 2, new BigDecimal("29.99"));
        testOrderItem.setBook(testBook);

        testOrder = new Order();
        testOrder.setId(1);
        testOrder.setCustomerId(1);
        testOrder.setPlacedByUserId(2);
        testOrder.setTotalAmount(new BigDecimal("59.98"));
        testOrder.setStatus("PENDING");
        testOrder.setCustomer(testCustomer);
        testOrder.setPlacedByUser(testUser);
        List<OrderItem> orderItems = new ArrayList<>();
        orderItems.add(testOrderItem);
        testOrder.setOrderItems(orderItems);

        // Mock DatabaseConnection to return mocked Connection
        when(dbConnection.getConnection()).thenReturn(connection);
    }

    @Test
    void testCreateSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful order creation
        when(connection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);
        when(preparedStatement.getGeneratedKeys()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt(1)).thenReturn(1);

        int orderId = orderDAO.create(testOrder);

        assertEquals(1, orderId, "Create should return order ID");
        verify(preparedStatement, times(1)).setInt(1, testOrder.getCustomerId());
        verify(preparedStatement, times(1)).setInt(2, testOrder.getPlacedByUserId());
        verify(preparedStatement, times(1)).setBigDecimal(3, testOrder.getTotalAmount());
        verify(preparedStatement, times(1)).setString(4, testOrder.getStatus());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testCreateSQLException() throws SQLException {
        // Test ID: T2
        // Test: Create with SQL exception
        when(connection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS))).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> orderDAO.create(testOrder), "Create should throw SQLException");
    }

    @Test
    void testCreateOrderItemSuccess() throws SQLException {
        // Test ID: T3
        // Test: Successful order item creation
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = orderDAO.createOrderItem(testOrderItem);

        assertTrue(result, "CreateOrderItem should return true for successful insertion");
        verify(preparedStatement, times(1)).setInt(1, testOrderItem.getOrderId());
        verify(preparedStatement, times(1)).setInt(2, testOrderItem.getBookId());
        verify(preparedStatement, times(1)).setInt(3, testOrderItem.getQuantity());
        verify(preparedStatement, times(1)).setBigDecimal(4, testOrderItem.getUnitPrice());
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testCreateOrderItemSQLException() throws SQLException {
        // Test ID: T4
        // Test: CreateOrderItem with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> orderDAO.createOrderItem(testOrderItem), "CreateOrderItem should throw SQLException");
    }

    @Test
    void testFindByIdSuccess() throws SQLException {
        // Test ID: T5
        // Test: Finding an order by valid ID with items
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true).thenReturn(true, false); // Order and order item
        when(resultSet.getInt("id")).thenReturn(testOrder.getId());
        when(resultSet.getInt("customer_id")).thenReturn(testOrder.getCustomerId());
        when(resultSet.getInt("placed_by_user_id")).thenReturn(testOrder.getPlacedByUserId());
        when(resultSet.getBigDecimal("total_amount")).thenReturn(testOrder.getTotalAmount());
        when(resultSet.getString("status")).thenReturn(testOrder.getStatus());
        when(resultSet.getTimestamp("order_date")).thenReturn(testOrder.getOrderDate());
        when(resultSet.getString("account_number")).thenReturn(testCustomer.getAccountNumber());
        when(resultSet.getString("customer_name")).thenReturn(testCustomer.getName());
        when(resultSet.getString("address")).thenReturn(testCustomer.getAddress());
        when(resultSet.getString("telephone")).thenReturn(testCustomer.getTelephone());
        when(resultSet.getString("customer_email")).thenReturn(testCustomer.getEmail());
        when(resultSet.getString("placed_by_username")).thenReturn(testUser.getUsername());
        when(resultSet.getInt("book_id")).thenReturn(testBook.getId());
        when(resultSet.getInt("quantity")).thenReturn(testOrderItem.getQuantity());
        when(resultSet.getBigDecimal("unit_price")).thenReturn(testOrderItem.getUnitPrice());
        when(resultSet.getString("title")).thenReturn(testBook.getTitle());
        when(resultSet.getString("author")).thenReturn(testBook.getAuthor());

        Order result = orderDAO.findById(1);

        assertNotNull(result, "Order should be found");
        assertEquals(testOrder.getId(), result.getId(), "Order ID should match");
        assertEquals(1, result.getOrderItems().size(), "Order should have one item");
        verify(preparedStatement, times(2)).setInt(1, 1); // findById and findOrderItemsByOrderId
        verify(preparedStatement, times(2)).executeQuery();
    }

    @Test
    void testFindByIdNotFound() throws SQLException {
        // Test ID: T6
        // Test: Finding an order by non-existent ID
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        Order result = orderDAO.findById(999);

        assertNull(result, "Non-existent order should return null");
        verify(preparedStatement, times(1)).setInt(1, 999);
        verify(preparedStatement, times(1)).executeQuery();
    }

    @Test
    void testFindByIdSQLException() throws SQLException {
        // Test ID: T7
        // Test: FindById with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> orderDAO.findById(1), "FindById should throw SQLException");
    }

    @Test
    void testFindAllSuccess() throws SQLException {
        // Test ID: T8
        // Test: Retrieving all orders with items
        when(connection.createStatement()).thenReturn(statement);
        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false); // Two orders
        when(resultSet.getInt("id")).thenReturn(1, 2);
        when(resultSet.getInt("customer_id")).thenReturn(testCustomer.getId());
        when(resultSet.getBigDecimal("total_amount")).thenReturn(testOrder.getTotalAmount());
        when(resultSet.getString("status")).thenReturn(testOrder.getStatus());
        when(resultSet.getString("account_number")).thenReturn(testCustomer.getAccountNumber());
        when(resultSet.getString("customer_name")).thenReturn(testCustomer.getName());
        when(resultSet.getString("placed_by_username")).thenReturn(testUser.getUsername());
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, false); // One order item per order

        List<Order> orders = orderDAO.findAll();

        assertEquals(2, orders.size(), "Should return two orders");
        assertEquals(1, orders.get(0).getId(), "First order ID should be 1");
        verify(statement, times(1)).executeQuery(anyString());
        verify(preparedStatement, times(2)).executeQuery(); // For order items
    }

    @Test
    void testFindAllEmpty() throws SQLException {
        // Test ID: T9
        // Test: FindAll with no orders
        when(connection.createStatement()).thenReturn(statement);
        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        List<Order> orders = orderDAO.findAll();

        assertTrue(orders.isEmpty(), "Should return empty list when no orders exist");
        verify(statement, times(1)).executeQuery(anyString());
    }

    @Test
    void testFindAllSQLException() throws SQLException {
        // Test ID: T10
        // Test: FindAll with SQL exception
        when(connection.createStatement()).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> orderDAO.findAll(), "FindAll should throw SQLException");
    }

    @Test
    void testUpdateStatusSuccess() throws SQLException {
        // Test ID: T11
        // Test: Updating an order’s status
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeUpdate()).thenReturn(1);

        boolean result = orderDAO.updateStatus(1, "DELIVERED");

        assertTrue(result, "UpdateStatus should return true for successful update");
        verify(preparedStatement, times(1)).setString(1, "DELIVERED");
        verify(preparedStatement, times(1)).setInt(2, 1);
        verify(preparedStatement, times(1)).executeUpdate();
    }

    @Test
    void testUpdateStatusSQLException() throws SQLException {
        // Test ID: T12
        // Test: UpdateStatus with SQL exception
        when(connection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));
        assertThrows(SQLException.class, () -> orderDAO.updateStatus(1, "DELIVERED"), "UpdateStatus should throw SQLException");
    }
}