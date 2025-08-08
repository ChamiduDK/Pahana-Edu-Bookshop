package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.UserDAO;
import com.pahana.bookshop.model.User;

import java.sql.SQLException;
import java.util.List;
import java.util.regex.Pattern;

public class UserService {
    private UserDAO userDAO;
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

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

    public User getUserByUsername(String username) throws SQLException {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return userDAO.findByUsername(username.trim());
    }

    public User getUserByEmail(String email) throws SQLException {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }
        return userDAO.findByEmail(email.trim());
    }

    public boolean createUser(User user) throws SQLException {
        validateUser(user);
        
        // Check if username already exists
        if (getUserByUsername(user.getUsername()) != null) {
            throw new IllegalArgumentException("Username already exists");
        }
        
        // Check if email already exists
        if (getUserByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        return userDAO.create(user);
    }

    public boolean createStaff(String username, String password, String email, User createdBy) 
            throws SQLException {
        
        // Only admins can create staff
        if (createdBy == null || !createdBy.isAdmin()) {
            throw new IllegalArgumentException("Only administrators can create staff accounts");
        }
        
        User staff = new User(username, password, email, "STAFF");
        return createUser(staff);
    }

    public boolean updateUser(User user, User updatedBy) throws SQLException {
        if (updatedBy == null || !updatedBy.isAdmin()) {
            throw new IllegalArgumentException("Only administrators can update user accounts");
        }
        
        validateUserForUpdate(user);
        
        // Check if new username conflicts (excluding current user)
        User existingUser = getUserByUsername(user.getUsername());
        if (existingUser != null && existingUser.getId() != user.getId()) {
            throw new IllegalArgumentException("Username already exists");
        }
        
        // Check if new email conflicts (excluding current user)
        existingUser = getUserByEmail(user.getEmail());
        if (existingUser != null && existingUser.getId() != user.getId()) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        return userDAO.update(user);
    }

    public boolean deleteUser(int userId, User deletedBy) throws SQLException {
        if (deletedBy == null || !deletedBy.isAdmin()) {
            throw new IllegalArgumentException("Only administrators can delete user accounts");
        }
        
        User userToDelete = getUserById(userId);
        if (userToDelete == null) {
            throw new IllegalArgumentException("User not found");
        }
        
        if (userToDelete.isAdmin()) {
            throw new IllegalArgumentException("Cannot delete administrator accounts");
        }
        
        if (userToDelete.getId() == deletedBy.getId()) {
            throw new IllegalArgumentException("Cannot delete your own account");
        }
        
        return userDAO.delete(userId);
    }

    public boolean updatePassword(int userId, String newPassword, User updatedBy) throws SQLException {
        if (updatedBy == null) {
            throw new IllegalArgumentException("User must be logged in to update password");
        }
        
        // Users can update their own password, or admins can update any password
        if (userId != updatedBy.getId() && !updatedBy.isAdmin()) {
            throw new IllegalArgumentException("You can only update your own password");
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        
        if (newPassword.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long");
        }
        
        return userDAO.updatePassword(userId, newPassword);
    }

    public List<User> getAllUsers() throws SQLException {
        return userDAO.findAll();
    }

    public List<User> getStaffUsers() throws SQLException {
        return userDAO.findByRole("STAFF");
    }

    public List<User> getAdminUsers() throws SQLException {
        return userDAO.findByRole("ADMIN");
    }

    public int getTotalStaffCount() throws SQLException {
        return userDAO.getTotalStaffCount();
    }

    public int getTotalUserCount() throws SQLException {
        return userDAO.getTotalUserCount();
    }

    private void validateUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        
        if (user.getUsername().length() < 3 || user.getUsername().length() > 50) {
            throw new IllegalArgumentException("Username must be between 3 and 50 characters");
        }
        
        if (!user.getUsername().matches("^[a-zA-Z0-9_]+$")) {
            throw new IllegalArgumentException("Username can only contain letters, numbers, and underscores");
        }
        
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
        
        if (user.getPassword().length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long");
        }
        
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        
        if (!EMAIL_PATTERN.matcher(user.getEmail()).matches()) {
            throw new IllegalArgumentException("Invalid email format");
        }
        
        if (user.getRole() == null || user.getRole().trim().isEmpty()) {
            throw new IllegalArgumentException("Role is required");
        }
        
        if (!user.getRole().equals("ADMIN") && !user.getRole().equals("STAFF")) {
            throw new IllegalArgumentException("Role must be either ADMIN or STAFF");
        }
    }

    private void validateUserForUpdate(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        
        if (user.getId() <= 0) {
            throw new IllegalArgumentException("Valid user ID is required");
        }
        
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        
        if (user.getUsername().length() < 3 || user.getUsername().length() > 50) {
            throw new IllegalArgumentException("Username must be between 3 and 50 characters");
        }
        
        if (!user.getUsername().matches("^[a-zA-Z0-9_]+$")) {
            throw new IllegalArgumentException("Username can only contain letters, numbers, and underscores");
        }
        
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        
        if (!EMAIL_PATTERN.matcher(user.getEmail()).matches()) {
            throw new IllegalArgumentException("Invalid email format");
        }
        
        if (user.getRole() == null || user.getRole().trim().isEmpty()) {
            throw new IllegalArgumentException("Role is required");
        }
        
        if (!user.getRole().equals("ADMIN") && !user.getRole().equals("STAFF")) {
            throw new IllegalArgumentException("Role must be either ADMIN or STAFF");
        }
    }
}