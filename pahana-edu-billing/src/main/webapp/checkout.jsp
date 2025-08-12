<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            --primary-color: #667eea;
            --dark-color: #2d3748;
            --border-radius: 24px;
            --shadow-light: 0 4px 25px rgba(0, 0, 0, 0.08);
            --shadow-hover: 0 8px 40px rgba(0, 0, 0, 0.12);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: rgba(247, 250, 252, 0.8);
            color: #2d3748;
            line-height: 1.6;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: var(--shadow-light);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
        }

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
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, rgba(255,255,255,0.1) 25%, transparent 25%),
                        linear-gradient(-45deg, rgba(255,255,255,0.1) 25%, transparent 25%),
                        linear-gradient(45deg, transparent 75%, rgba(255,255,255,0.1) 75%),
                        linear-gradient(-45deg, transparent 75%, rgba(255,255,255,0.1) 75%);
            background-size: 60px 60px;
            animation: float 20s infinite linear;
            opacity: 0.3;
        }

        @keyframes float {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 900;
            position: relative;
            z-index: 1;
        }

        .checkout-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            padding: 2.5rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }

        .checkout-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }

        .table {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }

        .table thead th {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8eeff 100%);
            border: none;
            font-weight: 600;
            color: var(--dark-color);
            padding: 1rem;
        }

        .table tbody td {
            padding: 1rem;
            border-color: rgba(0, 0, 0, 0.05);
            vertical-align: middle;
        }

        .table tfoot td {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8eeff 100%);
            font-weight: 600;
            border: none;
            padding: 1rem;
        }

        .btn-checkout {
            background: var(--success-gradient);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }

        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
            color: white;
        }

        .btn-back {
            border-radius: 16px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            transform: translateY(-2px);
        }

        .alert {
            border-radius: 16px;
            padding: 1rem 1.5rem;
            font-weight: 500;
            border: none;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
            color: #c53030;
        }

        .alert-success {
            background: linear-gradient(135deg, #e6fffa 0%, #ccfff5 100%);
            color: #38a169;
        }

        .shipping-details {
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            border-radius: 16px;
            padding: 1.5rem;
            margin: 1.5rem 0;
        }

        .shipping-details h3 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .customer-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .customer-info p {
            margin: 0.5rem 0;
            font-weight: 500;
        }

        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .cart-item {
            transition: all 0.3s ease;
        }

        .cart-item:hover {
            background: rgba(102, 126, 234, 0.02);
        }

        .empty-cart {
            text-align: center;
            padding: 3rem;
        }

        .empty-cart i {
            font-size: 4rem;
            color: #cbd5e0;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .checkout-card {
                padding: 1.5rem;
                margin: 1rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .customer-info {
                grid-template-columns: 1fr;
            }
            
            .table-responsive {
                border-radius: 16px;
                overflow: hidden;
            }
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="text-center">
            <div class="spinner"></div>
            <p class="mt-3">Processing your order...</p>
        </div>
    </div>

    <!-- Header -->
    <nav class="header navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/customer-dashboard">
                <i class="fas fa-book"></i> Pahana Edu Bookshop
            </a>
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle me-2"></i>
                        <c:choose>
                            <c:when test="${not empty sessionScope.customer}">
                                ${sessionScope.customer.name}
                            </c:when>
                            <c:otherwise>
                                Guest
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <c:if test="${not empty sessionScope.customer}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-orders">
                                <i class="fas fa-history me-2"></i>My Orders</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-profile">
                                <i class="fas fa-user-edit me-2"></i>Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </c:if>
                        <c:if test="${empty sessionScope.customer}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="page-title">
                        <i class="fas fa-credit-card me-3"></i>Checkout
                    </h1>
                    <p class="lead mb-0">Review and confirm your order</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <i class="fas fa-shopping-bag" style="font-size: 3rem; opacity: 0.3;"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-4 mb-5">
        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <!-- Success Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle me-2"></i>${success}
            </div>
        </c:if>

        <div class="checkout-card">
            <div class="d-flex align-items-center mb-4">
                <h3 class="mb-0"><i class="fas fa-list-alt me-2"></i>Order Summary</h3>
            </div>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="empty-cart">
                        <i class="fas fa-shopping-cart"></i>
                        <h4>Your cart is empty</h4>
                        <p class="text-muted">Add some books to your cart before proceeding to checkout.</p>
                        <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn btn-primary btn-back">
                            <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Cart Items Table -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Book Details</th>
                                    <th>Unit Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="cartTotal" value="${0}"/>
                                <c:forEach items="${cartItems}" var="item" varStatus="status">
                                    <tr class="cart-item">
                                        <td>
                                            <div>
                                                <strong>${item.book.title}</strong><br>
                                                <small class="text-muted">by ${item.book.author}</small>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="fw-bold">
                                                <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/> LKR
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary rounded-pill">${item.quantity}</span>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-success">
                                                <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/> LKR
                                            </span>
                                        </td>
                                    </tr>
                                    <c:set var="cartTotal" value="${cartTotal + item.subtotal}"/>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" class="text-end">
                                        <strong style="font-size: 1.2rem;">Total Amount:</strong>
                                    </td>
                                    <td>
                                        <strong style="font-size: 1.2rem; color: var(--primary-color);">
                                            <fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/> LKR
                                        </strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!-- Shipping Details -->
                    <div class="shipping-details">
                        <h3><i class="fas fa-truck me-2"></i>Shipping Details</h3>
                        <c:choose>
                            <c:when test="${not empty sessionScope.customer}">
                                <div class="customer-info">
                                    <p><i class="fas fa-user me-2"></i><strong>Name:</strong> ${sessionScope.customer.name}</p>
                                    <c:if test="${not empty sessionScope.customer.accountNumber}">
                                        <p><i class="fas fa-id-card me-2"></i><strong>Account:</strong> ${sessionScope.customer.accountNumber}</p>
                                    </c:if>
                                    <p><i class="fas fa-map-marker-alt me-2"></i><strong>Address:</strong> ${sessionScope.customer.address}</p>
                                    <p><i class="fas fa-phone me-2"></i><strong>Telephone:</strong> ${sessionScope.customer.telephone}</p>
                                    <c:if test="${not empty sessionScope.customer.email}">
                                        <p><i class="fas fa-envelope me-2"></i><strong>Email:</strong> ${sessionScope.customer.email}</p>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Customer information not available. Please log in again.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Action Buttons -->
                    <c:if test="${not empty sessionScope.customer}">
                        <form method="post" action="${pageContext.request.contextPath}/checkout" id="checkoutForm">
                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary btn-back">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Cart
                                </a>
                                <button type="submit" class="btn btn-checkout" id="confirmOrderBtn">
                                    <i class="fas fa-check me-2"></i>Confirm Order
                                </button>
                            </div>
                        </form>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle form submission with loading overlay
        document.getElementById('checkoutForm')?.addEventListener('submit', function(e) {
            const loadingOverlay = document.getElementById('loadingOverlay');
            const confirmBtn = document.getElementById('confirmOrderBtn');
            
            // Show loading overlay
            loadingOverlay.style.display = 'flex';
            
            // Disable the button to prevent double submission
            confirmBtn.disabled = true;
            confirmBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing...';
            
            // If there's an error, the page will reload and hide the overlay
            // If successful, user will be redirected
        });

        // Hide loading overlay if there's an error (page reloads)
        document.addEventListener('DOMContentLoaded', function() {
            const loadingOverlay = document.getElementById('loadingOverlay');
            const hasError = document.querySelector('.alert-danger');
            
            if (hasError) {
                loadingOverlay.style.display = 'none';
            }
        });

        // Auto-hide success/error alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.style.display = 'none';
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>