<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details #${order.id} - Pahana Edu Bookshop</title>
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
            --border-radius: 16px;
            --shadow-light: 0 2px 8px rgba(0, 0, 0, 0.06);
            --shadow-medium: 0 4px 20px rgba(0, 0, 0, 0.08);
            --shadow-heavy: 0 8px 40px rgba(0, 0, 0, 0.12);
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
            line-height: 1.6;
        }

        /* Sidebar Styles - UNCHANGED */
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
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        }

        /* Topbar - UNCHANGED */
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

        /* Content Area - IMPROVED */
        .content-area {
            padding: 2rem;
            min-height: calc(100vh - var(--topbar-height));
        }

        /* Order Header Card - IMPROVED */
        .order-header {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .order-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .order-header .order-id {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .order-header .order-meta {
            color: #64748b;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
        }

        .status-badge {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-badge.bg-warning {
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%) !important;
            color: white;
        }

        .status-badge.bg-info {
            background: var(--success-gradient) !important;
            color: white;
        }

        .status-badge.bg-primary {
            background: var(--primary-gradient) !important;
            color: white;
        }

        .status-badge.bg-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%) !important;
            color: white;
        }

        .status-badge.bg-danger {
            background: var(--danger-gradient) !important;
            color: white;
        }

        .total-amount {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--primary-color);
            margin-top: 1rem;
        }

        /* Cards - IMPROVED */
        .card {
            background: white;
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .card-header {
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 1.5rem;
            font-weight: 600;
            color: var(--dark-color);
        }

        .card-header h5 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .card-header i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Customer Information - IMPROVED */
        .customer-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .info-section h6 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
            padding: 0.5rem 0;
        }

        .info-label {
            font-weight: 600;
            color: #374151;
            min-width: 100px;
            margin-right: 1rem;
        }

        .info-value {
            color: #6b7280;
        }

        .account-badge {
            background: var(--primary-gradient);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        /* Table - IMPROVED */
        .table-responsive {
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            font-size: 0.95rem;
        }

        .table th {
            background: #f8fafc;
            border: none;
            color: var(--dark-color);
            font-weight: 600;
            padding: 1.25rem 1rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 1.25rem 1rem;
            border-color: #f1f5f9;
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
        }

        .book-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
        }

        .book-meta {
            font-size: 0.85rem;
            color: #6b7280;
        }

        .quantity-badge {
            background: var(--primary-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            min-width: 50px;
            display: inline-block;
            text-align: center;
        }

        .price-cell {
            font-weight: 600;
            font-size: 0.95rem;
        }

        .subtotal-cell {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 1rem;
        }

        .table tfoot th {
            background: #f1f5f9;
            border-top: 2px solid #e2e8f0;
            font-weight: 700;
            color: var(--dark-color);
            font-size: 1rem;
        }

        .total-amount-table {
            font-size: 1.25rem;
            color: var(--primary-color);
            font-weight: 800;
        }

        /* Timeline - IMPROVED */
        .status-timeline {
            position: relative;
            padding: 1rem 0;
        }

        .status-timeline::before {
            content: '';
            position: absolute;
            left: 20px;
            top: 0;
            height: 100%;
            width: 3px;
            background: linear-gradient(to bottom, #e2e8f0 0%, #cbd5e1 100%);
            border-radius: 2px;
        }

        .timeline-item {
            position: relative;
            padding-left: 60px;
            padding-bottom: 2rem;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: 12px;
            top: 8px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #cbd5e1;
            border: 3px solid white;
            box-shadow: 0 0 0 3px #f1f5f9;
        }

        .timeline-item.active::before {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            box-shadow: 0 0 0 3px #dcfdf7;
        }

        .timeline-item.current::before {
            background: var(--primary-gradient);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), 0 0 0 6px rgba(102, 126, 234, 0.1); }
            70% { box-shadow: 0 0 0 6px rgba(102, 126, 234, 0), 0 0 0 12px rgba(102, 126, 234, 0); }
            100% { box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), 0 0 0 6px rgba(102, 126, 234, 0); }
        }

        .timeline-content h6 {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }

        .timeline-content .timeline-status {
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .timeline-content .timeline-description {
            font-size: 0.9rem;
            color: #6b7280;
            margin: 0;
            line-height: 1.4;
        }

        .timeline-date {
            font-size: 0.8rem;
            color: #9ca3af;
            font-weight: 500;
        }

        /* Action Buttons - IMPROVED */
        .action-btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            color: white;
        }

        .btn-info {
            background: var(--success-gradient);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
            color: white;
        }

        /* Customer Summary - IMPROVED */
        .summary-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem 1rem;
            border-radius: 12px;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }

        .stat-number.primary { color: var(--primary-color); }
        .stat-number.success { color: #10b981; }

        .stat-label {
            font-size: 0.85rem;
            color: #6b7280;
            font-weight: 500;
        }

        /* Order Actions Section - IMPROVED */
        .order-actions-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            align-items: center;
        }

        .action-meta h6 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
        }

        .meta-label {
            font-weight: 600;
            color: #374151;
            min-width: 120px;
            margin-right: 1rem;
        }

        .meta-value {
            color: #6b7280;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        /* Responsive - IMPROVED */
        @media (max-width: 1200px) {
            .customer-info-grid,
            .order-actions-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 9999;
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
                padding: 1.5rem;
            }

            .summary-stats {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                justify-content: center;
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
                padding: 1rem;
            }

            .order-header {
                padding: 1.5rem;
            }

            .order-header .order-id {
                font-size: 1.5rem;
            }

            .total-amount {
                font-size: 1.4rem;
            }

            .table {
                font-size: 0.85rem;
            }

            .table th,
            .table td {
                padding: 0.75rem 0.5rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .action-btn {
                justify-content: center;
            }
        }

        /* Loading Animation - IMPROVED */
        .loading {
            opacity: 0;
            animation: fadeInUp 0.8s ease-out forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Print Styles - IMPROVED */
        @media print {
            @page { 
                margin: 0.75in; 
                size: A4;
            }
            
            body { 
                font-size: 12pt;
                background: white !important;
            }
            
            .sidebar, 
            .topbar, 
            .action-btn,
            .card:hover {
                display: none !important;
                transform: none !important;
                box-shadow: none !important;
            }
            
            .main-content { 
                margin-left: 0 !important; 
                background: white !important;
            }
            
            .card {
                box-shadow: none !important;
                border: 1px solid #e2e8f0 !important;
                page-break-inside: avoid;
            }
            
            .order-header {
                border-bottom: 2px solid #000;
                margin-bottom: 1in;
            }
            
            .status-badge {
                border: 1px solid #000;
                background: white !important;
                color: #000 !important;
            }
            
            .timeline-item::before {
                background: #000 !important;
                box-shadow: none !important;
            }
            
            .table th {
                background: #f8f9fa !important;
                color: #000 !important;
            }
            
            .total-amount,
            .total-amount-table {
                color: #000 !important;
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
                <h4>Order Details #${order.id}</h4>
                <div class="topbar-subtitle">View and manage order information</div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <button class="btn btn-link d-md-none" onclick="toggleSidebar()">
                    <i class="fas fa-bars fa-lg"></i>
                </button>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Order Header -->
            <div class="order-header loading">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="order-id">
                            <i class="fas fa-receipt me-3"></i>Order #${order.id}
                        </div>
                        <div class="order-meta">
                            <i class="fas fa-calendar me-2"></i>
                            Placed on <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                            <span class="mx-3">•</span>
                            <i class="fas fa-user me-2"></i>
                            Processed by ${order.placedByUser.username}
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">
                                <span class="status-badge bg-warning">
                                    <i class="fas fa-clock"></i> PENDING
                                </span>
                            </c:when>
                            <c:when test="${order.status == 'CONFIRMED'}">
                                <span class="status-badge bg-info">
                                    <i class="fas fa-check-circle"></i> CONFIRMED
                                </span>
                            </c:when>
                            <c:when test="${order.status == 'SHIPPED'}">
                                <span class="status-badge bg-primary">
                                    <i class="fas fa-truck"></i> SHIPPED
                                </span>
                            </c:when>
                            <c:when test="${order.status == 'DELIVERED'}">
                                <span class="status-badge bg-success">
                                    <i class="fas fa-check-double"></i> DELIVERED
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge bg-danger">
                                    <i class="fas fa-times-circle"></i> CANCELLED
                                </span>
                            </c:otherwise>
                        </c:choose>
                        <div class="total-amount">
                            <i class="fas fa-dollar-sign"></i>
                            LKR <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Order Details -->
                <div class="col-lg-8">
                    <!-- Customer Information -->
                    <div class="card mb-4 loading">
                        <div class="card-header">
                            <h5><i class="fas fa-user"></i> Customer Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="customer-info-grid">
                                <div class="info-section">
                                    <h6>Customer Details</h6>
                                    <div class="info-item">
                                        <div class="info-label">Name:</div>
                                        <div class="info-value">${order.customer.name}</div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Account:</div>
                                        <div class="info-value">
                                            <span class="account-badge">${order.customer.accountNumber}</span>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Phone:</div>
                                        <div class="info-value">
                                            <i class="fas fa-phone me-2"></i>${order.customer.telephone}
                                        </div>
                                    </div>
                                    <c:if test="${not empty order.customer.email}">
                                        <div class="info-item">
                                            <div class="info-label">Email:</div>
                                            <div class="info-value">
                                                <i class="fas fa-envelope me-2"></i>${order.customer.email}
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="info-section">
                                    <h6>Shipping Address</h6>
                                    <div class="info-item">
                                        <div class="info-value">
                                            <i class="fas fa-map-marker-alt me-2"></i>
                                            <address class="mb-0">${order.customer.address}</address>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="card mb-4 loading">
                        <div class="card-header">
                            <h5><i class="fas fa-list"></i> Order Items (${order.orderItems.size()} items)</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table mb-0">
                                    <thead>
                                        <tr>
                                            <th>Book Details</th>
                                            <th>Category</th>
                                            <th class="text-center">Qty</th>
                                            <th class="text-end">Unit Price</th>
                                            <th class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <tr>
                                                <td>
                                                    <div class="book-title">${item.book.title}</div>
                                                    <div class="book-meta">by ${item.book.author}</div>
                                                </td>
                                                <td>
                                                    <span class="badge bg-light text-dark">${item.book.category}</span>
                                                </td>
                                                <td class="text-center">
                                                    <span class="quantity-badge">${item.quantity}</span>
                                                </td>
                                                <td class="text-end price-cell">
                                                    LKR <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/>
                                                </td>
                                                <td class="text-end subtotal-cell">
                                                    LKR <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="4" class="text-end">Total Amount:</th>
                                            <th class="text-end">
                                                <div class="total-amount-table">
                                                    LKR <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                                </div>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Order Actions -->
                    <div class="card loading">
                        <div class="card-header">
                            <h5><i class="fas fa-cogs"></i> Order Management</h5>
                        </div>
                        <div class="card-body">
                            <div class="order-actions-grid">
                                <div class="action-meta">
                                    <h6>Order Information</h6>
                                    <div class="meta-item">
                                        <div class="meta-label">Processed by:</div>
                                        <div class="meta-value">
                                            <i class="fas fa-user-tie me-2"></i>${order.placedByUser.username}
                                        </div>
                                    </div>
                                    <div class="meta-item">
                                        <div class="meta-label">Order Date:</div>
                                        <div class="meta-value">
                                            <i class="fas fa-calendar-alt me-2"></i>
                                            <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </div>
                                    </div>
                                    <div class="meta-item">
                                        <div class="meta-label">Items Count:</div>
                                        <div class="meta-value">
                                            <i class="fas fa-boxes me-2"></i>${order.orderItems.size()} items
                                        </div>
                                    </div>
                                </div>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/orders?action=admin" 
                                       class="action-btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to Orders
                                    </a>
                                    <button class="action-btn btn-primary" onclick="window.print()">
                                        <i class="fas fa-print"></i> Print Order
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Status Timeline and Customer Summary -->
                <div class="col-lg-4">
                    <!-- Order Status Timeline -->
                    <div class="card mb-4 loading">
                        <div class="card-header">
                            <h5><i class="fas fa-route"></i> Order Progress</h5>
                        </div>
                        <div class="card-body">
                            <div class="status-timeline">
                                <div class="timeline-item active">
                                    <div class="timeline-content">
                                        <h6>Order Placed</h6>
                                        <div class="timeline-status text-success">
                                            <i class="fas fa-check-circle me-1"></i>Completed
                                        </div>
                                        <div class="timeline-date">
                                            <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy HH:mm"/>
                                        </div>
                                        <p class="timeline-description">Order has been successfully placed and is being processed</p>
                                    </div>
                                </div>
                                
                                <div class="timeline-item ${order.status == 'CONFIRMED' or order.status == 'SHIPPED' or order.status == 'DELIVERED' ? 'active' : ''} ${order.status == 'CONFIRMED' ? 'current' : ''}">
                                    <div class="timeline-content">
                                        <h6>Order Confirmed</h6>
                                        <c:choose>
                                            <c:when test="${order.status == 'CONFIRMED' or order.status == 'SHIPPED' or order.status == 'DELIVERED'}">
                                                <div class="timeline-status text-success">
                                                    <i class="fas fa-check-circle me-1"></i>Completed
                                                </div>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <div class="timeline-status text-primary">
                                                    <i class="fas fa-spinner fa-spin me-1"></i>In Progress
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="timeline-status text-muted">
                                                    <i class="fas fa-clock me-1"></i>Pending
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <p class="timeline-description">Order confirmed and items are being prepared for shipment</p>
                                    </div>
                                </div>
                                
                                <div class="timeline-item ${order.status == 'SHIPPED' or order.status == 'DELIVERED' ? 'active' : ''} ${order.status == 'SHIPPED' ? 'current' : ''}">
                                    <div class="timeline-content">
                                        <h6>Order Shipped</h6>
                                        <c:choose>
                                            <c:when test="${order.status == 'SHIPPED' or order.status == 'DELIVERED'}">
                                                <div class="timeline-status text-success">
                                                    <i class="fas fa-check-circle me-1"></i>Completed
                                                </div>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">
                                                <div class="timeline-status text-primary">
                                                    <i class="fas fa-truck me-1"></i>In Transit
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="timeline-status text-muted">
                                                    <i class="fas fa-clock me-1"></i>Awaiting Shipment
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <p class="timeline-description">Order is on its way to the delivery address</p>
                                    </div>
                                </div>
                                
                                <div class="timeline-item ${order.status == 'DELIVERED' ? 'active current' : ''}">
                                    <div class="timeline-content">
                                        <h6>Order Delivered</h6>
                                        <c:choose>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <div class="timeline-status text-success">
                                                    <i class="fas fa-check-double me-1"></i>Delivered Successfully
                                                </div>
                                                <p class="timeline-description">
                                                    Order delivered successfully!<br>
                                                    <small class="text-info">
                                                        <i class="fas fa-envelope me-1"></i>Invoice sent to customer
                                                    </small>
                                                </p>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="timeline-status text-muted">
                                                    <i class="fas fa-clock me-1"></i>Pending Delivery
                                                </div>
                                                <p class="timeline-description">Order will be delivered once shipped</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <c:if test="${order.status == 'CANCELLED'}">
                                    <div class="timeline-item active">
                                        <div class="timeline-content">
                                            <h6 class="text-danger">Order Cancelled</h6>
                                            <div class="timeline-status text-danger">
                                                <i class="fas fa-times-circle me-1"></i>Cancelled
                                            </div>
                                            <p class="timeline-description">This order has been cancelled and will not be processed</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Customer Summary Card -->
                    <div class="card loading">
                        <div class="card-header">
                            <h5><i class="fas fa-chart-bar"></i> Customer Summary</h5>
                        </div>
                        <div class="card-body">
                            <div class="summary-stats">
                                <div class="stat-item">
                                    <div class="stat-number primary">${customerTotalUnits}</div>
                                    <div class="stat-label">Total Units Purchased</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number success">${order.orderItems.size()}</div>
                                    <div class="stat-label">Items in This Order</div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/orders?action=customer&customerId=${order.customer.id}" 
                                   class="action-btn btn-info">
                                    <i class="fas fa-history"></i> View Order History
                                </a>
                                <a href="${pageContext.request.contextPath}/customers" 
                                   class="action-btn btn-secondary">
                                    <i class="fas fa-user-edit"></i> Manage Customer
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
            document.body.style.overflow = sidebar.classList.contains('show') ? 'hidden' : 'auto';
        }

        document.addEventListener('DOMContentLoaded', function() {
            // Staggered loading animation
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.15}s`;
            });

            // Mobile navigation
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth <= 992) {
                        toggleSidebar();
                    }
                });
            });

            // Enhanced table row hover effect
            const tableRows = document.querySelectorAll('.table tbody tr');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(4px)';
                });
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0)';
                });
            });

            // Smooth scroll for internal links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });

        // Responsive sidebar management
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            if (window.innerWidth > 992) {
                sidebar.classList.remove('show');
                document.body.style.overflow = 'auto';
            }
        });

        // Print optimization
        window.addEventListener('beforeprint', function() {
            document.body.classList.add('printing');
        });

        window.addEventListener('afterprint', function() {
            document.body.classList.remove('printing');
        });
    </script>
</body>
</html>