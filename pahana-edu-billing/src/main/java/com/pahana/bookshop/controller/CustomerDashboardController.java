package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.OrderService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer-dashboard")
public class CustomerDashboardController extends HttpServlet {
    private BookService bookService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.bookService = serviceFactory.createBookService();
        this.orderService = serviceFactory.createOrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            request.setAttribute("error", "Please log in to access the dashboard");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            List<Book> books = bookService.getAllBooks();
            List<Order> orders = orderService.getOrdersByCustomerId(
                ((com.pahana.bookshop.model.Customer) session.getAttribute("customer")).getId()
            );
            request.setAttribute("books", books);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/customer-dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/customer-dashboard.jsp").forward(request, response);
        }
    }
}