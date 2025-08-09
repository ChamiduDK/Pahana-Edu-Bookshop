package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private BookService bookService;

    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.bookService = serviceFactory.createBookService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            request.setAttribute("error", "Please log in to view your cart");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cart", cartItems);
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            request.setAttribute("error", "Please log in to modify your cart");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cart", cartItems);
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Book book = bookService.getBookById(bookId); // Updated method name
                if (book == null) {
                    request.setAttribute("error", "Book not found");
                } else if (quantity <= 0 || quantity > book.getStockQuantity()) {
                    request.setAttribute("error", "Invalid quantity for " + book.getTitle());
                } else {
                    OrderItem item = cartItems.stream()
                            .filter(i -> i.getBookId() == bookId)
                            .findFirst()
                            .orElse(null);
                    if (item != null) {
                        int newQuantity = item.getQuantity() + quantity;
                        if (newQuantity > book.getStockQuantity()) {
                            request.setAttribute("error", "Not enough stock for " + book.getTitle());
                        } else {
                            item.setQuantity(newQuantity);
                            request.setAttribute("success", "Updated " + book.getTitle() + " in cart");
                        }
                    } else {
                        item = new OrderItem();
                        item.setBookId(bookId);
                        item.setQuantity(quantity);
                        item.setUnitPrice(book.getPrice());
                        item.setBook(book);
                        cartItems.add(item);
                        request.setAttribute("success", "Added " + book.getTitle() + " to cart");
                    }
                }
            } else if ("update".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Book book = bookService.getBookById(bookId); // Updated method name
                if (book == null) {
                    request.setAttribute("error", "Book not found");
                } else if (quantity <= 0 || quantity > book.getStockQuantity()) {
                    request.setAttribute("error", "Invalid quantity for " + book.getTitle());
                } else {
                    OrderItem item = cartItems.stream()
                            .filter(i -> i.getBookId() == bookId)
                            .findFirst()
                            .orElse(null);
                    if (item != null) {
                        item.setQuantity(quantity);
                        request.setAttribute("success", "Updated quantity for " + book.getTitle());
                    } else {
                        request.setAttribute("error", "Item not found in cart");
                    }
                }
            } else if ("remove".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                OrderItem item = cartItems.stream()
                        .filter(i -> i.getBookId() == bookId)
                        .findFirst()
                        .orElse(null);
                if (item != null) {
                    cartItems.remove(item);
                    request.setAttribute("success", "Removed " + item.getBook().getTitle() + " from cart");
                } else {
                    request.setAttribute("error", "Item not found in cart");
                }
            }

            session.setAttribute("cart", cartItems);
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input: " + e.getMessage());
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
}