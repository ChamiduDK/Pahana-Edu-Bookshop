<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --hero-gradient: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #ec4899 100%);
            --success-gradient: linear-gradient(135deg, #10b981 0%, #059669 100%);
            --card-gradient: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --accent-color: #ec4899;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --bg-primary: #f8fafc;
            --border-color: #e2e8f0;
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 8px 25px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 20px 40px rgba(0, 0, 0, 0.12);
            --border-radius-sm: 12px;
            --border-radius-md: 20px;
            --border-radius-lg: 28px;
        }

        * {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.7;
            font-weight: 400;
            margin: 0;
            padding: 0;
        }

        /* Layout Container */
        .dashboard-layout {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: var(--card-gradient);
            border-right: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 2rem 1.5rem;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            overflow-y: auto;
            z-index: 1100;
            transform: translateX(0);
        }

        .sidebar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2rem;
            text-decoration: none;
        }

        .sidebar-brand i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .sidebar-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-nav li {
            margin-bottom: 0.5rem;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 1rem;
            color: var(--text-secondary);
            text-decoration: none;
            border-radius: var(--border-radius-sm);
            font-weight: 500;
        }

        .sidebar-nav a:hover,
        .sidebar-nav a.active {
            background: var(--primary-gradient);
            color: white;
            transform: translateX(4px);
        }

        .sidebar-nav a i {
            width: 24px;
            text-align: center;
        }

        /* Main Content Area */
        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
            min-height: 100vh;
        }

        /* Header Styles */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px) saturate(180%);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
            text-decoration: none;
        }

        .navbar-brand i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-right: 0.5rem;
        }

        .nav-link {
            color: var(--text-secondary) !important;
            font-weight: 500;
            padding: 0.75rem 1rem !important;
            border-radius: var(--border-radius-sm);
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-1px);
        }

        .dropdown-menu {
            border: none;
            box-shadow: var(--shadow-lg);
            border-radius: var(--border-radius-md);
            padding: 1rem;
            margin-top: 0.5rem;
        }

        .dropdown-item {
            border-radius: var(--border-radius-sm);
            padding: 0.75rem 1rem;
            margin-bottom: 0.25rem;
            font-weight: 500;
        }

        .dropdown-item:hover {
            background: var(--primary-gradient);
            color: white;
            transform: translateX(4px);
        }

        /* Hero Section */
        .page-header {
            background: var(--hero-gradient);
            color: white;
            padding: 4rem 0;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Ccircle cx='30' cy='30' r='1'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .page-subtitle {
            font-size: 1.25rem;
            font-weight: 400;
            opacity: 0.9;
            position: relative;
        }

        /* Alert Styles */
        .alert {
            border: none;
            border-radius: var(--border-radius-md);
            padding: 1.25rem 1.5rem;
            margin-bottom: 2rem;
            font-weight: 500;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
            color: #dc2626;
            border-left: 4px solid #dc2626;
        }

        .alert-success {
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            color: #16a34a;
            border-left: 4px solid #16a34a;
        }

        /* Card Styles */
        .modern-card {
            background: var(--card-gradient);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            padding: 2.5rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .modern-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .section-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--primary-gradient);
            color: white;
            border-radius: var(--border-radius-sm);
            font-size: 1rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius-md);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: var(--primary-gradient);
            border-radius: var(--border-radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        /* Book Card Styles */
        .book-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius-md);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            height: 100%;
        }

        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-color);
        }

        .book-card .card-body {
            padding: 1.75rem;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .book-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
            line-height: 1.4;
        }

        .book-meta {
            color: var(--text-secondary);
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .book-meta i {
            width: 16px;
            color: var(--primary-color);
        }

        .book-price {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-color);
            margin: 1rem 0;
        }

        .stock-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .stock-high {
            background: #dcfce7;
            color: #16a34a;
        }

        .stock-medium {
            background: #fef3c7;
            color: #d97706;
        }

        .stock-low {
            background: #fecaca;
            color: #dc2626;
        }

        /* Grid Layout */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }

        /* Cart Form */
        .cart-form {
            margin-top: auto;
        }

        .quantity-input {
            border: 2px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            padding: 0.75rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .quantity-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            outline: none;
        }

        .btn-add-cart {
            background: var(--success-gradient);
            color: white;
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            box-shadow: var(--shadow-sm);
            width: 100%;
        }

        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            color: white;
        }

        /* Orders Table */
        .orders-table-container {
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.25rem 1.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        .table tbody td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
            font-weight: 500;
        }

        .table tbody tr:hover {
            background: rgba(99, 102, 241, 0.02);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .order-id {
            font-family: 'JetBrains Mono', monospace;
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: #fef3c7;
            color: #d97706;
        }

        .status-completed {
            background: #dcfce7;
            color: #16a34a;
        }

        .status-shipped {
            background: #dbeafe;
            color: #2563eb;
        }

        .order-items {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .order-items li {
            background: rgba(99, 102, 241, 0.05);
            padding: 0.5rem 1rem;
            margin-bottom: 0.5rem;
            border-radius: var(--border-radius-sm);
            border-left: 3px solid var(--primary-color);
            font-size: 0.9rem;
        }

        .order-items li:last-child {
            margin-bottom: 0;
        }

        /* Empty States */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--border-color);
            margin-bottom: 1.5rem;
        }

        .empty-state h4 {
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .btn-primary-modern {
            background: var(--primary-gradient);
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 0.875rem 2rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: var(--shadow-sm);
            color: white;
            text-decoration: none;
        }

        .btn-primary-modern:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            color: white;
        }

        /* Help Section */
        .help-section {
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .help-section h3 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
        }

        .help-section .accordion {
            --bs-accordion-border-radius: var(--border-radius-md);
            --bs-accordion-border-color: var(--border-color);
            --bs-accordion-btn-padding-y: 1rem;
            --bs-accordion-btn-padding-x: 1.5rem;
            --bs-accordion-body-padding: 1.5rem;
        }

        .help-section .accordion-button {
            font-weight: 600;
            color: var(--text-primary);
            background: var(--card-gradient);
        }

        .help-section .accordion-button:not(.collapsed) {
            background: var(--primary-gradient);
            color: white;
        }

        .help-section .accordion-body {
            background: var(--bg-primary);
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        /* Sidebar Toggle */
        .sidebar-toggle {
            display: none;
            position: fixed;
            top: 1rem;
            left: 1rem;
            z-index: 1200;
            background: var(--primary-gradient);
            color: white;
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 0.75rem;
            font-size: 1.2rem;
            box-shadow: var(--shadow-md);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .sidebar-toggle {
                display: block;
            }

            .page-title {
                font-size: 2rem;
            }

            .modern-card {
                padding: 1.5rem;
            }

            .books-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .book-card .card-body {
                padding: 1.25rem;
            }
        }

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .page-header {
                padding: 2rem 0;
            }

            .page-title {
                font-size: 1.75rem;
            }

            .page-subtitle {
                font-size: 1rem;
            }
        }

        /* Loading Animation */
        .loading-shimmer {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        /* Interactive Elements */
        .interactive-element {
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .interactive-element:hover {
            transform: translateY(-1px);
        }

        /* Ripple Effect */
        @keyframes ripple {
            to {
                transform: scale(2);
                opacity: 0;
            }
        }

        /* Sidebar Overlay for Mobile */
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1050;
        }

        .sidebar-overlay.active {
            display: block;
        }

        @media (max-width: 992px) {
            .sidebar-overlay.active {
                display: block;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-layout">
        <!-- Sidebar Toggle Button -->
        <button class="sidebar-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Sidebar Overlay -->
        <div class="sidebar-overlay" onclick="closeSidebar()"></div>

        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <a href="${pageContext.request.contextPath}/customer-dashboard" class="sidebar-brand">
                <i class="fas fa-book-open"></i> Pahana Edu
            </a>
            <ul class="sidebar-nav">
                <li><a href="${pageContext.request.contextPath}/customer-dashboard" class="active">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a></li>
                <li><a href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a></li>
                <li><a href="${pageContext.request.contextPath}/customer-orders">
                    <i class="fas fa-history"></i> My Orders
                </a></li>
                <li><a href="${pageContext.request.contextPath}/customer-profile">
                    <i class="fas fa-user"></i> Profile
                </a></li>
                <li><a href="#help-section" onclick="scrollToHelp()">
                    <i class="fas fa-question-circle"></i> Help
                </a></li>
                <li><a href="${pageContext.request.contextPath}/customer-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <nav class="header navbar navbar-expand-lg">
                <div class="container">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/customer-dashboard">
                        <i class="fas fa-book-open"></i> Pahana Edu Bookshop
                    </a>
                    <div class="navbar-nav ms-auto">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart me-2"></i>Cart
                        </a>
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-2"></i>${sessionScope.customer.name}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-orders">
                                    <i class="fas fa-history me-3"></i>My Orders
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-profile">
                                    <i class="fas fa-user-edit me-3"></i>Profile
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/customer-logout">
                                    <i class="fas fa-sign-out-alt me-3"></i>Logout
                                </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <section class="page-header">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <h1 class="page-title">Welcome back, ${sessionScope.customer.name}!</h1>
                            <p class="page-subtitle">Discover your next favorite book and track your reading journey</p>
                        </div>
                        <div class="col-lg-4 text-end">
                            <i class="fas fa-graduation-cap" style="font-size: 6rem; opacity: 0.2;"></i>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Content Container -->
            <div class="container mt-5">
                <!-- Alerts -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-3"></i>
                        <strong>Attention:</strong> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-3"></i>
                        <strong>Success:</strong> ${success}
                    </div>
                </c:if>

                <!-- Stats Overview -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-books"></i>
                        </div>
                        <div class="stat-value">${books.size()}</div>
                        <div class="stat-label">Books Available</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <div class="stat-value">${orders.size()}</div>
                        <div class="stat-label">Total Orders</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="stat-value">4.9</div>
                        <div class="stat-label">Customer Rating</div>
                    </div>
                </div>

                <!-- Books Section -->
                <div class="modern-card" id="books">
                    <h3 class="section-title">
                        <i class="fas fa-book-open"></i>
                        Featured Books
                    </h3>
                    
                    <c:choose>
                        <c:when test="${empty books}">
                            <div class="empty-state">
                                <i class="fas fa-book"></i>
                                <h4>No Books Available</h4>
                                <p>We're currently updating our inventory. Please check back soon!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="books-grid">
                                <c:forEach items="${books}" var="book">
                                    <div class="book-card interactive-element">
                                        <div class="card-body">
                                            <h5 class="book-title">${book.title}</h5>
                                            
                                            <div class="book-meta">
                                                <i class="fas fa-user"></i>
                                                <span>${book.author}</span>
                                            </div>
                                            
                                            <div class="book-price">
                                                <fmt:formatNumber value="${book.price}" pattern="0.00"/> LKR
                                            </div>
                                            
                                            <c:choose>
                                                <c:when test="${book.stockQuantity > 10}">
                                                    <div class="stock-badge stock-high">
                                                        <i class="fas fa-check-circle"></i>
                                                        In Stock (${book.stockQuantity})
                                                    </div>
                                                </c:when>
                                                <c:when test="${book.stockQuantity > 5}">
                                                    <div class="stock-badge stock-medium">
                                                        <i class="fas fa-exclamation-triangle"></i>
                                                        Limited Stock (${book.stockQuantity})
                                                    </div>
                                                </c:when>
                                                <c:when test="${book.stockQuantity > 0}">
                                                    <div class="stock-badge stock-low">
                                                        <i class="fas fa-exclamation-circle"></i>
                                                        Low Stock (${book.stockQuantity})
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="stock-badge stock-low">
                                                        <i class="fas fa-times-circle"></i>
                                                        Out of Stock
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <form method="post" action="${pageContext.request.contextPath}/cart" class="cart-form">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <div class="row g-2">
                                                    <div class="col-4">
                                                        <input type="number" 
                                                               class="form-control quantity-input" 
                                                               name="quantity" 
                                                               value="1" 
                                                               min="1" 
                                                               max="${book.stockQuantity}"
                                                               ${book.stockQuantity == 0 ? 'disabled' : ''}>
                                                    </div>
                                                    <div class="col-8">
                                                        <button type="submit" 
                                                                class="btn btn-add-cart"
                                                                ${book.stockQuantity == 0 ? 'disabled' : ''}>
                                                            <i class="fas fa-cart-plus me-2"></i>
                                                            ${book.stockQuantity == 0 ? 'Out of Stock' : 'Add to Cart'}
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Orders Section -->
                <div class="modern-card">
                    <h3 class="section-title">
                        <i class="fas fa-clipboard-list"></i>
                        Recent Orders
                    </h3>
                    
                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="empty-state">
                                <i class="fas fa-shopping-bag"></i>
                                <h4>No Orders Yet</h4>
                                <p>Start your reading journey by exploring our book collection above!</p>
                                <a href="#books" class="btn btn-primary-modern">
                                    <i class="fas fa-arrow-up me-2"></i>Browse Books
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="orders-table-container">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th><i class="fas fa-hashtag me-2"></i>Order ID</th>
                                                <th><i class="fas fa-calendar me-2"></i>Date</th>
                                                <th><i class="fas fa-money-bill me-2"></i>Total</th>
                                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                                <th><i class="fas fa-list me-2"></i>Items</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${orders}" var="order">
                                                <tr>
                                                    <td>
                                                        <span class="order-id">#${order.id}</span>
                                                    </td>
                                                    <td>
                                                        <div style="font-weight: 600;">
                                                            <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy"/>
                                                        </div>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${order.orderDate}" pattern="HH:mm"/>
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <div style="font-weight: 700; font-size: 1.1rem; color: var(--primary-color);">
                                                            <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/> LKR
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="status-badge status-${order.status.toLowerCase()}">
                                                            ${order.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <ul class="order-items">
                                                            <c:forEach items="${order.orderItems}" var="item">
                                                                <li>
                                                                    <strong>${item.book.title}</strong> 
                                                                    <span class="text-muted">× ${item.quantity}</span>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Help Section -->
                <div class="help-section" id="help-section">
                    <h3 class="section-title">
                        <i class="fas fa-question-circle"></i>
                        Help & Support
                    </h3>
                    <div class="accordion" id="helpAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                    How do I place an order?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    To place an order, browse the featured books section, select a book, choose the desired quantity, and click "Add to Cart". You can then proceed to the cart page to review and confirm your order.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                    How can I track my order?
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    You can track your order in the "Order History" section of the dashboard. The status of each order (e.g., Pending, Shipped, Completed) is displayed in the table.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                    What if I have an issue with my order?
                                </button>
                            </h2>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    If you encounter any issues, please contact our support team at support@pahanaedu.com or call us at +94 123 456 789. We're here to help!
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                                    How do I update my profile information?
                                </button>
                            </h2>
                            <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    Go to the "Profile" section via the sidebar or user dropdown menu. There, you can update your personal details, such as name, email, and address.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar functionality
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.querySelector('.sidebar-overlay');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
        }

        function closeSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.querySelector('.sidebar-overlay');
            sidebar.classList.remove('active');
            overlay.classList.remove('active');
        }

        // Smooth scrolling for anchor links
        function scrollToHelp() {
            const helpSection = document.getElementById('help-section');
            if (helpSection) {
                helpSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
            // Close sidebar on mobile after clicking
            if (window.innerWidth <= 992) {
                closeSidebar();
            }
        }

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

        // Counter animation for stats
        function animateCounters() {
            document.querySelectorAll('.stat-value').forEach(counter => {
                const target = parseFloat(counter.textContent);
                if (!isNaN(target)) {
                    let current = 0;
                    const increment = target / 30;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            counter.textContent = target % 1 === 0 ? target : target.toFixed(1);
                            clearInterval(timer);
                        } else {
                            counter.textContent = current % 1 === 0 ? Math.floor(current) : current.toFixed(1);
                        }
                    }, 50);
                }
            });
        }

        // Trigger counter animation when stats are visible
        const statsObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateCounters();
                    statsObserver.disconnect();
                }
            });
        }, { threshold: 0.5 });

        const statsGrid = document.querySelector('.stats-grid');
        if (statsGrid) {
            statsObserver.observe(statsGrid);
        }

        // Add ripple effect to buttons
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function(e) {
                if (this.disabled) return;
                
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(255, 255, 255, 0.3);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s ease-out;
                    pointer-events: none;
                `;
                
                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);
                
                setTimeout(() => ripple.remove(), 600);
            });
        });

        // Add CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Form validation
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('input', function() {
                const max = parseInt(this.getAttribute('max'));
                const min = parseInt(this.getAttribute('min'));
                let value = parseInt(this.value);
                
                if (value > max) {
                    this.value = max;
                    this.style.borderColor = '#dc2626';
                    setTimeout(() => {
                        this.style.borderColor = '';
                    }, 1000);
                } else if (value < min) {
                    this.value = min;
                }
            });
        });

        // Auto-hide alerts after 5 seconds
        document.querySelectorAll('.alert').forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 300);
            }, 5000);
        });

        // Enhanced mobile navigation
        window.addEventListener('resize', function() {
            if (window.innerWidth > 992) {
                closeSidebar();
            }
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(e) {
            if (window.innerWidth <= 992) {
                const sidebar = document.getElementById('sidebar');
                const toggle = document.querySelector('.sidebar-toggle');
                
                if (!sidebar.contains(e.target) && !toggle.contains(e.target)) {
                    closeSidebar();
                }
            }
        });

        // Loading state for forms
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function() {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn && !submitBtn.disabled) {
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Adding...';
                    submitBtn.disabled = true;
                    
                    // Re-enable after 3 seconds as fallback
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 3000);
                }
            });
        });

        // Initialize tooltips if Bootstrap tooltips are needed
        document.addEventListener('DOMContentLoaded', function() {
            // Add loading animation to cards
            const cards = document.querySelectorAll('.book-card, .stat-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });

            // Add focus management for accessibility
            document.querySelectorAll('.sidebar-nav a, .nav-link, .dropdown-item').forEach(link => {
                link.addEventListener('focus', function() {
                    this.style.outline = '2px solid var(--primary-color)';
                    this.style.outlineOffset = '2px';
                });
                
                link.addEventListener('blur', function() {
                    this.style.outline = '';
                    this.style.outlineOffset = '';
                });
            });
        });
    </script>
</body>
</html>