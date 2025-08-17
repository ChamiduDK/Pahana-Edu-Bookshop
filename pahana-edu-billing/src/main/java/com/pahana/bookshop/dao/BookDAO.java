package com.pahana.bookshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.pahana.bookshop.config.DatabaseConnection;
import com.pahana.bookshop.model.Book;

public class BookDAO {
    private DatabaseConnection dbConnection;

    public BookDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }

    public boolean create(Book book) throws SQLException {
        String sql = "INSERT INTO books (title, author, isbn, price, stock_quantity, category, description) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getIsbn());
            pstmt.setBigDecimal(4, book.getPrice());
            pstmt.setInt(5, book.getStockQuantity());
            pstmt.setString(6, book.getCategory());
            pstmt.setString(7, book.getDescription());

            return pstmt.executeUpdate() > 0;
        }
    }

    public Book findById(int id) throws SQLException {
        String sql = "SELECT * FROM books WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBook(rs);
                }
            }
        }
        return null;
    }

    public List<Book> findAll() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY title";

        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        }
        return books;
    }

    public boolean updateStock(int bookId, int newQuantity) throws SQLException {
        String sql = "UPDATE books SET stock_quantity = ? WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, bookId);

            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean update(Book book) throws SQLException {
        String sql = "UPDATE books SET title = ?, author = ?, isbn = ?, price = ?, stock_quantity = ?, category = ?, description = ? WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getIsbn());
            pstmt.setBigDecimal(4, book.getPrice());
            pstmt.setInt(5, book.getStockQuantity());
            pstmt.setString(6, book.getCategory());
            pstmt.setString(7, book.getDescription());
            pstmt.setInt(8, book.getId());

            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        }
    }

    // New methods for home page functionality
    public List<Book> findFeaturedBooks(int limit) throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE stock_quantity > 0 ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        }
        return books;
    }

    public int getTotalCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM books";

        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Book> searchBooks(String query) throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE " +
                    "(LOWER(title) LIKE LOWER(?) OR " +
                    "LOWER(author) LIKE LOWER(?) OR " +
                    "LOWER(category) LIKE LOWER(?) OR " +
                    "LOWER(description) LIKE LOWER(?)) " +
                    "ORDER BY " +
                    "CASE " +
                        "WHEN LOWER(title) LIKE LOWER(?) THEN 1 " +
                        "WHEN LOWER(author) LIKE LOWER(?) THEN 2 " +
                        "WHEN LOWER(category) LIKE LOWER(?) THEN 3 " +
                        "ELSE 4 " +
                    "END, title";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";

            // Set parameters for WHERE clause
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            pstmt.setString(4, searchPattern);

            // Set parameters for ORDER BY clause
            pstmt.setString(5, searchPattern);
            pstmt.setString(6, searchPattern);
            pstmt.setString(7, searchPattern);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        }
        return books;
    }

    public List<Book> findByCategory(String category) throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE LOWER(category) = LOWER(?) ORDER BY title";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        }
        return books;
    }

    public List<String> findAllCategories() throws SQLException {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM books WHERE category IS NOT NULL AND category != '' ORDER BY category";

        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String category = rs.getString("category");
                if (category != null && !category.trim().isEmpty()) {
                    categories.add(category);
                }
            }
        }
        return categories;
    }

    public List<Book> findAvailableBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE stock_quantity > 0 ORDER BY title";

        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        }
        return books;
    }

    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setIsbn(rs.getString("isbn"));
        book.setPrice(rs.getBigDecimal("price"));
        book.setStockQuantity(rs.getInt("stock_quantity"));
        book.setCategory(rs.getString("category"));
        book.setDescription(rs.getString("description"));
        book.setCreatedAt(rs.getTimestamp("created_at"));
        book.setUpdatedAt(rs.getTimestamp("updated_at"));
        return book;
    }
}