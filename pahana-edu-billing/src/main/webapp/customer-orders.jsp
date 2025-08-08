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
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300"><defs><pattern id="orders" x="0" y="0" width="40" height="40" patternUnits="userSpaceOnUse"><rect width="40" height="40" fill="none"/><circle cx="20" cy="20" r="2" fill="white" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23orders)"/></svg>');
            opacity: 0.3;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 2;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }

        /* Order Cards */
        .order-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .order-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-heavy);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .order-id {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--dark-color);
        }

        .order-date {
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: #d97706;
            border: 2px solid rgba(245, 158, 11, 0.2);
        }

        .status-confirmed {
            background: rgba(6, 182, 212, 0.1);
            color: #0891b2;
            border: 2px solid rgba(6, 182, 212, 0.2);
        }

        .status-shipped {
            background: rgba(99, 102, 241, 0.1);
            color: #6366f1;
            border: 2px solid rgba(99, 102, 241, 0.2);
        }

        .status-delivered {
            background: rgba(16, 185, 129, 0.1);
            color: #059669;
            border: 2px solid rgba(16, 185, 129, 0.2);
        }

        .status-cancelled {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border: 2px solid rgba(239, 68, 68, 0.2);
        }

        .order-items {
            margin-bottom: 1.5rem;
        }

        .order-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: rgba(102, 126, 234, 0.02);
            border-radius: 16px;
            margin-bottom: 0.75rem;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }

        .item-icon {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .item-details {
            flex: 1;
        }

        .item-title {
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
        }

        .item-author {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .item-price {
            font-weight: 600;
            color: var(--primary-color);
            font-size: 0.9rem;
        }

        .item-quantity {
            background: var(--primary-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .order-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: rgba(102, 126, 234, 0.05);
            border-radius: 16px;
            border: 2px solid rgba(102, 126, 234, 0.1);
        }

        .total-label {
            font-weight: 600;
            color: var(--dark-color);
        }

        .total-amount {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-color);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
        }

        .empty-state i {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            opacity: 0.3;
            color: var(--primary-color);
        }

        .empty-state h4 {
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .shop-btn {
            background: var(--primary-gradient);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 1rem 2rem;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .shop-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* Back Button */
        .back-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 16px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            color: white;
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateX(-5px);
        }

        /* Summary Stats */
        .order-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
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
            
            .page-title {
                font-size: 2rem;
            }
            
            .order-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .order-item {
                flex-direction: column;
                text-align: center;
                gap: 0.75rem;
            }
            
            .order-total {
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }
            
            .order-stats {
                grid-template-columns: 1fr;
                gap: 1rem;
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
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-profile">
                                <i class="fas fa-user-edit me-2"></i>Profile
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
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <div>
                    <h1 class="page-title">My Orders</h1>
                    <p class="page-subtitle">Track your book orders and purchase history</p>
                </div>
                <a href="${pageContext.request.contextPath}/customer-dashboard" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Shop
                </a>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Order Statistics -->
        <c:if test="${not empty orders}">
            <div class="order-stats loading">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="stat-value">${orders.size()}</div>
                    <div class="stat-label">Total Orders</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-value">
                        <c:set var="deliveredCount" value="0"/>
                        <c:forEach items="${orders}" var="order">
                            <c:if test="${order.status eq 'DELIVERED'}">
                                <c:set var="deliveredCount" value="${deliveredCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${deliveredCount}
                    </div>
                    <div class="stat-label">Completed</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-value">
                        <c:set var="pendingCount" value="0"/>
                        <c:forEach items="${orders}" var="order">
                            <c:if test="${order.status eq 'PENDING' or order.status eq 'CONFIRMED' or order.status eq 'SHIPPED'}">
                                <c:set var="pendingCount" value="${pendingCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${pendingCount}
                    </div>
                    <div class="stat-label">In Progress</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-rupee-sign"></i>
                    </div>
                    <div class="stat-value">
                        <c:set var="totalSpent" value="0"/>
                        <c:forEach items="${orders}" var="order">
                            <c:set var="totalSpent" value="${totalSpent + order.totalAmount}"/>
                        </c:forEach>
                        <fmt:formatNumber value="${totalSpent}" pattern="0"/>
                    </div>
                    <div class="stat-label">Total Spent (LKR)</div>
                </div>
            </div>
        </c:if>

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

        <!-- Orders List -->
        <c:if test="${not empty orders}">
            <c:forEach items="${orders}" var="order" varStatus="status">
                <div class="order-card loading">
                    <div class="order-header">
                        <div>
                            <div class="order-id">Order #${order.id}</div>
                            <div class="order-date">
                                Placed on <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                            </div>
                        </div>
                        <div class="status-badge status-${order.status.toLowerCase()}">
                            <i class="fas fa-${order.status eq 'PENDING' ? 'clock' : order.status eq 'CONFIRMED' ? 'check' : order.status eq 'SHIPPED' ? 'truck' : order.status eq 'DELIVERED' ? 'check-circle' : 'times'} me-1"></i>
                            ${order.status}
                        </div>
                    </div>

                    <div class="order-items">
                        <c:forEach items="${order.orderItems}" var="item">
                            <div class="order-item">
                                <div class="item-icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                <div class="item-details">
                                    <div class="item-title">${item.book.title}</div>
                                    <div class="item-author">by ${item.book.author}</div>
                                    <div class="item-price">LKR <fmt:formatNumber value="${item.unitPrice}" pattern="0.00"/> each</div>
                                </div>
                                <div class="item-quantity">
                                    Qty: ${item.quantity}
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="order-total">
                        <span class="total-label">Total Amount:</span>
                        <span class="total-amount">LKR <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></span>
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <!-- Empty State -->
        <c:if test="${empty orders}">
            <div class="empty-state">
                <i class="fas fa-shopping-bag"></i>
                <h4>No orders yet</h4>
                <p>You haven't placed any orders yet. Start shopping to see your orders here!</p>
                <a href="${pageContext.request.contextPath}/customer-dashboard" class="shop-btn">
                    <i class="fas fa-store"></i>
                    Start Shopping
                </a>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize animations on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Staggered animations for order cards
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Add hover effects
            document.querySelectorAll('.order-card').forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>