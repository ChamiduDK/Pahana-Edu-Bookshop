<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .login-container {
            min-height: 100vh;
            display: flex;
        }

        .image-section {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .image-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><radialGradient id="grad1" cx="50%" cy="50%" r="50%"><stop offset="0%" style="stop-color:rgba(255,255,255,0.1);stop-opacity:1" /><stop offset="100%" style="stop-color:rgba(255,255,255,0);stop-opacity:1" /></radialGradient></defs><circle cx="200" cy="200" r="100" fill="url(%23grad1)"/><circle cx="800" cy="300" r="150" fill="url(%23grad1)"/><circle cx="400" cy="700" r="120" fill="url(%23grad1)"/><circle cx="700" cy="800" r="80" fill="url(%23grad1)"/></svg>');
            opacity: 0.3;
        }

        .hero-content {
            text-align: center;
            color: white;
            z-index: 2;
            max-width: 600px;
            padding: 0 2rem;
        }

        .hero-icon {
            width: 120px;
            height: 120px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .hero-icon i {
            font-size: 3rem;
            color: white;
        }

        .hero-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .hero-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .feature-list {
            list-style: none;
            text-align: left;
        }

        .feature-list li {
            padding: 0.5rem 0;
            opacity: 0.8;
        }

        .feature-list i {
            margin-right: 0.8rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .form-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background: white;
        }

        .form-container {
            width: 100%;
            max-width: 480px;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .brand-logo {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
        }

        .brand-logo i {
            font-size: 1.5rem;
            color: white;
        }

        .brand-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .brand-subtitle {
            color: #64748b;
            font-size: 0.95rem;
        }

        .login-form {
            background: white;
            border-radius: 24px;
            padding: 2.5rem;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
            border: 1px solid #f1f5f9;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-control {
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            padding: 0.875rem 1rem;
            font-size: 1rem;
            transition: all 0.2s ease;
            background: #f9fafb;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            z-index: 3;
        }

        .form-control.has-icon {
            padding-left: 2.75rem;
        }

        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            padding: 0.875rem 1.5rem;
            font-weight: 600;
            font-size: 1rem;
            color: white;
            transition: all 0.3s ease;
            text-transform: none;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
        }

        .alert-danger {
            background: #fef2f2;
            color: #dc2626;
            border-left: 4px solid #dc2626;
        }

        .alert-success {
            background: #f0fdf4;
            color: #16a34a;
            border-left: 4px solid #16a34a;
        }

        .nav-tabs {
            border: none;
            margin-bottom: 1.5rem;
        }

        .nav-tabs .nav-link {
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            color: #64748b;
            font-weight: 600;
        }

        .nav-tabs .nav-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .nav-tabs .nav-link:hover {
            color: #667eea;
        }

        .footer-text {
            text-align: center;
            margin-top: 2rem;
            color: #9ca3af;
            font-size: 0.85rem;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            
            .image-section {
                min-height: 40vh;
            }
            
            .hero-title {
                font-size: 2rem;
            }
            
            .hero-content {
                padding: 0 1rem;
            }
            
            .form-section {
                padding: 1rem;
            }
            
            .login-form {
                padding: 2rem 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .image-section {
                min-height: 30vh;
            }
            
            .hero-icon {
                width: 80px;
                height: 80px;
                margin-bottom: 1.5rem;
            }
            
            .hero-icon i {
                font-size: 2rem;
            }
            
            .hero-title {
                font-size: 1.5rem;
            }
            
            .login-form {
                padding: 1.5rem 1rem;
            }
        }

        .btn-login.loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .btn-login.loading::after {
            content: '';
            width: 16px;
            height: 16px;
            margin-left: 8px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            display: inline-block;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Left Image Section -->
        <div class="image-section">
            <div class="hero-content">
                <div class="hero-icon">
                    <i class="fas fa-book-open"></i>
                </div>
                <h1 class="hero-title">Bookshop Management</h1>
                <p class="hero-subtitle">
                    Access your comprehensive bookshop management system or browse our collection as a customer.
                </p>
                <ul class="feature-list">
                    <li><i class="fas fa-check"></i> Inventory & Stock Management</li>
                    <li><i class="fas fa-check"></i> Sales & Order Processing</li>
                    <li><i class="fas fa-check"></i> Customer & Student Records</li>
                    <li><i class="fas fa-check"></i> Easy Book Shopping</li>
                </ul>
            </div>
        </div>

        <!-- Right Form Section -->
        <div class="form-section">
            <div class="form-container">
                <div class="brand-header">
                    <div class="brand-logo">
                        <i class="fas fa-book"></i>
                    </div>
                    <h2 class="brand-title">Pahana Edu Bookshop</h2>
                    <p class="brand-subtitle">Bookshop Management System</p>
                </div>

                <div class="login-form">
                    <!-- Error Alert -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <!-- Success Alert -->
                    <c:if test="${param.logout == 'true'}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle me-2"></i>You have been successfully logged out.
                        </div>
                    </c:if>

                    <!-- Tabs for Admin/Staff and Customer Login -->
                    <ul class="nav nav-tabs" id="loginTabs">
                        <li class="nav-item">
                            <a class="nav-link active" id="admin-tab" data-bs-toggle="tab" href="#admin-login">Admin/Staff</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="customer-tab" data-bs-toggle="tab" href="#customer-login">Customer</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <!-- Admin/Staff Login -->
                        <div class="tab-pane fade show active" id="admin-login">
                            <form method="post" action="${pageContext.request.contextPath}/login" id="adminLoginForm">
                                <input type="hidden" name="loginType" value="admin">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <i class="fas fa-user input-icon"></i>
                                        <input type="text" class="form-control has-icon" 
                                               id="username" name="username" required 
                                               placeholder="Enter your username"
                                               autocomplete="username">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <i class="fas fa-lock input-icon"></i>
                                        <input type="password" class="form-control has-icon" 
                                               id="password" name="password" required 
                                               placeholder="Enter your password"
                                               autocomplete="current-password">
                                        <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                            <i class="fas fa-eye" id="toggleIconPassword"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <button type="submit" class="btn btn-login" id="adminLoginBtn">
                                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                </button>
                            </form>
                        </div>

                        <!-- Customer Login -->
                        <div class="tab-pane fade" id="customer-login">
                            <form method="post" action="${pageContext.request.contextPath}/login" id="customerLoginForm">
                                <input type="hidden" name="loginType" value="customer">
                                <div class="form-group">
                                    <label for="accountNumber" class="form-label">Account Number</label>
                                    <div class="input-group">
                                        <i class="fas fa-id-card input-icon"></i>
                                        <input type="text" class="form-control has-icon" 
                                               id="accountNumber" name="accountNumber" required 
                                               placeholder="Enter your account number"
                                               autocomplete="off">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="telephone" class="form-label">Telephone Number</label>
                                    <div class="input-group">
                                        <i class="fas fa-phone input-icon"></i>
                                        <input type="tel" class="form-control has-icon" 
                                               id="telephone" name="telephone" required 
                                               placeholder="Enter your telephone number"
                                               autocomplete="tel">
                                        <button type="button" class="password-toggle" onclick="toggleTelephone('telephone')">
                                            <i class="fas fa-eye" id="toggleIconTelephone"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <button type="submit" class="btn btn-login" id="customerLoginBtn">
                                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                </button>
                            </form>
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <small class="text-muted">Customer? Use your account number and telephone number to log in.</small>
                    </div>
                </div>

                <div class="footer-text">
                    <i class="fas fa-shield-alt me-1"></i>
                    © 2024 Pahana Edu Bookshop. Professional Bookshop Management Solution
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(fieldId) {
            const input = document.getElementById(fieldId);
            const toggleIcon = document.getElementById(`toggleIcon${fieldId.charAt(0).toUpperCase() + fieldId.slice(1)}`);
            
            if (input.type === 'password' || input.type === 'tel') {
                input.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                input.type = fieldId === 'password' ? 'password' : 'tel';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        function toggleTelephone(fieldId) {
            togglePassword(fieldId);
        }

        // Auto-focus first field based on active tab
        document.addEventListener('DOMContentLoaded', function() {
            const adminTab = document.getElementById('admin-tab');
            if (adminTab.classList.contains('active')) {
                document.getElementById('username').focus();
            }

            // Tab switch handling
            document.querySelectorAll('.nav-link').forEach(tab => {
                tab.addEventListener('shown.bs.tab', function() {
                    if (this.id === 'admin-tab') {
                        document.getElementById('username').focus();
                    } else {
                        document.getElementById('accountNumber').focus();
                    }
                });
            });

            // Form submission with loading state
            document.getElementById('adminLoginForm').addEventListener('submit', function() {
                const submitBtn = document.getElementById('adminLoginBtn');
                submitBtn.classList.add('loading');
                submitBtn.innerHTML = '<i class="fas fa-sign-in-alt me-2"></i>Signing In...';
            });

            document.getElementById('customerLoginForm').addEventListener('submit', function() {
                const submitBtn = document.getElementById('customerLoginBtn');
                submitBtn.classList.add('loading');
                submitBtn.innerHTML = '<i class="fas fa-sign-in-alt me-2"></i>Signing In...';
            });

            // Add smooth transitions to form inputs
            document.querySelectorAll('.form-control').forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>