package com.pahana.bookshop.filter;

import com.pahana.bookshop.model.User;
import com.pahana.bookshop.model.Customer;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
    "/dashboard/*",
    "/customers/*",
    "/orders/*",
    "/books/*",
    "/customer-dashboard",
    "/customer-orders",
    "/customer-profile",
    "/cart",
    "/checkout",
    "/register"
})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String path = httpRequest.getServletPath();

        // Allow public access
        if (path.equals("/login") || path.equals("/login.jsp") || path.equals("/customer-logout") || 
            path.equals("/register") || path.equals("/index.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Admin/staff URLs
        if (path.startsWith("/dashboard") || path.startsWith("/customers") ||
            path.startsWith("/orders") || path.startsWith("/books")) {
            User user = (session != null) ? (User) session.getAttribute("user") : null;
            if (user == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                return;
            }
        }
        // Customer URLs
        else if (path.equals("/customer-dashboard") || path.equals("/customer-orders") ||
                 path.equals("/customer-profile") || path.equals("/cart") || path.equals("/checkout")) {
            Customer customer = (session != null) ? (Customer) session.getAttribute("customer") : null;
            if (customer == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}