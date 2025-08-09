package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Cart;
import com.pahana.bookshop.model.CartItem;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private BookService bookService;

    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.bookService = serviceFactory.createBookService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        // Ensure customer is logged in
        if (session.getAttribute("customer") == null) {
            request.setAttribute("error", "Please log in to add items to your cart");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if ("add".equals(action)) {
            String bookIdStr = request.getParameter("bookId");
            String quantityStr = request.getParameter("quantity");

            try {
                int bookId = Integer.parseInt(bookIdStr);
                int quantity = Integer.parseInt(quantityStr);

                // Validate quantity
                if (quantity <= 0) {
                    request.setAttribute("error", "Invalid quantity");
                    request.getRequestDispatcher("/customer-dashboard").forward(request, response);
                    return;
                }

                // Get book details
                Book book = bookService.getBookById(bookId);
                if (book == null) {
                    request.setAttribute("error", "Book not found");
                    request.getRequestDispatcher("/customer-dashboard").forward(request, response);
                    return;
                }

                // Check stock
                if (book.getStockQuantity() < quantity) {
                    request.setAttribute("error", "Insufficient stock for " + book.getTitle());
                    request.getRequestDispatcher("/customer-dashboard").forward(request, response);
                    return;
                }

                // Get or create cart
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    cart = new Cart();
                    session.setAttribute("cart", cart);
                }

                // Add item to cart
                cart.addItem(new CartItem(book, quantity));
                request.setAttribute("success", "Book added to cart successfully");
                request.getRequestDispatcher("/customer-dashboard").forward(request, response);

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid input format");
                request.getRequestDispatcher("/customer-dashboard").forward(request, response);
            } catch (SQLException e) {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("/customer-dashboard").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Display cart (forward to cart.jsp)
        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            request.setAttribute("error", "Please log in to view your cart");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}