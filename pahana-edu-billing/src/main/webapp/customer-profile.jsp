<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            
            --primary-color: #667eea;
            --dark-color: #2d3748;
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
            background: rgba(247, 250, 252, 0.8);
            color: #2d3748;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grain)"/></svg>');
            z-index: -1;
            opacity: 0.3;
        }

        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: var(--shadow-light);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 800;
            text-decoration: none;
            color: var(--dark-color);
        }

        .brand-icon {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: white;
            margin-right: 1rem;
            box-shadow: var(--shadow-light);
        }

        .brand-text {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Page Header */
        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 0;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300"><defs><pattern id="profile" x="0" y="0" width="40" height="40" patternUnits="userSpaceOnUse"><rect width="40" height="40" fill="none"/><circle cx="20" cy="20" r="3" fill="white" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23profile)"/></svg>');
            opacity: 0.3;
        }

        .profile-hero {
            display: flex;
            align-items: center;
            gap: 2rem;
            position: relative;
            z-index: 2;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            border: 4px solid rgba(255, 255, 255, 0.3);
        }

        .profile-info h1 {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
        }

        .profile-info p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 1rem;
        }

        .account-badge {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Profile Cards */
        .profile-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 2rem;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-medium);
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .form-control:read-only {
            background: #f8fafc;
            cursor: not-allowed;
        }

        /* Buttons */
        .btn-save {
            background: var(--success-gradient);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 1rem 2rem;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .btn-save:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .btn-back {
            background: rgba(102, 126, 234, 0.1);
            color: var(--primary-color);
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 16px;
            padding: 1rem 2rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            color: white;
            background: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateX(-5px);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-item {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .stat-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: var(--primary-gradient);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 900;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 600;
        }

        /* Alert Styles */
        .alert {
            border-radius: 16px;
            border: none;
            font-weight: 500;
            margin-bottom: 2rem;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: #059669;
            border-left: 4px solid #059669;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border-left: 4px solid #dc2626;
        }

        /* Loading Animation */
        .loading {
            opacity: 0;
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .loading:nth-child(1) { animation-delay: 0.1s; }
        .loading:nth-child(2) { animation-delay: 0.2s; }
        .loading:nth-child(3) { animation-delay: 0.3s; }
        .loading:nth-child(4) { animation-delay: 0.4s; }

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

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .page-header {
                padding: 2rem 0;
            }
            
            .profile-hero {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .profile-avatar {
                width: 100px;
                height: 100px;
                font-size: 2.5rem;
            }
            
            .profile-info h1 {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .profile-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <nav class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center py-3">
                <a href="${pageContext.request.contextPath}/customer-dashboard" class="navbar-brand">
                    <div class="brand-icon">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <span class="brand-text">Pahana Edu</span>
                </a>
                
                <div class="d-flex align-items-center">
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-2"></i>${sessionScope.customer.name}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-dashboard">
                                <i class="fas fa-store me-2"></i>Shop Books
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-orders">
                                <i class="fas fa-history me-2"></i>My Orders
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="profile-hero">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="profile-info">
                    <h1>${sessionScope.customer.name}</h1>
                    <p>Manage your account information and preferences</p>
                    <div class="account-badge">
                        <i class="fas fa-id-card"></i>
                        Account: ${sessionScope.customer.accountNumber}
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Customer Statistics -->
        <div class="stats-grid loading">
            <div class="stat-item">
                <div class="stat-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="stat-value">${sessionScope.customer.unitsConsumed}</div>
                <div class="stat-label">Books Purchased</div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-value">
                    <fmt:formatDate value="${sessionScope.customer.createdAt}" pattern="MMM yyyy"/>
                </div>
                <div class="stat-label">Member Since</div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-value">
                    <c:choose>
                        <c:when test="${sessionScope.customer.unitsConsumed >= 50}">Gold</c:when>
                        <c:when test="${sessionScope.customer.unitsConsumed >= 20}">Silver</c:when>
                        <c:otherwise>Bronze</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">Member Status</div>
            </div>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show loading" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show loading" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Profile Information Card -->
        <div class="profile-card loading">
            <div class="card-title">
                <div class="card-icon">
                    <i class="fas fa-user-edit"></i>
                </div>
                Personal Information
            </div>
            
            <form method="post" action="${pageContext.request.contextPath}/customer-profile">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="accountNumber" class="form-label">Account Number</label>
                            <input type="text" class="form-control" id="accountNumber" 
                                   value="${sessionScope.customer.accountNumber}" readonly>
                            <small class="text-muted">Account number cannot be changed</small>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="name" class="form-label">Full Name *</label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="${sessionScope.customer.name}" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address" class="form-label">Address *</label>
                    <textarea class="form-control" id="address" name="address" rows="3" required>${sessionScope.customer.address}</textarea>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="telephone" class="form-label">Telephone *</label>
                            <input type="tel" class="form-control" id="telephone" name="telephone" 
                                   value="${sessionScope.customer.telephone}" required>
                            <small class="text-muted">Used for login authentication</small>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="email" class="form-label">Email (Optional)</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${sessionScope.customer.email}" placeholder="your.email@example.com">
                        </div>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mt-4">
                    <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn-back">
                        <i class="fas fa-arrow-left"></i>
                        Back to Shop
                    </a>
                    
                    <button type="submit" class="btn-save">
                        <i class="fas fa-save me-2"></i>
                        Update Profile
                    </button>
                </div>
            </form>
        </div>

        <!-- Account Information Card -->
        <div class="profile-card loading">
            <div class="card-title">
                <div class="card-icon">
                    <i class="fas fa-info-circle"></i>
                </div>
                Account Information
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Member Since</label>
                        <div class="form-control" style="background: #f8fafc;">
                            <fmt:formatDate value="${sessionScope.customer.createdAt}" pattern="MMMM dd, yyyy"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Total Books Purchased</label>
                        <div class="form-control" style="background: #f8fafc;">
                            ${sessionScope.customer.unitsConsumed} books
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Member Status</label>
                        <div class="form-control" style="background: #f8fafc;">
                            <c:choose>
                                <c:when test="${sessionScope.customer.unitsConsumed >= 50}">
                                    <i class="fas fa-crown text-warning me-2"></i>Gold Member
                                </c:when>
                                <c:when test="${sessionScope.customer.unitsConsumed >= 20}">
                                    <i class="fas fa-medal text-secondary me-2"></i>Silver Member
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-award text-warning me-2"></i>Bronze Member
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Next Status Level</label>
                        <div class="form-control" style="background: #f8fafc;">
                            <c:choose>
                                <c:when test="${sessionScope.customer.unitsConsumed >= 50}">
                                    <i class="fas fa-star text-warning me-2"></i>Maximum Level Reached
                                </c:when>
                                <c:when test="${sessionScope.customer.unitsConsumed >= 20}">
                                    ${50 - sessionScope.customer.unitsConsumed} books to Gold
                                </c:when>
                                <c:otherwise>
                                    ${20 - sessionScope.customer.unitsConsumed} books to Silver
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-3 p-3" style="background: rgba(102, 126, 234, 0.05); border-radius: 16px; border-left: 4px solid var(--primary-color);">
                <h6 class="mb-2">
                    <i class="fas fa-lightbulb text-primary me-2"></i>
                    Account Tips
                </h6>
                <ul class="list-unstyled small text-muted mb-0">
                    <li class="mb-1"><i class="fas fa-check text-success me-2"></i>Keep your contact information updated for order notifications</li>
                    <li class="mb-1"><i class="fas fa-check text-success me-2"></i>Your telephone number is used for secure login</li>
                    <li class="mb-1"><i class="fas fa-check text-success me-2"></i>Purchase more books to unlock higher membership levels</li>
                </ul>
            </div>
        </div>

        <!-- Quick Actions Card -->
        <div class="profile-card loading">
            <div class="card-title">
                <div class="card-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                Quick Actions
            </div>
            
            <div class="row">
                <div class="col-md-4 mb-3">
                    <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn btn-outline-primary w-100" style="border-radius: 16px; padding: 1rem;">
                        <i class="fas fa-store fa-2x mb-2 d-block"></i>
                        Browse Books
                    </a>
                </div>
                <div class="col-md-4 mb-3">
                    <a href="${pageContext.request.contextPath}/customer-orders" class="btn btn-outline-info w-100" style="border-radius: 16px; padding: 1rem;">
                        <i class="fas fa-history fa-2x mb-2 d-block"></i>
                        View Orders
                    </a>
                </div>
                <div class="col-md-4 mb-3">
                    <button class="btn btn-outline-secondary w-100" style="border-radius: 16px; padding: 1rem;" onclick="window.print()">
                        <i class="fas fa-print fa-2x mb-2 d-block"></i>
                        Print Profile
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize animations on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Staggered animations
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Form validation
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const name = document.getElementById('name').value.trim();
                const address = document.getElementById('address').value.trim();
                const telephone = document.getElementById('telephone').value.trim();
                
                if (!name || !address || !telephone) {
                    e.preventDefault();
                    showAlert('error', 'Please fill in all required fields.');
                    return;
                }
                
                // Show loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Updating...';
                
                // Re-enable after 3 seconds as fallback
                setTimeout(() => {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="fas fa-save me-2"></i>Update Profile';
                }, 3000);
            });
            
            // Add hover effects
            document.querySelectorAll('.profile-card, .stat-item').forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
        });

        function showAlert(type, message) {
            const alert = document.createElement('div');
            alert.className = `alert alert-${type === 'error' ? 'danger' : 'success'} alert-dismissible fade show`;
            alert.style.position = 'fixed';
            alert.style.top = '20px';
            alert.style.right = '20px';
            alert.style.zIndex = '10000';
            alert.style.minWidth = '300px';
            alert.innerHTML = `
                <i class="fas fa-${type === 'error' ? 'exclamation-circle' : 'check-circle'} me-2"></i>
                ${message}
                <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
            `;
            
            document.body.appendChild(alert);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                if (alert.parentElement) {
                    alert.remove();
                }
            }, 5000);
        }

        // Print styles
        const printStyles = `
            <style type="text/css" media="print">
                @page { margin: 0.5in; }
                body { font-size: 12pt; }
                .header, .btn, .dropdown { display: none !important; }
                .profile-card { break-inside: avoid; page-break-inside: avoid; }
                .card-icon { background: #000 !important; }
            </style>
        `;
        
        document.head.insertAdjacentHTML('beforeend', printStyles);
    </script>
</body>
</html>