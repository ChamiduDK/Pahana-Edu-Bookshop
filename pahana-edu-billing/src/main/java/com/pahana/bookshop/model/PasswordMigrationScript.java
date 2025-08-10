package com.pahana.bookshop.model;

import com.pahana.bookshop.dao.UserDAO;
import com.pahana.bookshop.model.User;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.SQLException;
import java.util.List;

public class PasswordMigrationScript {
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        try {
            // Fetch all users
            List<User> users = userDAO.findAll();
            for (User user : users) {
                String plaintextPassword = user.getPassword();
                // Check if password is already hashed (BCrypt hashes start with $2a$ or $2b$)
                if (!plaintextPassword.startsWith("$2a$") && !plaintextPassword.startsWith("$2b$")) {
                    // Hash the plaintext password
                    String hashedPassword = BCrypt.hashpw(plaintextPassword, BCrypt.gensalt());
                    // Update the password in the database
                    userDAO.updatePassword(user.getId(), hashedPassword);
                    System.out.println("Updated password for user: " + user.getUsername());
                }
            }
            System.out.println("Password migration completed.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Migration failed: " + e.getMessage());
        }
    }
}