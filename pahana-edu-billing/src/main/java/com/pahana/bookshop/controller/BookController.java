package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.service.BookService;
import com.pahana.bookshop.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/books")
public class BookController extends HttpServlet {
    private BookService bookService;
    
    @Override
    public void init() throws ServletException {
        ServiceFactory serviceFactory = ServiceFactory.getInstance();
        this.bookService = serviceFactory.createBookService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("search".equals(action)) {
                handleSearch(request, response);
            } else if ("edit".equals(action)) {
                handleEdit(request, response);
            } else if ("view".equals(action)) {
                handleView(request, response);
            } else if ("lowStock".equals(action)) {
                handleLowStock(request, response);
            } else {
                handleList(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/books.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                handleAdd(request, response);
            } else if ("update".equals(action)) {
                handleUpdate(request, response);
            } else if ("delete".equals(action)) {
                handleDelete(request, response);
            } else if ("updateStock".equals(action)) {
                handleUpdateStock(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/books.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/books.jsp").forward(request, response);
        }
    }
    
    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Book> books = bookService.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/books.jsp").forward(request, response);
    }
    
    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        String category = request.getParameter("category");
        
        List<Book> books = bookService.getAllBooks();
        
        // Filter books based on search criteria
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            String searchLower = searchTerm.toLowerCase().trim();
            books = books.stream()
                .filter(book -> 
                    book.getTitle().toLowerCase().contains(searchLower) ||
                    book.getAuthor().toLowerCase().contains(searchLower) ||
                    (book.getIsbn() != null && book.getIsbn().toLowerCase().contains(searchLower))
                )
                .collect(java.util.stream.Collectors.toList());
        }
        
        if (category != null && !category.trim().isEmpty() && !"all".equals(category)) {
            books = books.stream()
                .filter(book -> category.equalsIgnoreCase(book.getCategory()))
                .collect(java.util.stream.Collectors.toList());
        }
        
        request.setAttribute("books", books);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("selectedCategory", category);
        request.getRequestDispatcher("/books.jsp").forward(request, response);
    }
    
    private void handleLowStock(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int threshold = 10; // Default low stock threshold
        String thresholdParam = request.getParameter("threshold");
        
        if (thresholdParam != null && !thresholdParam.trim().isEmpty()) {
            try {
                threshold = Integer.parseInt(thresholdParam);
            } catch (NumberFormatException e) {
                threshold = 10; // Use default if invalid number
            }
        }
        
        List<Book> allBooks = bookService.getAllBooks();
        final int finalThreshold = threshold;
        
        List<Book> lowStockBooks = allBooks.stream()
            .filter(book -> book.getStockQuantity() <= finalThreshold)
            .sorted((b1, b2) -> Integer.compare(b1.getStockQuantity(), b2.getStockQuantity()))
            .collect(java.util.stream.Collectors.toList());
        
        request.setAttribute("books", lowStockBooks);
        request.setAttribute("lowStockView", true);
        request.setAttribute("threshold", threshold);
        request.getRequestDispatcher("/books.jsp").forward(request, response);
    }
    
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        
        try {
            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            
            Book book = new Book(title, author, isbn, price, stockQuantity, category, description);
            boolean success = bookService.addBook(book);
            
            if (success) {
                request.setAttribute("success", "Book added successfully!");
            } else {
                request.setAttribute("error", "Failed to add book.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or stock quantity format.");
        }
        
        handleList(request, response);
    }
    
    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookService.getBookById(bookId);
        request.setAttribute("editBook", book);
        handleList(request, response);
    }
    
    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookService.getBookById(bookId);
        request.setAttribute("viewBook", book);
        request.getRequestDispatcher("/book-details.jsp").forward(request, response);
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        
        try {
            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            
            Book book = bookService.getBookById(id);
            book.setTitle(title);
            book.setAuthor(author);
            book.setIsbn(isbn);
            book.setPrice(price);
            book.setStockQuantity(stockQuantity);
            book.setCategory(category);
            book.setDescription(description);
            
            boolean success = bookService.updateBook(book);
            
            if (success) {
                request.setAttribute("success", "Book updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update book.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or stock quantity format.");
        }
        
        handleList(request, response);
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        boolean success = bookService.deleteBook(bookId);
        
        if (success) {
            request.setAttribute("success", "Book deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete book. It may be referenced in orders.");
        }
        
        handleList(request, response);
    }
    
    private void handleUpdateStock(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));
        String operation = request.getParameter("operation");
        
        Book book = bookService.getBookById(bookId);
        if (book == null) {
            request.setAttribute("error", "Book not found.");
            handleList(request, response);
            return;
        }
        
        int finalQuantity = newQuantity;
        
        if ("add".equals(operation)) {
            finalQuantity = book.getStockQuantity() + newQuantity;
        } else if ("subtract".equals(operation)) {
            finalQuantity = book.getStockQuantity() - newQuantity;
            if (finalQuantity < 0) {
                request.setAttribute("error", "Cannot reduce stock below zero.");
                handleList(request, response);
                return;
            }
        }
        // If operation is "set", use newQuantity as is
        
        boolean success = bookService.updateStock(bookId, finalQuantity);
        
        if (success) {
            String message = "Stock updated successfully! ";
            if ("add".equals(operation)) {
                message += "Added " + newQuantity + " units.";
            } else if ("subtract".equals(operation)) {
                message += "Removed " + newQuantity + " units.";
            } else {
                message += "Set to " + finalQuantity + " units.";
            }
            request.setAttribute("success", message);
        } else {
            request.setAttribute("error", "Failed to update stock.");
        }
        
        handleList(request, response);
    }
}