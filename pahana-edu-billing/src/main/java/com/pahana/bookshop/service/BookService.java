package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.BookDAO;
import com.pahana.bookshop.model.Book;

import java.sql.SQLException;
import java.util.List;

public class BookService {
    private BookDAO bookDAO;
    
    public BookService() {
        this.bookDAO = new BookDAO();
    }
    
    public boolean addBook(Book book) throws SQLException {
        validateBook(book);
        return bookDAO.create(book);
    }
    
    public Book getBookById(int id) throws SQLException {
        return bookDAO.findById(id);
    }
    
    public List<Book> getAllBooks() throws SQLException {
        return bookDAO.findAll();
    }
    
    public boolean updateBook(Book book) throws SQLException {
        validateBook(book);
        return bookDAO.update(book);
    }
    
    public boolean deleteBook(int id) throws SQLException {
        return bookDAO.delete(id);
    }
    
    public boolean updateStock(int bookId, int newQuantity) throws SQLException {
        if (newQuantity < 0) {
            throw new IllegalArgumentException("Stock quantity cannot be negative");
        }
        return bookDAO.updateStock(bookId, newQuantity);
    }
    
    private void validateBook(Book book) {
        if (book == null) {
            throw new IllegalArgumentException("Book cannot be null");
        }
        if (book.getTitle() == null || book.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Book title is required");
        }
        if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
            throw new IllegalArgumentException("Book author is required");
        }
        if (book.getPrice() == null || book.getPrice().compareTo(java.math.BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Book price must be greater than zero");
        }
        if (book.getStockQuantity() < 0) {
            throw new IllegalArgumentException("Stock quantity cannot be negative");
        }
    }
}