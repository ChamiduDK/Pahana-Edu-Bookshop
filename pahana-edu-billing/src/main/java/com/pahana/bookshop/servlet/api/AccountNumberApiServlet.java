package com.pahana.bookshop.servlet.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.bookshop.service.CustomerService;

@WebServlet("/api/generate-account-number")
public class AccountNumberApiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CustomerService customerService;
    
    public AccountNumberApiServlet() {
        this.customerService = new CustomerService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            String accountNumber = customerService.generateNewAccountNumber();
            out.print(accountNumber);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("Error generating account number");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("Unexpected error");
        }
    }
}