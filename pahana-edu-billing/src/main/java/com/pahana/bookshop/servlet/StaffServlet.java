package com.pahana.bookshop.servlet;

import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "StaffServlet", urlPatterns = {"/staff"})
public class StaffServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (!currentUser.isAdmin()) {
            request.setAttribute("error", "Access denied. Admin privileges required.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    listStaff(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStaff(request, response);
                    break;
                case "view":
                    viewStaff(request, response);
                    break;
                default:
                    listStaff(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (!currentUser.isAdmin()) {
            request.setAttribute("error", "Access denied. Admin privileges required.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "add";

        try {
            switch (action) {
                case "add":
                    addStaff(request, response);
                    break;
                case "update":
                    updateStaff(request, response);
                    break;
                case "updatePassword":
                    updatePassword(request, response);
                    break;
                default:
                    listStaff(request, response);
                    break;
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/staff.jsp").forward(request, response);
        }
    }

    private void listStaff(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<User> staffList = userService.getStaffUsers();
        int totalStaff = userService.getTotalStaffCount();
        int totalUsers = userService.getTotalUserCount();
        
        request.setAttribute("staffList", staffList);
        request.setAttribute("totalStaff", totalStaff);
        request.setAttribute("totalUsers", totalUsers);
        
        request.getRequestDispatcher("/WEB-INF/views/staff.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("action", "add");
        request.getRequestDispatcher("/WEB-INF/views/staff-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int staffId = Integer.parseInt(request.getParameter("id"));
        User staff = userService.getUserById(staffId);
        
        if (staff == null) {
            request.setAttribute("error", "Staff member not found.");
            listStaff(request, response);
            return;
        }
        
        if (!staff.isStaff()) {
            request.setAttribute("error", "User is not a staff member.");
            listStaff(request, response);
            return;
        }
        
        request.setAttribute("staff", staff);
        request.setAttribute("action", "edit");
        request.getRequestDispatcher("/WEB-INF/views/staff-form.jsp").forward(request, response);
    }

    private void viewStaff(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int staffId = Integer.parseInt(request.getParameter("id"));
        User staff = userService.getUserById(staffId);
        
        if (staff == null) {
            request.setAttribute("error", "Staff member not found.");
            listStaff(request, response);
            return;
        }
        
        request.setAttribute("staff", staff);
        request.getRequestDispatcher("/WEB-INF/views/staff-view.jsp").forward(request, response);
    }

    private void addStaff(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        try {
            boolean success = userService.createStaff(username, password, email, currentUser);
            
            if (success) {
                request.setAttribute("success", "Staff member added successfully!");
            } else {
                request.setAttribute("error", "Failed to add staff member.");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("action", "add");
            request.getRequestDispatcher("/WEB-INF/views/staff-form.jsp").forward(request, response);
            return;
        }
        
        listStaff(request, response);
    }

    private void updateStaff(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int staffId = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        User staff = userService.getUserById(staffId);
        if (staff == null) {
            request.setAttribute("error", "Staff member not found.");
            listStaff(request, response);
            return;
        }
        
        staff.setUsername(username);
        staff.setEmail(email);
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        try {
            boolean success = userService.updateUser(staff, currentUser);
            
            if (success) {
                request.setAttribute("success", "Staff member updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update staff member.");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("staff", staff);
            request.setAttribute("action", "edit");
            request.getRequestDispatcher("/WEB-INF/views/staff-form.jsp").forward(request, response);
            return;
        }
        
        listStaff(request, response);
    }

    private void updatePassword(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int staffId = Integer.parseInt(request.getParameter("id"));
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            showEditForm(request, response);
            return;
        }
        
        User currentUser = (User) request.getSession().getAttribute("user");
        
        try {
            boolean success = userService.updatePassword(staffId, newPassword, currentUser);
            
            if (success) {
                request.setAttribute("success", "Password updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update password.");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        }
        
        listStaff(request, response);
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int staffId = Integer.parseInt(request.getParameter("id"));
        User currentUser = (User) request.getSession().getAttribute("user");
        
        try {
            boolean success = userService.deleteUser(staffId, currentUser);
            
            if (success) {
                request.setAttribute("success", "Staff member deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete staff member.");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
        }
        
        listStaff(request, response);
    }
}