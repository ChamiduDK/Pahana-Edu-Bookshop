<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration - Pahana Edu Bookshop</title>
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

        .registration-container {
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
            transition: all 0.3s ease;
        }

        .hero-icon:hover {
            transform: scale(1.05);
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
            overflow-y: auto;
        }

        .form-container {
            width: 100%;
            max-width: 580px;
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

        .registration-form {
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

        .form-label.required::after {
            content: ' *';
            color: #dc2626;
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

        .form-control.is-invalid {
            border-color: #dc2626;
            background: #fef2f2;
        }

        .form-control.is-valid {
            border-color: #16a34a;
            background: #f0fdf4;
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

        .invalid-feedback {
            display: block;
            font-size: 0.85rem;
            color: #dc2626;
            margin-top: 0.5rem;
        }

        .valid-feedback {
            display: block;
            font-size: 0.85rem;
            color: #16a34a;
            margin-top: 0.5rem;
        }

        .btn-register {
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

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .btn-register.loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .btn-register.loading::after {
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

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .login-link a:hover {
            color: #5a67d8;
            text-decoration: underline;
        }

        .footer-text {
            text-align: center;
            margin-top: 2rem;
            color: #9ca3af;
            font-size: 0.85rem;
        }

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        .account-number-display {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0e7ff 100%);
            border: 2px solid #3b82f6;
            border-radius: 12px;
            padding: 1rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .account-number-display .label {
            font-size: 0.85rem;
            color: #1e40af;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .account-number-display .number {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e40af;
            font-family: 'Courier New', monospace;
        }

        @media (max-width: 768px) {
            .registration-container {
                flex-direction: column;
            }
            
            .image-section {
                min-height: 30vh;
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
            
            .registration-form {
                padding: 2rem 1.5rem;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }

        @media (max-width: 480px) {
            .image-section {
                min-height: 25vh;
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
            
            .registration-form {
                padding: 1.5rem 1rem;
            }
        }

        .password-strength {
            margin-top: 0.5rem;
        }

        .strength-bar {
            height: 4px;
            background: #e5e7eb;
            border-radius: 2px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }

        .strength-fill {
            height: 100%;
            background: #dc2626;
            width: 0%;
            transition: all 0.3s ease;
        }

        .strength-fill.weak { background: #dc2626; }
        .strength-fill.medium { background: #f59e0b; }
        .strength-fill.strong { background: #16a34a; }

        .strength-text {
            font-size: 0.8rem;
            color: #6b7280;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <!-- Left Image Section -->
        <div class="image-section">
            <div class="hero-content">
                <div class="hero-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h1 class="hero-title">Join Our Bookshop</h1>
                <p class="hero-subtitle">
                    Create your account to access our comprehensive book collection and enjoy personalized shopping.
                </p>
                <ul class="feature-list">
                    <li><i class="fas fa-check"></i> Instant Account Creation</li>
                    <li><i class="fas fa-check"></i> Secure Personal Information</li>
                    <li><i class="fas fa-check"></i> Easy Order Management</li>
                    <li><i class="fas fa-check"></i> Personalized Book Recommendations</li>
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
                    <p class="brand-subtitle">Create Your Customer Account</p>
                </div>

                <div class="registration-form">
                    <!-- Error Alert -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <!-- Success Alert -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${success}
                        </div>
                    </c:if>

                    <!-- Account Number Display (will be generated) -->
                    <div class="account-number-display" id="accountNumberDisplay" style="display: none;">
                        <div class="label">Your Account Number</div>
                        <div class="number" id="generatedAccountNumber">ACC000</div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/register" id="registrationForm" novalidate>
                        <!-- Personal Information Section -->
                        <div class="form-group">
                            <label for="name" class="form-label required">Full Name</label>
                            <div class="input-group">
                                <i class="fas fa-user input-icon"></i>
                                <input type="text" class="form-control has-icon" 
                                       id="name" name="name" required 
                                       placeholder="Enter your full name"
                                       value="${param.name}"
                                       autocomplete="name">
                            </div>
                            <div class="invalid-feedback" id="nameError"></div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="form-label required">Address</label>
                            <div class="input-group">
                                <i class="fas fa-map-marker-alt input-icon"></i>
                                <textarea class="form-control has-icon" 
                                          id="address" name="address" required 
                                          placeholder="Enter your complete address"
                                          rows="3"
                                          autocomplete="street-address">${param.address}</textarea>
                            </div>
                            <div class="invalid-feedback" id="addressError"></div>
                        </div>

                        <!-- Contact Information Section -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="telephone" class="form-label required">Telephone Number</label>
                                <div class="input-group">
                                    <i class="fas fa-phone input-icon"></i>
                                    <input type="tel" class="form-control has-icon" 
                                           id="telephone" name="telephone" required 
                                           placeholder="e.g., 0771234567"
                                           value="${param.telephone}"
                                           autocomplete="tel">
                                </div>
                                <div class="invalid-feedback" id="telephoneError"></div>
                            </div>

                            <div class="form-group">
                                <label for="email" class="form-label">Email Address (Optional)</label>
                                <div class="input-group">
                                    <i class="fas fa-envelope input-icon"></i>
                                    <input type="email" class="form-control has-icon" 
                                           id="email" name="email" 
                                           placeholder="Enter your email address"
                                           value="${param.email}"
                                           autocomplete="email">
                                </div>
                                <div class="invalid-feedback" id="emailError"></div>
                            </div>
                        </div>

                        <!-- Units Consumed (Optional) -->
                        <div class="form-group">
                            <label for="unitsConsumed" class="form-label">Initial Units Consumed</label>
                            <div class="input-group">
                                <i class="fas fa-chart-bar input-icon"></i>
                                <input type="number" class="form-control has-icon" 
                                       id="unitsConsumed" name="unitsConsumed" 
                                       placeholder="0"
                                       value="${param.unitsConsumed != null ? param.unitsConsumed : '0'}"
                                       min="0">
                            </div>
                            <small class="text-muted">Leave as 0 for new customers</small>
                        </div>

                        <button type="submit" class="btn btn-register" id="registerBtn">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>
                    </form>

                    <div class="login-link">
                        <p class="text-muted mb-2">Already have an account?</p>
                        <a href="${pageContext.request.contextPath}/login" class="fw-bold">
                            <i class="fas fa-sign-in-alt me-1"></i>Sign in to your account
                        </a>
                    </div>
                </div>

                <div class="footer-text">
                    <i class="fas fa-shield-alt me-1"></i>
                    © 2024 Pahana Edu Bookshop. Your information is secure with us.
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registrationForm');
            const submitBtn = document.getElementById('registerBtn');
            
            // Auto-focus first field
            document.getElementById('name').focus();

            // Real-time validation
            const fields = {
                name: {
                    element: document.getElementById('name'),
                    validate: (value) => {
                        if (!value.trim()) return 'Full name is required';
                        if (value.trim().length < 2) return 'Name must be at least 2 characters';
                        if (!/^[a-zA-Z\s]+$/.test(value.trim())) return 'Name should only contain letters and spaces';
                        return null;
                    }
                },
                address: {
                    element: document.getElementById('address'),
                    validate: (value) => {
                        if (!value.trim()) return 'Address is required';
                        if (value.trim().length < 10) return 'Please provide a complete address';
                        return null;
                    }
                },
                telephone: {
                    element: document.getElementById('telephone'),
                    validate: (value) => {
                        if (!value.trim()) return 'Telephone number is required';
                        const cleaned = value.replace(/[\s\-\(\)]/g, '');
                        if (!/^0\d{9}$/.test(cleaned)) return 'Please enter a valid 10-digit Sri Lankan phone number (e.g., 0771234567)';
                        return null;
                    }
                },
                email: {
                    element: document.getElementById('email'),
                    validate: (value) => {
                        if (value.trim() && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())) {
                            return 'Please enter a valid email address';
                        }
                        return null;
                    }
                },
                unitsConsumed: {
                    element: document.getElementById('unitsConsumed'),
                    validate: (value) => {
                        if (value && (isNaN(value) || parseInt(value) < 0)) {
                            return 'Units consumed must be a non-negative number';
                        }
                        return null;
                    }
                }
            };

            // Add validation listeners
            Object.keys(fields).forEach(fieldName => {
                const field = fields[fieldName];
                const errorElement = document.getElementById(fieldName + 'Error');
                
                field.element.addEventListener('input', function() {
                    const error = field.validate(this.value);
                    showValidation(this, errorElement, error);
                });

                field.element.addEventListener('blur', function() {
                    const error = field.validate(this.value);
                    showValidation(this, errorElement, error);
                });
            });

            function showValidation(element, errorElement, error) {
                if (error) {
                    element.classList.add('is-invalid');
                    element.classList.remove('is-valid');
                    errorElement.textContent = error;
                } else if (element.value.trim()) {
                    element.classList.add('is-valid');
                    element.classList.remove('is-invalid');
                    errorElement.textContent = '';
                } else {
                    element.classList.remove('is-valid', 'is-invalid');
                    errorElement.textContent = '';
                }
            }

            // Form submission
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                // Validate all fields
                Object.keys(fields).forEach(fieldName => {
                    const field = fields[fieldName];
                    const errorElement = document.getElementById(fieldName + 'Error');
                    const error = field.validate(field.element.value);
                    
                    showValidation(field.element, errorElement, error);
                    
                    if (error) isValid = false;
                });

                if (!isValid) {
                    e.preventDefault();
                    // Focus first invalid field
                    const firstInvalid = form.querySelector('.is-invalid');
                    if (firstInvalid) {
                        firstInvalid.focus();
                        firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                    return;
                }

                // Show loading state
                submitBtn.classList.add('loading');
                submitBtn.innerHTML = '<i class="fas fa-user-plus me-2"></i>Creating Account...';
            });

            // Phone number formatting
            document.getElementById('telephone').addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 10) value = value.substring(0, 10);
                
                if (value.length >= 3 && value.length <= 6) {
                    value = value.substring(0, 3) + '-' + value.substring(3);
                } else if (value.length > 6) {
                    value = value.substring(0, 3) + '-' + value.substring(3, 6) + '-' + value.substring(6);
                }
                
                e.target.value = value;
            });

            // Generate preview account number
            fetch('${pageContext.request.contextPath}/api/generate-account-number')
                .then(response => response.text())
                .then(accountNumber => {
                    document.getElementById('generatedAccountNumber').textContent = accountNumber;
                    document.getElementById('accountNumberDisplay').style.display = 'block';
                })
                .catch(error => {
                    console.log('Could not generate preview account number');
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