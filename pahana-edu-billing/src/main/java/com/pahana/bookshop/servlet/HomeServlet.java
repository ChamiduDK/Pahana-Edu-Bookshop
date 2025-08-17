package com.pahana.bookshop.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.bookshop.dao.BookDAO;
import com.pahana.bookshop.model.Book;

@WebServlet(name = "HomeServlet", urlPatterns = {"/", "/index.jsp"})
public class HomeServlet extends HttpServlet {
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch all books (including those with stock_quantity = 0 for display)
            List<Book> books = bookDAO.findAll();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load books: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}