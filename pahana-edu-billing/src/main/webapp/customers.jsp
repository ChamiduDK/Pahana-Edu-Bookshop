<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Pahana Edu Bookshop</title>
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

        /* Improved Customer Cards */
        .customer-card {
            position: relative;
            overflow: hidden;
        }

        .customer-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .customer-avatar {
            width: 64px;
            height: 64px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .customer-info {
            margin-bottom: 1.5rem;
        }

        .customer-info h5 {
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            font-size: 1.25rem;
        }

        .customer-detail {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #64748b;
        }

        .customer-detail i {
            width: 20px;
            margin-right: 0.75rem;
            color: var(--primary-color);
        }

        .customer-stats {
            background: #f8fafc;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        .stat-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .stat-item:last-child {
            margin-bottom: 0;
        }

        .stat-label {
            font-size: 0.85rem;
            color: #64748b;
        }

        .stat-value {
            font-weight: 600;
            color: var(--dark-color);
        }

        /* Action Buttons */
        .action-btn {
            padding: 0.75rem 1rem;
            border: none;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            min-width: 44px;
            min-height: 44px;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-info {
            background: var(--success-gradient);
            color: white;
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-secondary {
            background: #e2e8f0;
            color: #475569;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
            color: white;
        }

        .btn-secondary:hover {
            background: #cbd5e1;
            color: #334155;
        }

        /* Account Badge */
        .account-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            background: var(--primary-gradient);
            color: white;
            box-shadow: var(--shadow-light);
        }

        /* Enhanced Search Card */
        .search-card {
            margin-bottom: 2rem;
        }

        .search-input-group {
            position: relative;
        }

        .search-input-group .form-control {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 1rem 1rem 1rem 3rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .search-input-group .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-input-group .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            z-index: 3;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
        }

        .empty-state i {
            font-size: 4rem;
            color: #e2e8f0;
            margin-bottom: 1.5rem;
        }

        .empty-state h5 {
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        /* Modal Improvements */
        .modal-content {
            border-radius: var(--border-radius);
            border: none;
            box-shadow: var(--shadow-heavy);
        }

        .modal-header {
            border-bottom: 1px solid #e2e8f0;
            padding: 1.5rem;
            background: #f8fafc;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .modal-footer {
            border-top: 1px solid #e2e8f0;
            padding: 1.5rem;
            background: #f8fafc;
            border-radius: 0 0 var(--border-radius) var(--border-radius);
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 0.875rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        /* Enhanced Alerts */
        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
        }

        /* Stats Cards */
        .stats-row {
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: var(--shadow-light);
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-medium);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 1rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .stat-text {
            font-size: 0.9rem;
            color: #64748b;
            font-weight: 500;
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

            .customer-card {
                margin-bottom: 1.5rem;
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

            .card-body {
                padding: 1.5rem;
            }

            .action-btn {
                padding: 0.5rem 0.75rem;
                font-size: 0.8rem;
            }

            .customer-actions {
                gap: 0.5rem;
            }

            .customer-actions .action-btn {
                flex: 1;
                min-width: auto;
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

        /* Utility Classes */
        .text-truncate {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .clickable {
            cursor: pointer;
        }

        /* Form Validation Styles */
        .was-validated .form-control:invalid,
        .form-control.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }

        .was-validated .form-control:valid,
        .form-control.is-valid {
            border-color: #28a745;
            box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.1);
        }

        .invalid-feedback {
            font-size: 0.875rem;
            margin-top: 0.5rem;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/customers">
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
                <h4>Customer Management</h4>
                <div class="topbar-subtitle">Manage customer information and view their orders</div>
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
                    <i class="fas fa-exclamation-circle"></i> 
                    <span>${error}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show loading" role="alert">
                    <i class="fas fa-check-circle"></i> 
                    <span>${success}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Header with Actions -->
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-3 loading">
                <div>
                    <h5 class="mb-1" style="color: var(--dark-color); font-weight: 700; font-size: 1.5rem;">Customer Directory</h5>
                    <p class="text-muted mb-0">Manage your customer database and track their activities</p>
                </div>
                <button class="action-btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                    <i class="fas fa-user-plus"></i> Add New Customer
                </button>
            </div>

            <!-- Stats Row -->
            <div class="row stats-row loading">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stat-card">
                        <div class="stat-icon" style="background: var(--primary-gradient);">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number">${customers.size()}</div>
                        <div class="stat-text">Total Customers</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stat-card">
                        <div class="stat-icon" style="background: var(--success-gradient);">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="stat-number">
                            <c:set var="totalUnits" value="0"/>
                            <c:forEach items="${customers}" var="customer">
                                <c:set var="totalUnits" value="${totalUnits + customer.unitsConsumed}"/>
                            </c:forEach>
                            ${totalUnits}
                        </div>
                        <div class="stat-text">Total Units</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stat-card">
                        <div class="stat-icon" style="background: var(--warning-gradient);">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stat-number">
                            <c:set var="activeCustomers" value="0"/>
                            <c:forEach items="${customers}" var="customer">
                                <c:if test="${customer.unitsConsumed > 0}">
                                    <c:set var="activeCustomers" value="${activeCustomers + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${activeCustomers}
                        </div>
                        <div class="stat-text">Active Customers</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stat-card">
                        <div class="stat-icon" style="background: var(--danger-gradient);">
                            <i class="fas fa-user-clock"></i>
                        </div>
                        <div class="stat-number">${customers.size() - activeCustomers}</div>
                        <div class="stat-text">New Customers</div>
                    </div>
                </div>
            </div>

            <!-- Enhanced Search Controls -->
            <div class="card search-card loading">
                <div class="card-header">
                    <h5><i class="fas fa-search me-2"></i>Find Customers</h5>
                </div>
                <div class="card-body">
                    <form method="get" action="${pageContext.request.contextPath}/customers" class="row g-3">
                        <input type="hidden" name="action" value="search">
                        <div class="col-md-8">
                            <div class="search-input-group">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" 
                                       class="form-control" 
                                       name="searchTerm" 
                                       placeholder="Search by name, account number, telephone, or email..." 
                                       value="${searchTerm}">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="action-btn btn-primary w-100">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                        <div class="col-md-2">
                            <a href="${pageContext.request.contextPath}/customers" class="action-btn btn-secondary w-100">
                                <i class="fas fa-undo"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Enhanced Customers Grid -->
            <div class="row">
                <c:forEach items="${customers}" var="customer" varStatus="status">
                    <div class="col-xxl-3 col-xl-4 col-lg-6 col-md-6 mb-4">
                        <div class="card customer-card h-100 loading" style="animation-delay: ${status.index * 0.1}s;">
                            <span class="account-badge">#${customer.accountNumber}</span>
                            <div class="card-body">
                                <div class="customer-avatar">
                                    ${customer.name.substring(0, 1).toUpperCase()}
                                </div>
                                
                                <div class="customer-info">
                                    <h5 class="text-truncate" title="${customer.name}">${customer.name}</h5>
                                    
                                    <div class="customer-detail">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span class="text-truncate" title="${customer.address}">${customer.address}</span>
                                    </div>
                                    
                                    <div class="customer-detail">
                                        <i class="fas fa-phone"></i>
                                        <span>${customer.telephone}</span>
                                    </div>
                                    
                                    <c:if test="${not empty customer.email}">
                                        <div class="customer-detail">
                                            <i class="fas fa-envelope"></i>
                                            <span class="text-truncate" title="${customer.email}">${customer.email}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="customer-stats">
                                    <div class="stat-item">
                                        <span class="stat-label">Units Consumed:</span>
                                        <span class="stat-value">
                                            <span class="badge bg-success">${customer.unitsConsumed}</span>
                                        </span>
                                    </div>
                                    <div class="stat-item">
                                        <span class="stat-label">Status:</span>
                                        <span class="stat-value">
                                            <c:choose>
                                                <c:when test="${customer.unitsConsumed > 0}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">New</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>

                                <div class="customer-actions d-flex flex-wrap gap-2">
                                    <button class="action-btn btn-primary flex-fill" 
                                            onclick="editCustomer(${customer.id}, '${customer.accountNumber}', '${customer.name}', '${customer.address}', '${customer.telephone}', '${customer.email}', ${customer.unitsConsumed})"
                                            title="Edit Customer">
                                        <i class="fas fa-edit"></i>
                                        <span class="d-none d-sm-inline">Edit</span>
                                    </button>
                                    <a href="${pageContext.request.contextPath}/orders?action=customer&customerId=${customer.id}" 
                                       class="action-btn btn-info flex-fill"
                                       title="View Orders">
                                        <i class="fas fa-shopping-cart"></i>
                                        <span class="d-none d-sm-inline">Orders</span>
                                    </a>
                                    <button type="button" 
                                            class="action-btn btn-danger"
                                            onclick="confirmDelete(${customer.id}, '${customer.name}')"
                                            title="Delete Customer">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Enhanced Empty State -->
            <c:if test="${empty customers}">
                <div class="empty-state loading">
                    <i class="fas fa-users"></i>
                    <h5>No Customers Found</h5>
                    <p class="mb-4">
                        <c:choose>
                            <c:when test="${not empty searchTerm}">
                                No customers match your search criteria. Try a different search term or clear the search to see all customers.
                            </c:when>
                            <c:otherwise>
                                Start building your customer database by adding your first customer.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="d-flex flex-column flex-sm-row gap-2 justify-content-center">
                        <button class="action-btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                            <i class="fas fa-user-plus"></i> Add Your First Customer
                        </button>
                        <c:if test="${not empty searchTerm}">
                            <a href="${pageContext.request.contextPath}/customers" class="action-btn btn-secondary">
                                <i class="fas fa-list"></i> View All Customers
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Enhanced Add Customer Modal -->
    <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addCustomerModalLabel">
                        <i class="fas fa-user-plus me-2"></i>Add New Customer
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/customers" novalidate class="needs-validation">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="accountNumber" class="form-label">
                                    Account Number <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="text" 
                                           class="form-control" 
                                           id="accountNumber" 
                                           name="accountNumber" 
                                           required
                                           placeholder="e.g., AC001234">
                                    <button type="button" 
                                            class="action-btn btn-secondary" 
                                            onclick="generateAccountNumber()"
                                            title="Generate Account Number">
                                        <i class="fas fa-magic"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback">
                                    Please provide a valid account number.
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="customerName" class="form-label">
                                    Full Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="customerName" 
                                       name="name" 
                                       required
                                       placeholder="Enter customer's full name">
                                <div class="invalid-feedback">
                                    Please provide the customer's full name.
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-2">
                            <div class="col-12">
                                <label for="customerAddress" class="form-label">
                                    Address <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" 
                                          id="customerAddress" 
                                          name="address" 
                                          rows="3" 
                                          required
                                          placeholder="Enter complete address with street, city, and postal code"></textarea>
                                <div class="invalid-feedback">
                                    Please provide the customer's address.
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <label for="customerTelephone" class="form-label">
                                    Telephone <span class="text-danger">*</span>
                                </label>
                                <input type="tel" 
                                       class="form-control" 
                                       id="customerTelephone" 
                                       name="telephone" 
                                       required
                                       placeholder="+94 XX XXX XXXX"
                                       pattern="[+]?[0-9\s\-\(\)]{7,}">
                                <div class="invalid-feedback">
                                    Please provide a valid telephone number.
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="customerEmail" class="form-label">
                                    Email Address <small class="text-muted">(Optional)</small>
                                </label>
                                <input type="email" 
                                       class="form-control" 
                                       id="customerEmail" 
                                       name="email"
                                       placeholder="customer@example.com">
                                <div class="invalid-feedback">
                                    Please provide a valid email address.
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <label for="unitsConsumed" class="form-label">
                                    Initial Units Consumed <small class="text-muted">(Optional)</small>
                                </label>
                                <input type="number" 
                                       class="form-control" 
                                       id="unitsConsumed" 
                                       name="unitsConsumed" 
                                       min="0" 
                                       value="0"
                                       placeholder="0">
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="action-btn btn-primary">
                            <i class="fas fa-save"></i> Add Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Enhanced Edit Customer Modal -->
    <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-labelledby="editCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editCustomerModalLabel">
                        <i class="fas fa-user-edit me-2"></i>Edit Customer
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/customers" novalidate class="needs-validation">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="editCustomerId">
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="editAccountNumber" class="form-label">Account Number</label>
                                <input type="text" 
                                       class="form-control" 
                                       id="editAccountNumber" 
                                       name="accountNumber" 
                                       readonly
                                       style="background-color: #f8fafc;">
                                <small class="text-muted">Account number cannot be changed</small>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editCustomerName" class="form-label">
                                    Full Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="editCustomerName" 
                                       name="name" 
                                       required>
                                <div class="invalid-feedback">
                                    Please provide the customer's full name.
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-2">
                            <div class="col-12">
                                <label for="editCustomerAddress" class="form-label">
                                    Address <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" 
                                          id="editCustomerAddress" 
                                          name="address" 
                                          rows="3" 
                                          required></textarea>
                                <div class="invalid-feedback">
                                    Please provide the customer's address.
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <label for="editCustomerTelephone" class="form-label">
                                    Telephone <span class="text-danger">*</span>
                                </label>
                                <input type="tel" 
                                       class="form-control" 
                                       id="editCustomerTelephone" 
                                       name="telephone" 
                                       required
                                       pattern="[+]?[0-9\s\-\(\)]{7,}">
                                <div class="invalid-feedback">
                                    Please provide a valid telephone number.
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editCustomerEmail" class="form-label">
                                    Email Address <small class="text-muted">(Optional)</small>
                                </label>
                                <input type="email" 
                                       class="form-control" 
                                       id="editCustomerEmail" 
                                       name="email">
                                <div class="invalid-feedback">
                                    Please provide a valid email address.
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-2">
                            <div class="col-md-6">
                                <label for="editUnitsConsumed" class="form-label">Units Consumed</label>
                                <input type="number" 
                                       class="form-control" 
                                       id="editUnitsConsumed" 
                                       name="unitsConsumed" 
                                       min="0">
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="action-btn btn-primary">
                            <i class="fas fa-save"></i> Update Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">
                        <i class="fas fa-exclamation-triangle me-2 text-danger"></i>Confirm Deletion
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete customer <strong id="deleteCustomerName"></strong>?</p>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        This action cannot be undone. All associated data will be permanently removed.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/customers" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteCustomerId">
                        <button type="submit" class="action-btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Customer
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle functionality
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
            document.body.style.overflow = sidebar.classList.contains('show') ? 'hidden' : 'auto';
        }

        // Enhanced edit customer function
        function editCustomer(id, accountNumber, name, address, telephone, email, unitsConsumed) {
            document.getElementById('editCustomerId').value = id;
            document.getElementById('editAccountNumber').value = accountNumber;
            document.getElementById('editCustomerName').value = name;
            document.getElementById('editCustomerAddress').value = address;
            document.getElementById('editCustomerTelephone').value = telephone;
            document.getElementById('editCustomerEmail').value = email || '';
            document.getElementById('editUnitsConsumed').value = unitsConsumed;
            
            // Clear any previous validation states
            const form = document.querySelector('#editCustomerModal form');
            form.classList.remove('was-validated');
            form.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
            form.querySelectorAll('.is-valid').forEach(el => el.classList.remove('is-valid'));
            
            new bootstrap.Modal(document.getElementById('editCustomerModal')).show();
        }

        // Enhanced delete confirmation
        function confirmDelete(id, name) {
            document.getElementById('deleteCustomerId').value = id;
            document.getElementById('deleteCustomerName').textContent = name;
            new bootstrap.Modal(document.getElementById('confirmDeleteModal')).show();
        }

        // Generate account number functionality
        function generateAccountNumber() {
            const btn = event.target.closest('button');
            const originalContent = btn.innerHTML;
            
            // Show loading state
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            btn.disabled = true;
            
            fetch('${pageContext.request.contextPath}/customers?action=generateAccount')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to generate account number');
                    }
                    return response.text();
                })
                .then(accountNumber => {
                    document.getElementById('accountNumber').value = accountNumber;
                    // Show success feedback
                    btn.innerHTML = '<i class="fas fa-check text-success"></i>';
                    setTimeout(() => {
                        btn.innerHTML = originalContent;
                        btn.disabled = false;
                    }, 2000);
                })
                .catch(error => {
                    console.error('Error generating account number:', error);
                    // Show error feedback
                    btn.innerHTML = '<i class="fas fa-exclamation-triangle text-danger"></i>';
                    setTimeout(() => {
                        btn.innerHTML = originalContent;
                        btn.disabled = false;
                    }, 2000);
                    
                    // Show user-friendly error message
                    const alert = document.createElement('div');
                    alert.className = 'alert alert-danger alert-dismissible fade show';
                    alert.innerHTML = `
                        <i class="fas fa-exclamation-circle"></i>
                        Failed to generate account number. Please try again or enter manually.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    `;
                    document.querySelector('.modal-body').insertBefore(alert, document.querySelector('.modal-body').firstChild);
                });
        }

        // Form validation enhancement
        function setupFormValidation() {
            const forms = document.querySelectorAll('.needs-validation');
            
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                        
                        // Focus on first invalid field
                        const firstInvalid = form.querySelector(':invalid');
                        if (firstInvalid) {
                            firstInvalid.focus();
                        }
                    }
                    
                    form.classList.add('was-validated');
                }, false);

                // Real-time validation
                const inputs = form.querySelectorAll('input, textarea, select');
                inputs.forEach(input => {
                    input.addEventListener('blur', () => {
                        if (form.classList.contains('was-validated')) {
                            if (input.checkValidity()) {
                                input.classList.remove('is-invalid');
                                input.classList.add('is-valid');
                            } else {
                                input.classList.remove('is-valid');
                                input.classList.add('is-invalid');
                            }
                        }
                    });

                    input.addEventListener('input', () => {
                        if (input.classList.contains('is-invalid') && input.checkValidity()) {
                            input.classList.remove('is-invalid');
                            input.classList.add('is-valid');
                        }
                    });
                });
            });
        }

        // Search enhancement
        function setupSearchEnhancements() {
            const searchInput = document.querySelector('input[name="searchTerm"]');
            if (searchInput) {
                let searchTimeout;
                
                searchInput.addEventListener('input', function() {
                    clearTimeout(searchTimeout);
                    
                    // Show loading indicator
                    const searchIcon = document.querySelector('.search-icon');
                    if (searchIcon) {
                        searchIcon.className = 'fas fa-spinner fa-spin search-icon';
                    }
                    
                    // Debounce search
                    searchTimeout = setTimeout(() => {
                        if (searchIcon) {
                            searchIcon.className = 'fas fa-search search-icon';
                        }
                    }, 500);
                });
            }
        }

        // Initialize everything when DOM is loaded
        document.addEventListener('DOMContentLoaded', function() {
            // Animate loading elements
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });

            // Setup form validation
            setupFormValidation();
            
            // Setup search enhancements
            setupSearchEnhancements();

            // Auto-generate account number when add modal is shown
            document.getElementById('addCustomerModal').addEventListener('shown.bs.modal', function() {
                const accountNumberInput = document.getElementById('accountNumber');
                if (!accountNumberInput.value) {
                    generateAccountNumber();
                }
                
                // Focus on customer name field
                setTimeout(() => {
                    document.getElementById('customerName').focus();
                }, 500);
            });

            // Clear form when add modal is hidden
            document.getElementById('addCustomerModal').addEventListener('hidden.bs.modal', function() {
                const form = this.querySelector('form');
                form.reset();
                form.classList.remove('was-validated');
                form.querySelectorAll('.is-invalid, .is-valid').forEach(el => {
                    el.classList.remove('is-invalid', 'is-valid');
                });
            });

            // Handle navigation links for mobile
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth <= 992) {
                        toggleSidebar();
                    }
                });
            });

            // Auto-dismiss alerts after 5 seconds
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert:not(.alert-warning)');
                alerts.forEach(alert => {
                    const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
                    if (bsAlert) {
                        bsAlert.close();
                    }
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

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl/Cmd + K to focus search
            if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                e.preventDefault();
                const searchInput = document.querySelector('input[name="searchTerm"]');
                if (searchInput) {
                    searchInput.focus();
                    searchInput.select();
                }
            }
            
            // Ctrl/Cmd + N to add new customer
            if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
                e.preventDefault();
                const addBtn = document.querySelector('[data-bs-target="#addCustomerModal"]');
                if (addBtn) {
                    addBtn.click();
                }
            }
        });

        // Add loading state to buttons
        function addLoadingState(button) {
            const originalContent = button.innerHTML;
            button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            button.disabled = true;
            
            return () => {
                button.innerHTML = originalContent;
                button.disabled = false;
            };
        }

        // Enhanced tooltip initialization
        document.addEventListener('DOMContentLoaded', function() {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
            tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl, {
                    placement: 'top',
                    trigger: 'hover'
                });
            });
        });
    </script>
</body>
</html>