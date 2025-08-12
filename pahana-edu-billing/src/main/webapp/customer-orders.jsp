<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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
                        linear-gradient(-45deg, rgba(255,255,255,0.1) 25%, transparent 25%);
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

        .order-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }

        .order-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .status-pending { background: linear-gradient(135deg, #fff3cd, #ffeaa7); color: #856404; }
        .status-confirmed { background: linear-gradient(135deg, #d1ecf1, #a8dadc); color: #0c5460; }
        .status-shipped { background: linear-gradient(135deg, #d4edda, #95e1d3); color: #155724; }
        .status-delivered { background: linear-gradient(135deg, #d1e7dd, #6c757d); color: #0f5132; }
        .status-cancelled { background: linear-gradient(135deg, #f8d7da, #e74c3c); color: #721c24; }

        .order-items {
            background: rgba(247, 250, 252, 0.8);
            border-radius: 12px;
            padding: 1rem;
            margin-top: 1rem;
        }

        .order-item {
            display: flex;
            justify-content: between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .btn-back {
            background: var(--primary-gradient);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            color: white;
            box-shadow: var(--shadow-hover);
        }

        .alert {
            border-radius: 16px;
            padding: 1rem 1.5rem;
            font-weight: 500;
            border: none;
        }

        .alert-success {
            background: linear-gradient(135deg, #e6fffa 0%, #ccfff5 100%);
            color: #38a169;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
            color: #c53030;
        }

        .empty-orders {
            text-align: center;
            padding: 4rem 2rem;
            color: #a0aec0;
        }

        .empty-orders i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .order-card {
                padding: 1.5rem;
                margin: 1rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
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
                        <i class="fas fa-history me-3"></i>My Orders
                    </h1>
                    <p class="lead mb-0">Track and view your order history</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <i class="fas fa-clipboard-list" style="font-size: 3rem; opacity: 0.3;"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-4 mb-5">
        <!-- Success Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle me-2"></i>${success}
            </div>
        </c:if>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <!-- Back Button -->
        <div class="mb-4">
            <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn-back">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>

        <!-- Orders List -->
        <c:choose>
            <c:when test="${empty orders}">
                <div class="order-card">
                    <div class="empty-orders">
                        <i class="fas fa-inbox"></i>
                        <h4>No Orders Found</h4>
                        <p>You haven't placed any orders yet.</p>
                        <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn-back mt-3">
                            <i class="fas fa-shopping-cart me-2"></i>Start Shopping
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${orders}" var="order" varStatus="status">
                    <div class="order-card">
                        <div class="row">
                            <div class="col-md-8">
                                <h5 class="mb-2">
                                    <i class="fas fa-receipt me-2"></i>Order #${order.id}
                                </h5>
                                <p class="text-muted mb-2">
                                    <i class="fas fa-calendar me-2"></i>
                                    <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                </p>
                                <p class="mb-3">
                                    <strong>Total Amount: </strong>
                                    <span class="text-success fw-bold">
                                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /> LKR
                                    </span>
                                </p>
                            </div>
                            <div class="col-md-4 text-md-end">
                                <span class="status-badge status-${order.status.toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <i class="fas fa-clock me-1"></i>Pending
                                        </c:when>
                                        <c:when test="${order.status == 'CONFIRMED'}">
                                            <i class="fas fa-check me-1"></i>Confirmed
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPED'}">
                                            <i class="fas fa-truck me-1"></i>Shipped
                                        </c:when>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <i class="fas fa-check-double me-1"></i>Delivered
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                            <i class="fas fa-times me-1"></i>Cancelled
                                        </c:when>
                                        <c:otherwise>
                                            ${order.status}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <!-- Order Items -->
                        <div class="order-items">
                            <h6 class="mb-3"><i class="fas fa-list me-2"></i>Order Items</h6>
                            <c:forEach items="${order.orderItems}" var="item" varStatus="itemStatus">
                                <div class="order-item">
                                    <div class="flex-grow-1">
                                        <strong>${item.book.title}</strong><br>
                                        <small class="text-muted">by ${item.book.author}</small>
                                    </div>
                                    <div class="text-end">
                                        <span class="badge bg-primary rounded-pill me-2">${item.quantity}x</span>
                                        <span class="fw-bold">
                                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" /> LKR
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
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