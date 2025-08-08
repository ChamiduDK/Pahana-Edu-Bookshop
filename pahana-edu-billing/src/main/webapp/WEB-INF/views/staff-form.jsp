<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Staff - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --dark-gradient: linear-gradient(135deg, #434343 0%, #000000 100%);
            
            --primary-color: #667eea;
            --secondary-color: #f093fb;
            --success-color: #4facfe;
            --warning-color: #43e97b;
            --danger-color: #fa709a;
            --dark-color: #2d3748;
            --light-color: #f7fafc;
            
            --sidebar-width: 320px;
            --topbar-height: 80px;
            --border-radius: 24px;
            --shadow-light: 0 4px 25px rgba(0, 0, 0, 0.08);
            --shadow-medium: 0 8px 50px rgba(0, 0, 0, 0.12);
            --shadow-heavy: 0 20px 80px rgba(0, 0, 0, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-attachment: fixed;
            color: #2d3748;
            overflow-x: hidden;
        }

        /* Sidebar Styles (same as main page) */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            z-index: 1000;
            overflow-y: auto;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-medium);
        }

        .sidebar-header {
            padding: 2rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 800;
            text-decoration: none;
            color: var(--dark-color);
            position: relative;
        }

        .brand-icon {
            width: 60px;
            height: 60px;
            background: var(--primary-gradient);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-right: 1rem;
            box-shadow: var(--shadow-light);
        }

        .brand-text {
            display: flex;
            flex-direction: column;
        }

        .brand-title {
            font-size: 1.25rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .brand-subtitle {
            font-size: 0.75rem;
            color: #64748b;
            font-weight: 500;
        }

        .sidebar-nav {
            padding: 1.5rem 0;
        }

        .nav-section {
            padding: 0 2rem;
            margin-bottom: 2rem;
        }

        .nav-section-title {
            font-size: 0.75rem;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 1rem;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            color: #64748b;
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            position: relative;
            overflow: hidden;
            margin: 0 1rem;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .nav-link:hover, .nav-link.active {
            color: white;
            transform: translateX(8px) scale(1.02);
            box-shadow: var(--shadow-light);
        }

        .nav-link:hover::before, .nav-link.active::before {
            left: 0;
        }

        .nav-link i {
            width: 24px;
            margin-right: 1rem;
            font-size: 1.2rem;
            transition: transform 0.3s ease;
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            background: rgba(247, 250, 252, 0.8);
            backdrop-filter: blur(20px);
        }

        .topbar {
            height: var(--topbar-height);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: var(--shadow-light);
            padding: 0 2.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        .topbar-title h4 {
            margin: 0;
            font-weight: 800;
            color: var(--dark-color);
            font-size: 1.5rem;
        }

        .topbar-subtitle {
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .back-btn {
            color: #64748b;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .back-btn:hover {
            color: var(--primary-color);
            transform: translateX(-3px);
        }

        .content-area {
            padding: 2.5rem;
        }

        /* Form Styles */
        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 3rem;
            box-shadow: var(--shadow-light);
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: var(--warning-gradient);
        }

        .form-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .form-icon {
            width: 80px;
            height: 80px;
            background: var(--warning-gradient);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            box-shadow: var(--shadow-light);
        }

        .form-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: #64748b;
            font-size: 1rem;
        }

        .staff-info-banner {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 4px solid var(--warning-color);
        }

        .staff-info-banner h6 {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .staff-info-banner p {
            color: #64748b;
            margin: 0;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 1rem 1.5rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8fafc;
            font-weight: 500;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--warning-color);
            box-shadow: 0 0 0 0.2rem rgba(67, 233, 123, 0.15);
            background: white;
            outline: none;
        }

        .form-control::placeholder {
            color: #94a3b8;
            font-weight: 400;
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            z-index: 5;
        }

        .form-control.has-icon {
            padding-left: 3.5rem;
        }

        .form-text {
            color: #64748b;
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .password-toggle {
            position: absolute;
            right: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #64748b;
            cursor: pointer;
            padding: 0;
            z-index: 5;
        }

        .password-toggle:hover {
            color: var(--warning-color);
        }

        .password-section {
            background: #f8fafc;
            border: 2px dashed #e2e8f0;
            border-radius: 16px;
            padding: 2rem;
            margin: 2rem 0;
        }

        .password-section h6 {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .password-section p {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
        }

        /* Button Styles */
        .btn-group-custom {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 3rem;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 1rem 2.5rem;
            border-radius: var(--border-radius);
            font-weight: 700;
            font-size: 1rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 160px;
            justify-content: center;
        }

        .btn-warning-custom {
            background: var(--warning-gradient);
            color: white;
            box-shadow: var(--shadow-light);
        }

        .btn-warning-custom:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
            color: white;
        }

        .btn-secondary-custom {
            background: #e2e8f0;
            color: #64748b;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary-custom:hover {
            background: #cbd5e0;
            color: #4a5568;
            transform: translateY(-2px);
        }

        .btn-danger-custom {
            background: var(--danger-gradient);
            color: white;
            box-shadow: var(--shadow-light);
        }

        .btn-danger-custom:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
            color: white;
        }

        /* Role Badge */
        .current-role-badge {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: var(--success-gradient);
            color: white;
            border-radius: 16px;
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-left: 1rem;
        }

        /* Validation Styles */
        .is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.15) !important;
        }

        .invalid-feedback {
            display: block;
            color: #dc3545;
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .is-valid {
            border-color: #28a745 !important;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15) !important;
        }

        .valid-feedback {
            display: block;
            color: #28a745;
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Loading Animation */
        .loading {
            opacity: 0;
            animation: fadeInUp 0.6s ease-out forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Mobile Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 9999;
                width: 320px;
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .topbar {
                padding: 0 1.5rem;
            }

            .content-area {
                padding: 2rem 1.5rem;
            }

            .form-card {
                padding: 2rem;
            }

            .form-title {
                font-size: 1.5rem;
            }

            .btn-group-custom {
                flex-direction: column;
            }

            .btn-custom {
                min-width: auto;
            }

            .current-role-badge {
                margin-left: 0;
                margin-top: 0.5rem;
                display: block;
                text-align: center;
            }
        }

        @media (max-width: 768px) {
            .topbar {
                height: auto;
                padding: 1rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .content-area {
                padding: 1.5rem 1rem;
            }

            .form-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-brand">
                <div class="brand-icon">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <div class="brand-text">
                    <div class="brand-title">Pahana Edu</div>
                    <div class="brand-subtitle">Bookshop Management</div>
                </div>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <div class="nav-section">
                <div class="nav-section-title">Main Menu</div>
                <div class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-chart-pie"></i>
                        Dashboard
                    </a>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customers">
                        <i class="fas fa-users"></i>
                        Customers
                    </a>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/orders">
                        <i class="fas fa-shopping-bag"></i>
                        Orders
                    </a>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/books">
                        <i class="fas fa-book-open"></i>
                        Books
                    </a>
                </div>
                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                    <div class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/staff">
                            <i class="fas fa-user-tie"></i>
                            Staff Management
                        </a>
                    </div>
                </c:if>
            </div>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-title">
                <h4>Edit Staff Member</h4>
                <div class="topbar-subtitle">Update staff member information and permissions</div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/staff" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Staff List
                </a>
                <button class="btn btn-link d-md-none" onclick="toggleSidebar()">
                    <i class="fas fa-bars fa-lg"></i>
                </button>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <div class="form-container loading">
                <!-- Alert Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Form Card -->
                <div class="form-card">
                    <div class="form-header">
                        <div class="form-icon">
                            <i class="fas fa-user-edit"></i>
                        </div>
                        <h2 class="form-title">Edit Staff Member</h2>
                        <p class="form-subtitle">Update the information for this staff member</p>
                    </div>

                    <!-- Staff Info Banner -->
                    <div class="staff-info-banner">
                        <h6>
                            <i class="fas fa-user-circle"></i>
                            Currently Editing: ${staff.username}
                            <span class="current-role-badge">${staff.role}</span>
                        </h6>
                        <p>
                            Member since: <fmt:formatDate value="${staff.createdAt}" pattern="MMMM dd, yyyy"/> • 
                            Last updated: <fmt:formatDate value="${staff.updatedAt}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                        </p>
                    </div>

                    <form action="${pageContext.request.contextPath}/staff" method="post" id="editStaffForm" novalidate>
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${staff.id}">
                        
                        <!-- Username Field -->
                        <div class="form-group">
                            <label for="username" class="form-label">
                                <i class="fas fa-user"></i>
                                Username
                            </label>
                            <div class="input-group">
                                <i class="fas fa-user input-icon"></i>
                                <input type="text" class="form-control has-icon" id="username" name="username" 
                                       value="${staff.username}" placeholder="Enter username" required>
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle"></i>
                                Username must be unique and at least 3 characters long
                            </div>
                            <div class="invalid-feedback" id="usernameError"></div>
                        </div>

                        <!-- Email Field -->
                        <div class="form-group">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope"></i>
                                Email Address
                            </label>
                            <div class="input-group">
                                <i class="fas fa-envelope input-icon"></i>
                                <input type="email" class="form-control has-icon" id="email" name="email" 
                                       value="${staff.email}" placeholder="Enter email address" required>
                            </div>
                            <div class="form-text">
                                <i class="fas fa-info-circle"></i>
                                This email will be used for login and notifications
                            </div>
                            <div class="invalid-feedback" id="emailError"></div>
                        </div>

                        <!-- Password Change Section -->
                        <div class="password-section">
                            <h6>
                                <i class="fas fa-key"></i>
                                Change Password (Optional)
                            </h6>
                            <p>Leave the password fields empty if you don't want to change the current password.</p>
                            
                            <!-- New Password Field -->
                            <div class="form-group mb-3">
                                <label for="newPassword" class="form-label">
                                    <i class="fas fa-lock"></i>
                                    New Password
                                </label>
                                <div class="input-group">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" class="form-control has-icon" id="newPassword" name="newPassword" 
                                           placeholder="Enter new password (optional)">
                                    <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                                        <i class="fas fa-eye" id="newPasswordToggleIcon"></i>
                                    </button>
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-shield-alt"></i>
                                    Password must be at least 6 characters long
                                </div>
                                <div class="invalid-feedback" id="newPasswordError"></div>
                            </div>

                            <!-- Confirm New Password Field -->
                            <div class="form-group mb-0">
                                <label for="confirmNewPassword" class="form-label">
                                    <i class="fas fa-check-circle"></i>
                                    Confirm New Password
                                </label>
                                <div class="input-group">
                                    <i class="fas fa-check-circle input-icon"></i>
                                    <input type="password" class="form-control has-icon" id="confirmNewPassword" 
                                           name="confirmNewPassword" placeholder="Confirm new password">
                                    <button type="button" class="password-toggle" onclick="togglePassword('confirmNewPassword')">
                                        <i class="fas fa-eye" id="confirmNewPasswordToggleIcon"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback" id="confirmNewPasswordError"></div>
                            </div>
                        </div>

                        <!-- Role Field -->
                        <div class="form-group">
                            <label for="role" class="form-label">
                                <i class="fas fa-user-tag"></i>
                                Role
                            </label>
                            <select class="form-select" id="role" name="role" required>
                                <option value="">Select Role</option>
                                <option value="STAFF" ${staff.role eq 'STAFF' ? 'selected' : ''}>Staff Member</option>
                                <option value="ADMIN" ${staff.role eq 'ADMIN' ? 'selected' : ''}>Administrator</option>
                            </select>
                            <div class="form-text">
                                <i class="fas fa-info-circle"></i>
                                Staff members have limited access, Administrators have full access
                            </div>
                            <div class="invalid-feedback" id="roleError"></div>
                        </div>

                        <!-- Form Buttons -->
                        <div class="btn-group-custom">
                            <button type="submit" class="btn-custom btn-warning-custom">
                                <i class="fas fa-save"></i>
                                Update Staff Member
                            </button>
                            <a href="${pageContext.request.contextPath}/staff" class="btn-custom btn-secondary-custom">
                                <i class="fas fa-times"></i>
                                Cancel
                            </a>
                            <button type="button" class="btn-custom btn-danger-custom" onclick="confirmDelete(${staff.id}, '${staff.username}')">
                                <i class="fas fa-trash"></i>
                                Delete Staff
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: var(--border-radius);">
                <div class="modal-header border-0">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-danger"></i>
                        Confirm Delete
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete staff member <strong id="staffNameToDelete"></strong>?</p>
                    <p class="text-danger small">
                        <i class="fas fa-warning"></i>
                        This action cannot be undone and will permanently remove all associated data.
                    </p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Permanently
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
            
            if (sidebar.classList.contains('show')) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = 'auto';
            }
        }

        // Password toggle functionality
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = document.getElementById(fieldId + 'ToggleIcon');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.className = 'fas fa-eye-slash';
            } else {
                field.type = 'password';
                icon.className = 'fas fa-eye';
            }
        }

        // Confirm delete function
        function confirmDelete(staffId, staffName) {
            document.getElementById('staffNameToDelete').textContent = staffName;
            document.getElementById('confirmDeleteBtn').href = 
                '${pageContext.request.contextPath}/staff?action=delete&id=' + staffId;
            
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            deleteModal.show();
        }

        // Form validation
        document.getElementById('editStaffForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            let isValid = true;
            
            // Reset all validation states
            const fields = ['username', 'email', 'newPassword', 'confirmNewPassword', 'role'];
            fields.forEach(field => {
                const element = document.getElementById(field);
                if (element) {
                    element.classList.remove('is-invalid', 'is-valid');
                    const errorElement = document.getElementById(field + 'Error');
                    if (errorElement) {
                        errorElement.textContent = '';
                    }
                }
            });
            
            // Username validation
            const username = document.getElementById('username').value.trim();
            if (username.length < 3) {
                showError('username', 'Username must be at least 3 characters long');
                isValid = false;
            } else {
                showValid('username');
            }
            
            // Email validation
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showError('email', 'Please enter a valid email address');
                isValid = false;
            } else {
                showValid('email');
            }
            
            // Password validation (only if new password is entered)
            const newPassword = document.getElementById('newPassword').value;
            const confirmNewPassword = document.getElementById('confirmNewPassword').value;
            
            if (newPassword.length > 0) {
                if (newPassword.length < 6) {
                    showError('newPassword', 'Password must be at least 6 characters long');
                    isValid = false;
                } else {
                    showValid('newPassword');
                }
                
                if (newPassword !== confirmNewPassword) {
                    showError('confirmNewPassword', 'Passwords do not match');
                    isValid = false;
                } else if (confirmNewPassword.length > 0) {
                    showValid('confirmNewPassword');
                }
            } else if (confirmNewPassword.length > 0) {
                showError('newPassword', 'Please enter a new password');
                isValid = false;
            }
            
            // Role validation
            const role = document.getElementById('role').value;
            if (!role) {
                showError('role', 'Please select a role');
                isValid = false;
            } else {
                showValid('role');
            }
            
            if (isValid) {
                // Show loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
                submitBtn.disabled = true;
                
                // Submit form
                this.submit();
            }
        });
        
        function showError(fieldId, message) {
            const field = document.getElementById(fieldId);
            const errorDiv = document.getElementById(fieldId + 'Error');
            
            if (field && errorDiv) {
                field.classList.add('is-invalid');
                errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
            }
        }
        
        function showValid(fieldId) {
            const field = document.getElementById(fieldId);
            if (field) {
                field.classList.add('is-valid');
            }
        }

        // Real-time validation
        document.getElementById('username').addEventListener('input', function() {
            if (this.value.length >= 3) {
                showValid('username');
            }
        });

        document.getElementById('email').addEventListener('input', function() {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (emailRegex.test(this.value)) {
                showValid('email');
            }
        });

        document.getElementById('newPassword').addEventListener('input', function() {
            if (this.value.length >= 6) {
                showValid('newPassword');
            }
        });

        document.getElementById('confirmNewPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            if (this.value === newPassword && this.value.length > 0) {
                showValid('confirmNewPassword');
            }
        });

        // Handle window resize
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            
            if (window.innerWidth > 992) {
                sidebar.classList.remove('show');
                document.body.style.overflow = 'auto';
            }
        });

        // Auto-dismiss alerts
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);

        // Initialize form with current data
        document.addEventListener('DOMContentLoaded', function() {
            // Mark current fields as valid if they have data
            const username = document.getElementById('username');
            const email = document.getElementById('email');
            const role = document.getElementById('role');

            if (username && username.value.length >= 3) {
                showValid('username');
            }
            
            if (email && email.value.includes('@')) {
                showValid('email');
            }
            
            if (role && role.value) {
                showValid('role');
            }
        });
    </script>
</body>
</html>