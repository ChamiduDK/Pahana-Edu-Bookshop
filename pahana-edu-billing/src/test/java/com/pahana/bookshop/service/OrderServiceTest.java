package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.BookDAO;
import com.pahana.bookshop.dao.CustomerDAO;
import com.pahana.bookshop.dao.OrderDAO;
import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Customer;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.util.EmailUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class OrderServiceTest {
    @Mock
    private OrderDAO orderDAO;

    @Mock
    private BookDAO bookDAO;

    @Mock
    private CustomerDAO customerDAO;

    @Mock
    private EmailUtil emailUtil;

    @InjectMocks
    private OrderService orderService;

    private Order testOrder;
    private Customer testCustomer;
    private Book testBook;
    private OrderItem testOrderItem;

    @BeforeEach
    void setUp() {
        // Initialize test data
        testCustomer = new Customer("ACC001", "John Doe", "123 Main St", "555-0123", "john@example.com");
        testCustomer.setId(1);
        testCustomer.setUnitsConsumed(100);

        testBook = new Book("Test Book", "Test Author", "1234567890123", new BigDecimal("29.99"), 10, "Fiction", "Description");
        testBook.setId(1);

        testOrderItem = new OrderItem(0, testBook.getId(), 2, testBook.getPrice());

        testOrder = new Order(testCustomer.getId(), null, BigDecimal.ZERO, "PENDING");
        List<OrderItem> orderItems = new ArrayList<>();
        orderItems.add(testOrderItem);
        testOrder.setOrderItems(orderItems);
    }

    @Test
    void testCreateOrderSuccess() throws SQLException {
        // Test ID: T1
        // Test: Successful order creation
        when(customerDAO.findById(testCustomer.getId())).thenReturn(testCustomer);
        when(bookDAO.findById(testBook.getId())).thenReturn(testBook);
        when(orderDAO.create(testOrder)).thenReturn(1);
        when(orderDAO.findById(1)).thenReturn(testOrder);

        int orderId = orderService.createOrder(testOrder);

        assertEquals(1, orderId, "CreateOrder should return order ID");
        assertEquals(new BigDecimal("59.98"), testOrder.getTotalAmount(), "Total amount should be calculated correctly");
        verify(orderDAO, times(1)).create(testOrder);
        verify(orderDAO, times(1)).createOrderItem(testOrderItem);
        verify(bookDAO, times(1)).updateStock(testBook.getId(), 8);
        verify(customerDAO, times(1)).update(testCustomer);
        verify(emailUtil, times(1)).sendOrderConfirmation(testOrder);
    }

    @Test
    void testCreateOrderSQLException() throws SQLException {
        // Test ID: T2
        // Test: CreateOrder with SQL exception
        when(customerDAO.findById(testCustomer.getId())).thenReturn(testCustomer);
        when(bookDAO.findById(testBook.getId())).thenReturn(testBook);
        when(orderDAO.create(testOrder)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> orderService.createOrder(testOrder), "CreateOrder should throw SQLException");
    }

    @Test
    void testCreateOrderNullOrder() {
        // Test ID: T3
        // Test: CreateOrder with null Order object
        assertThrows(IllegalArgumentException.class, () -> orderService.createOrder(null), "CreateOrder with null Order should throw IllegalArgumentException");
    }

    @Test
    void testCreateOrderInvalidCustomerId() {
        // Test ID: T4
        // Test: CreateOrder with invalid customer ID
        testOrder.setCustomerId(0);
        assertThrows(IllegalArgumentException.class, () -> orderService.createOrder(testOrder), "CreateOrder with invalid customer ID should throw IllegalArgumentException");
    }

    @Test
    void testCreateOrderCustomerNotFound() throws SQLException {
        // Test ID: T5
        // Test: CreateOrder when customer is not found
        when(customerDAO.findById(testCustomer.getId())).thenReturn(null);

        assertThrows(IllegalArgumentException.class, () -> orderService.createOrder(testOrder), "CreateOrder with non-existent customer should throw IllegalArgumentException");
    }

    @Test
    void testCreateOrderBookNotFound() throws SQLException {
        // Test ID: T6
        // Test: CreateOrder when a book is not found
        when(customerDAO.findById(testCustomer.getId())).thenReturn(testCustomer);
        when(bookDAO.findById(testBook.getId())).thenReturn(null);

        assertThrows(IllegalArgumentException.class, () -> orderService.createOrder(testOrder), "CreateOrder with non-existent book should throw IllegalArgumentException");
    }

    @Test
    void testCreateOrderInsufficientStock() throws SQLException {
        // Test ID: T7
        // Test: CreateOrder with insufficient book stock
        testOrderItem.setQuantity(20); // More than stock (10)
        when(customerDAO.findById(testCustomer.getId())).thenReturn(testCustomer);
        when(bookDAO.findById(testBook.getId())).thenReturn(testBook);

        assertThrows(IllegalArgumentException.class, () -> orderService.createOrder(testOrder), "CreateOrder with insufficient stock should throw IllegalArgumentException");
    }

    @Test
    void testCreateOrderEmptyOrderItems() {
        // Test ID: T8
        // Test: CreateOrder with empty order items
        testOrder.setOrderItems(new ArrayList<>());
        assertThrows(IllegalArgumentException.class, () -> orderService.createOrder(testOrder), "CreateOrder with empty order items should throw IllegalArgumentException");
    }

    @Test
    void testGetOrderByIdSuccess() throws SQLException {
        // Test ID: T9
        // Test: Retrieving an order by valid ID
        when(orderDAO.findById(1)).thenReturn(testOrder);

        Order result = orderService.getOrderById(1);

        assertNotNull(result, "GetOrderById should return an Order");
        assertEquals(testOrder, result, "Returned Order should match expected");
        verify(orderDAO, times(1)).findById(1);
    }

    @Test
    void testGetOrderByIdSQLException() throws SQLException {
        // Test ID: T10
        // Test: GetOrderById with SQL exception
        when(orderDAO.findById(1)).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> orderService.getOrderById(1), "GetOrderById should throw SQLException");
    }

    @Test
    void testGetAllOrdersSuccess() throws SQLException {
        // Test ID: T11
        // Test: Retrieving all orders
        List<Order> orders = new ArrayList<>();
        orders.add(testOrder);
        when(orderDAO.findAll()).thenReturn(orders);

        List<Order> result = orderService.getAllOrders();

        assertEquals(1, result.size(), "GetAllOrders should return one order");
        assertEquals(testOrder, result.get(0), "Returned Order should match expected");
        verify(orderDAO, times(1)).findAll();
    }

    @Test
    void testGetAllOrdersEmpty() throws SQLException {
        // Test ID: T12
        // Test: GetAllOrders with no orders
        when(orderDAO.findAll()).thenReturn(new ArrayList<>());

        List<Order> result = orderService.getAllOrders();

        assertTrue(result.isEmpty(), "GetAllOrders should return empty list when no orders exist");
        verify(orderDAO, times(1)).findAll();
    }

    @Test
    void testGetAllOrdersSQLException() throws SQLException {
        // Test ID: T13
        // Test: GetAllOrders with SQL exception
        when(orderDAO.findAll()).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> orderService.getAllOrders(), "GetAllOrders should throw SQLException");
    }

    @Test
    void testUpdateOrderStatusSuccess() throws SQLException {
        // Test ID: T14
        // Test: Updating order status to valid value
        when(orderDAO.updateStatus(1, "DELIVERED")).thenReturn(true);
        when(orderDAO.findById(1)).thenReturn(testOrder);

        boolean result = orderService.updateOrderStatus(1, "DELIVERED");

        assertTrue(result, "UpdateOrderStatus should return true for successful update");
        verify(orderDAO, times(1)).updateStatus(1, "DELIVERED");
        verify(emailUtil, times(1)).sendBillEmail(testOrder);
    }

    @Test
    void testUpdateOrderStatusInvalidStatus() {
        // Test ID: T15
        // Test: Updating order status with invalid status
        assertThrows(IllegalArgumentException.class, () -> orderService.updateOrderStatus(1, "INVALID"), "UpdateOrderStatus with invalid status should throw IllegalArgumentException");
    }

    @Test
    void testUpdateOrderStatusSQLException() throws SQLException {
        // Test ID: T16
        // Test: UpdateOrderStatus with SQL exception
        when(orderDAO.updateStatus(1, "PENDING")).thenThrow(new SQLException("Database error"));

        assertThrows(SQLException.class, () -> orderService.updateOrderStatus(1, "PENDING"), "UpdateOrderStatus should throw SQLException");
    }
}