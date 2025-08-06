package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.UserDAO;
import com.pahana.bookshop.model.User;

import java.sql.SQLException;

public class UserService {
    private UserDAO userDAO;
    
    public UserService() {
        this.userDAO = new UserDAO();
    }
    
    public User authenticate(String username, String password) throws SQLException {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            return null;
        }
        
        return userDAO.authenticate(username.trim(), password);
    }
    
    public User getUserById(int id) throws SQLException {
        return userDAO.findById(id);
    }
    
    public boolean createUser(User user) throws SQLException {
        validateUser(user);
        return userDAO.create(user);
    }
    
    private void validateUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (user.getRole() == null || user.getRole().trim().isEmpty()) {
            throw new IllegalArgumentException("Role is required");
        }
    }
}
