<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management - Pahana Edu Bookshop</title>
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
            background: var(--primary-gradient);
            background-attachment: fixed;
            color: var(--dark-color);
            overflow-x: hidden;
        }

        /* Sidebar Styles */
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
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 800;
            text-decoration: none;
            color: var(--dark-color);
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

        .content-area {
            padding: 2.5rem;
            background-color: #f1f5f9;
        }

        /* Cards */
        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-heavy);
        }

        .card-header {
            border-radius: var(--border-radius) var(--border-radius) 0 0;
            background: var(--primary-gradient);
            color: white;
            padding: 1.5rem;
            font-weight: 700;
            border: none;
        }

        .card-body {
            padding: 2rem;
        }

        /* Improved Table */
        .table {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            border: none;
        }

        .table th {
            background: #f8fafc;
            color: var(--dark-color);
            font-weight: 600;
            border: none;
            padding: 1.2rem 1rem;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 1.2rem 1rem;
            vertical-align: middle;
            border: none;
            border-bottom: 1px solid #f1f5f9;
        }

        .table tr:hover {
            background: #f8fafc;
            transition: all 0.3s ease;
        }

        /* Enhanced Action Buttons */
        .action-btn {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-info {
            background: var(--success-gradient);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            color: white;
        }

        /* Enhanced Status Badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .status-badge::before {
            content: '';
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: currentColor;
        }

        .bg-warning {
            background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%) !important;
            color: #000 !important;
        }

        .bg-info {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%) !important;
        }

        .bg-primary {
            background: var(--primary-gradient) !important;
        }

        .bg-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
        }

        .bg-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%) !important;
        }

        /* Enhanced Book Selection */
        .book-selection {
            max-height: 400px;
            overflow-y: auto;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 1.5rem;
            background: #f8fafc;
        }

        .book-item {
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            background: white;
            border: 1px solid #e2e8f0;
        }

        .book-item:hover {
            background: #f0f9ff;
            border-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .book-item.selected {
            border-color: var(--primary-color);
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.15);
        }

        /* Enhanced Form Controls */
        .form-control, .form-select {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.1);
        }

        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        /* Enhanced Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
        }

        .empty-state i {
            font-size: 5rem;
            color: #e2e8f0;
            margin-bottom: 1.5rem;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        .empty-state h5 {
            margin-bottom: 1rem;
            color: var(--dark-color);
            font-weight: 700;
        }

        /* Enhanced Modal */
        .modal-content {
            border-radius: var(--border-radius);
            border: none;
            box-shadow: var(--shadow-heavy);
        }

        .modal-header {
            border-bottom: none;
            padding: 1.5rem 1.5rem 0;
            background: var(--primary-gradient);
            color: white;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .modal-body {
            padding: 2rem 1.5rem;
        }

        .modal-footer {
            border-top: none;
            padding: 0 1.5rem 1.5rem;
        }

        .btn-close {
            filter: brightness(0) invert(1);
        }

        /* Enhanced Order Summary */
        .order-summary-card {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 1.5rem;
        }

        .summary-item {
            display: flex;
            justify-content: between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .total-amount {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary-color);
            text-align: center;
            padding: 1rem;
            background: white;
            border-radius: 12px;
            margin-top: 1rem;
            border: 2px solid var(--primary-color);
        }

        /* Loading Spinner */
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Search and Filter */
        .search-filter-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: var(--shadow-light);
            margin-bottom: 2rem;
        }

        .search-input {
            border-radius: 25px;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1.5rem;
            padding-left: 3rem;
            background: #f8fafc;
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
        }

        /* Responsive */
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

            .modal-dialog {
                margin: 1rem;
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

            .book-item {
                flex-direction: column;
                gap: 1rem;
            }

            .book-item .col-md-6, .book-item .col-md-3 {
                width: 100%;
            }
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

        /* Enhanced Alerts */
        .alert {
            border: none;
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-light);
        }

        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
        }

        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/orders">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/staff">
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
                <h4>Order Management</h4>
                <div class="topbar-subtitle">Manage and track all orders</div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <button class="btn btn-link d-md-none" onclick="toggleSidebar()">
                    <i class="fas fa-bars fa-lg"></i>
                </button>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show loading" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show loading" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Search and Filter Bar -->
            <div class="search-filter-bar loading">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="position-relative">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" class="form-control search-input" id="searchOrders" placeholder="Search orders by customer name, order ID, or account number...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="statusFilter">
                            <option value="">All Status</option>
                            <option value="PENDING">Pending</option>
                            <option value="CONFIRMED">Confirmed</option>
                            <option value="SHIPPED">Shipped</option>
                            <option value="DELIVERED">Delivered</option>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <div class="d-flex gap-2">
                            <button class="action-btn btn-primary flex-fill" data-bs-toggle="modal" data-bs-target="#createOrderModal">
                                <i class="fas fa-plus"></i> New Order
                            </button>
                            <a href="${pageContext.request.contextPath}/orders?action=admin" class="action-btn btn-info">
                                <i class="fas fa-cog"></i> Admin
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Orders List -->
            <div class="card loading">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-list-alt me-2"></i>Recent Orders</h5>
                    <span class="badge bg-light text-dark" id="orderCount">
                        <c:choose>
                            <c:when test="${not empty orders}">${orders.size()} orders</c:when>
                            <c:otherwise>0 orders</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="card-body">
                    <c:if test="${empty orders}">
                        <div class="empty-state">
                            <i class="fas fa-shopping-cart"></i>
                            <h5>No Orders Found</h5>
                            <p class="mb-3">Start by creating your first order to manage customer purchases.</p>
                            <button class="action-btn btn-primary" data-bs-toggle="modal" data-bs-target="#createOrderModal">
                                <i class="fas fa-plus"></i> Create First Order
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${not empty orders}">
                        <div class="table-responsive">
                            <table class="table table-hover" id="ordersTable">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-hashtag me-1"></i>Order ID</th>
                                        <th><i class="fas fa-user me-1"></i>Customer</th>
                                        <th><i class="fas fa-id-card me-1"></i>Account</th>
                                        <th><i class="fas fa-money-bill me-1"></i>Amount</th>
                                        <th><i class="fas fa-info-circle me-1"></i>Status</th>
                                        <th><i class="fas fa-calendar me-1"></i>Date</th>
                                        <th><i class="fas fa-cogs me-1"></i>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order" varStatus="status">
                                        <c:if test="${status.index < 10}">
                                            <tr>
                                                <td><strong class="text-primary">#${order.id}</strong></td>
                                                <td>
                                                    <div class="fw-bold">${order.customer.name}</div>
                                                    <small class="text-muted">${order.customer.telephone}</small>
                                                </td>
                                                <td><span class="badge bg-primary rounded-pill">${order.customer.accountNumber}</span></td>
                                                <td class="fw-bold text-success">LKR <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PENDING'}">
                                                            <span class="status-badge bg-warning">PENDING</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'CONFIRMED'}">
                                                            <span class="status-badge bg-info">CONFIRMED</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'SHIPPED'}">
                                                            <span class="status-badge bg-primary">SHIPPED</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'DELIVERED'}">
                                                            <span class="status-badge bg-success">DELIVERED</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge bg-danger">CANCELLED</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div><fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy"/></div>
                                                    <small class="text-muted"><fmt:formatDate value="${order.orderDate}" pattern="hh:mm a"/></small>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.id}" 
                                                       class="action-btn btn-primary btn-sm">
                                                        <i class="fas fa-eye"></i> View
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <c:if test="${orders.size() > 10}">
                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/orders?action=admin" class="action-btn btn-info">
                                    <i class="fas fa-list me-2"></i>View All ${orders.size()} Orders
                                </a>
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Create Order Modal -->
    <div class="modal fade" id="createOrderModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i>Create New Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/orders" id="createOrderForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        
                        <!-- Customer Selection -->
                        <div class="mb-4">
                            <label for="customerId" class="form-label">
                                <i class="fas fa-user text-primary me-2"></i>Select Customer *
                            </label>
                            <select class="form-select" name="customerId" id="customerId" required>
                                <option value="">Choose a customer...</option>
                                <c:forEach items="${customers}" var="customer">
                                    <option value="${customer.id}" data-name="${customer.name}" data-phone="${customer.telephone}">
                                        ${customer.accountNumber} - ${customer.name} (${customer.telephone})
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">
                                <a href="${pageContext.request.contextPath}/customers" target="_blank" class="text-decoration-none text-primary">
                                    <i class="fas fa-plus me-1"></i> Add new customer
                                </a>
                            </div>
                            <div id="customerInfo" class="mt-2 p-2 bg-light rounded" style="display: none;">
                                <small class="text-muted">Selected: <span id="selectedCustomerName"></span></small>
                            </div>
                        </div>

                        <!-- Book Selection -->
                        <div class="mb-4">
                            <label class="form-label">
                                <i class="fas fa-books text-primary me-2"></i>Select Books *
                            </label>
                            <div class="mb-3">
                                <div class="position-relative">
                                    <i class="fas fa-search search-icon"></i>
                                    <input type="text" class="form-control search-input" id="bookSearch" placeholder="Search books by title or author...">
                                </div>
                            </div>
                            <div class="book-selection" id="bookSelection">
                                <c:forEach items="${books}" var="book">
                                    <div class="book-item" data-title="${book.title}" data-author="${book.author}">
                                        <div class="row align-items-center">
                                            <div class="col-md-6">
                                                <div class="form-check">
                                                    <input class="form-check-input book-checkbox" type="checkbox" 
                                                           name="bookId" value="${book.id}" id="book_${book.id}"
                                                           onchange="toggleQuantityInput(${book.id})">
                                                    <label class="form-check-label" for="book_${book.id}">
                                                        <div class="fw-bold text-dark">${book.title}</div>
                                                        <div class="text-muted small">by ${book.author}</div>
                                                        <div class="d-flex align-items-center mt-1">
                                                            <span class="badge bg-success me-2">
                                                                <i class="fas fa-boxes me-1"></i>${book.stockQuantity} in stock
                                                            </span>
                                                            <c:if test="${book.stockQuantity <= 5}">
                                                                <span class="badge bg-warning">
                                                                    <i class="fas fa-exclamation-triangle me-1"></i>Low Stock
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">LKR <fmt:formatNumber value="${book.price}" pattern="#,##0.00"/></div>
                                                    <small class="text-muted">per unit</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-group">
                                                    <button class="btn btn-outline-secondary btn-sm" type="button" onclick="changeQuantity(${book.id}, -1)" disabled>
                                                        <i class="fas fa-minus"></i>
                                                    </button>
                                                    <input type="number" class="form-control form-control-sm text-center quantity-input" 
                                                           name="quantity_${book.id}" min="1" max="${book.stockQuantity}" 
                                                           placeholder="0" disabled 
                                                           onchange="updateOrderSummary()" id="qty_${book.id}">
                                                    <button class="btn btn-outline-secondary btn-sm" type="button" onclick="changeQuantity(${book.id}, 1)" disabled>
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                                <small class="text-muted">Max: ${book.stockQuantity}</small>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Order Summary -->
                        <div class="order-summary-card">
                            <h6 class="mb-3"><i class="fas fa-calculator text-primary me-2"></i>Order Summary</h6>
                            <div id="orderSummary">
                                <div class="text-center text-muted py-3">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Select books to see order summary
                                </div>
                            </div>
                            <div class="total-amount" id="totalAmountContainer" style="display: none;">
                                <i class="fas fa-money-bill-wave me-2"></i>
                                Total: <span id="totalAmount">LKR 0.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Cancel
                        </button>
                        <button type="submit" class="action-btn btn-primary" id="createOrderBtn" disabled>
                            <span class="loading-spinner"></span>
                            <i class="fas fa-shopping-cart me-2"></i>Create Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Book data for calculations
        const bookPrices = {
            <c:forEach items="${books}" var="book" varStatus="status">
                ${book.id}: ${book.price}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        };

        const bookTitles = {
            <c:forEach items="${books}" var="book" varStatus="status">
                ${book.id}: "${book.title}"<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        };

        const bookStock = {
            <c:forEach items="${books}" var="book" varStatus="status">
                ${book.id}: ${book.stockQuantity}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        };

        // Sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
            document.body.style.overflow = sidebar.classList.contains('show') ? 'hidden' : 'auto';
        }

        // Customer selection handler
        document.getElementById('customerId').addEventListener('change', function() {
            const customerInfo = document.getElementById('customerInfo');
            const selectedCustomerName = document.getElementById('selectedCustomerName');
            
            if (this.value) {
                const selectedOption = this.options[this.selectedIndex];
                selectedCustomerName.textContent = selectedOption.dataset.name + ' (' + selectedOption.dataset.phone + ')';
                customerInfo.style.display = 'block';
            } else {
                customerInfo.style.display = 'none';
            }
        });

        // Book search functionality
        document.getElementById('bookSearch').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const bookItems = document.querySelectorAll('.book-item');
            
            bookItems.forEach(item => {
                const title = item.dataset.title.toLowerCase();
                const author = item.dataset.author.toLowerCase();
                
                if (title.includes(searchTerm) || author.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });

        // Order search and filter
        document.getElementById('searchOrders').addEventListener('input', function() {
            filterOrders();
        });

        document.getElementById('statusFilter').addEventListener('change', function() {
            filterOrders();
        });

        function filterOrders() {
            const searchTerm = document.getElementById('searchOrders').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const tableBody = document.querySelector('#ordersTable tbody');
            const rows = tableBody.querySelectorAll('tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const customerName = row.cells[1].textContent.toLowerCase();
                const orderId = row.cells[0].textContent.toLowerCase();
                const accountNumber = row.cells[2].textContent.toLowerCase();
                const status = row.cells[4].textContent.trim();
                
                const matchesSearch = customerName.includes(searchTerm) || 
                                    orderId.includes(searchTerm) || 
                                    accountNumber.includes(searchTerm);
                const matchesStatus = !statusFilter || status.includes(statusFilter);
                
                if (matchesSearch && matchesStatus) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('orderCount').textContent = visibleCount + ' orders';
        }

        // Quantity management
        function changeQuantity(bookId, change) {
            const quantityInput = document.getElementById('qty_' + bookId);
            let currentValue = parseInt(quantityInput.value) || 0;
            let newValue = currentValue + change;
            
            if (newValue < 1) newValue = 1;
            if (newValue > bookStock[bookId]) newValue = bookStock[bookId];
            
            quantityInput.value = newValue;
            updateOrderSummary();
        }

        function toggleQuantityInput(bookId) {
            const checkbox = document.getElementById('book_' + bookId);
            const bookItem = checkbox.closest('.book-item');
            const quantityInput = document.getElementById('qty_' + bookId);
            const decreaseBtn = bookItem.querySelector('button[onclick*="' + bookId + ', -1"]');
            const increaseBtn = bookItem.querySelector('button[onclick*="' + bookId + ', 1"]');
            
            if (checkbox.checked) {
                bookItem.classList.add('selected');
                quantityInput.disabled = false;
                quantityInput.value = 1;
                decreaseBtn.disabled = false;
                increaseBtn.disabled = false;
            } else {
                bookItem.classList.remove('selected');
                quantityInput.disabled = true;
                quantityInput.value = '';
                decreaseBtn.disabled = true;
                increaseBtn.disabled = true;
            }
            
            updateOrderSummary();
        }

        function updateOrderSummary() {
            const checkedBoxes = document.querySelectorAll('.book-checkbox:checked');
            const summaryDiv = document.getElementById('orderSummary');
            const totalAmountSpan = document.getElementById('totalAmount');
            const totalAmountContainer = document.getElementById('totalAmountContainer');
            const createOrderBtn = document.getElementById('createOrderBtn');
            
            let summaryHtml = '';
            let totalAmount = 0;
            let itemCount = 0;
            
            if (checkedBoxes.length === 0) {
                summaryHtml = `
                    <div class="text-center text-muted py-3">
                        <i class="fas fa-info-circle me-2"></i>
                        Select books to see order summary
                    </div>
                `;
                totalAmountContainer.style.display = 'none';
                createOrderBtn.disabled = true;
            } else {
                summaryHtml = '<div>';
                
                checkedBoxes.forEach(checkbox => {
                    const bookId = checkbox.value;
                    const quantityInput = document.getElementById('qty_' + bookId);
                    const quantity = parseInt(quantityInput.value) || 0;
                    
                    if (quantity > 0) {
                        const price = bookPrices[bookId];
                        const subtotal = price * quantity;
                        totalAmount += subtotal;
                        itemCount += quantity;
                        
                        summaryHtml += `
                            <div class="summary-item">
                                <div class="flex-grow-1">
                                    <div class="fw-bold">${bookTitles[bookId]}</div>
                                    <small class="text-muted">${quantity} × LKR ${price.toLocaleString('en-US', {minimumFractionDigits: 2})}</small>
                                </div>
                                <div class="fw-bold text-success">
                                    LKR ${subtotal.toLocaleString('en-US', {minimumFractionDigits: 2})}
                                </div>
                            </div>
                        `;
                    }
                });
                
                summaryHtml += '</div>';
                totalAmountContainer.style.display = 'block';
                createOrderBtn.disabled = totalAmount === 0;
            }
            
            summaryDiv.innerHTML = summaryHtml;
            totalAmountSpan.textContent = 'LKR ' + totalAmount.toLocaleString('en-US', {minimumFractionDigits: 2});
            
            // Update button text with item count
            if (itemCount > 0) {
                createOrderBtn.innerHTML = `
                    <span class="loading-spinner"></span>
                    <i class="fas fa-shopping-cart me-2"></i>Create Order (${itemCount} items)
                `;
            } else {
                createOrderBtn.innerHTML = `
                    <span class="loading-spinner"></span>
                    <i class="fas fa-shopping-cart me-2"></i>Create Order
                `;
            }
        }

        // Modal reset
        document.getElementById('createOrderModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('createOrderForm').reset();
            document.querySelectorAll('.book-item').forEach(item => {
                item.classList.remove('selected');
            });
            document.querySelectorAll('.quantity-input').forEach(input => {
                input.disabled = true;
                input.value = '';
            });
            document.querySelectorAll('.book-item button').forEach(btn => {
                btn.disabled = true;
            });
            document.getElementById('customerInfo').style.display = 'none';
            document.getElementById('bookSearch').value = '';
            document.querySelectorAll('.book-item').forEach(item => {
                item.style.display = 'block';
            });
            updateOrderSummary();
        });

        // Form submission with loading state
        document.getElementById('createOrderForm').addEventListener('submit', function(e) {
            const customerId = document.getElementById('customerId').value;
            const checkedBoxes = document.querySelectorAll('.book-checkbox:checked');
            
            if (!customerId) {
                e.preventDefault();
                alert('Please select a customer');
                return;
            }
            
            if (checkedBoxes.length === 0) {
                e.preventDefault();
                alert('Please select at least one book');
                return;
            }
            
            let hasValidQuantity = false;
            checkedBoxes.forEach(checkbox => {
                const bookId = checkbox.value;
                const quantityInput = document.getElementById('qty_' + bookId);
                const quantity = parseInt(quantityInput.value) || 0;
                if (quantity > 0) {
                    hasValidQuantity = true;
                }
            });
            
            if (!hasValidQuantity) {
                e.preventDefault();
                alert('Please enter valid quantities for selected books');
                return;
            }

            // Show loading state
            const createOrderBtn = document.getElementById('createOrderBtn');
            createOrderBtn.disabled = true;
            createOrderBtn.querySelector('.loading-spinner').style.display = 'inline-block';
            createOrderBtn.innerHTML = `
                <span class="loading-spinner" style="display: inline-block;"></span>
                <i class="fas fa-spinner fa-spin me-2"></i>Creating Order...
            `;
        });

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Animate loading elements
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });

            // Handle responsive sidebar
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth <= 992) {
                        toggleSidebar();
                    }
                });
            });

            // Auto-dismiss alerts
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        });

        // Handle window resize
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            if (window.innerWidth > 992) {
                sidebar.classList.remove('show');
                document.body.style.overflow = 'auto';
            }
        });
    </script>
</body>
</html>