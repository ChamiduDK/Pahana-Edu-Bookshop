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

        .dashboard-layout {
            display: flex;
            min-height: 100vh;
        }

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

        .main-content {
            margin-left: 280px;
            width: calc(100% - 280px);
            min-height: 100vh;
        }

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

        .alert {
            border: none;
            border-radius: var(--border-radius-md);
            padding: 1.25rem 1.5rem;
            margin-bottom: 1rem;
            font-weight: 500;
            opacity: 1;
            transform: translateY(0);
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

        .alert-warning {
            background: linear-gradient(135deg, #fef3c7 0%, #fef9c3 100%);
            color: #d97706;
            border-left: 4px solid #d97706;
        }

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

        .form-control, .form-select {
            border: 2px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            padding: 0.75rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            outline: none;
        }

        .form-control.is-invalid {
            border-color: #dc2626;
            background-image: none;
        }

        .form-control.is-valid {
            border-color: #16a34a;
            background-image: none;
        }

        .invalid-feedback, .valid-feedback {
            font-size: 0.9rem;
            font-weight: 500;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
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

        .btn-secondary-modern {
            background: var(--card-gradient);
            border: 2px solid var(--border-color);
            border-radius: var(--border-radius-sm);
            padding: 0.875rem 2rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: var(--shadow-sm);
            color: var(--text-primary);
            text-decoration: none;
        }

        .btn-secondary-modern:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            border-color: var(--primary-color);
        }

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
            font-size: 1.25rem;
            font-weight: 700;
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

        .help-section {
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            margin-bottom: 2rem;
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

            .sidebar-overlay.active {
                display: block;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
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

        .loading-shimmer {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        .interactive-element {
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .interactive-element:hover {
            transform: translateY(-1px);
        }

        @keyframes ripple {
            to {
                transform: scale(2);
                opacity: 0;
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
                <li><a href="${pageContext.request.contextPath}/customer-dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a></li>
                <li><a href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a></li>
                <li><a href="${pageContext.request.contextPath}/customer-orders">
                    <i class="fas fa-history"></i> My Orders
                </a></li>
                <li><a href="${pageContext.request.contextPath}/customer-profile" class="active">
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
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
                            <h1 class="page-title">Your Profile</h1>
                            <p class="page-subtitle">Manage your personal information and preferences</p>
                        </div>
                        <div class="col-lg-4 text-end">
                            <i class="fas fa-user-circle" style="font-size: 6rem; opacity: 0.2;"></i>
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
                        <strong>Error:</strong> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-3"></i>
                        <strong>Success:</strong> ${success}
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.customer}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-circle me-3"></i>
                        <strong>Warning:</strong> No customer data found in session. Please <a href="${pageContext.request.contextPath}/login.jsp" class="text-decoration-underline">login</a> first.
                    </div>
                </c:if>

                <!-- Profile Summary -->
                <c:if test="${not empty sessionScope.customer}">
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="stat-value">${sessionScope.customer.name}</div>
                            <div class="stat-label">Full Name</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="stat-value">${sessionScope.customer.email}</div>
                            <div class="stat-label">Email Address</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-phone"></i>
                            </div>
                            <div class="stat-value">${sessionScope.customer.telephone}</div>
                            <div class="stat-label">Telephone</div>
                        </div>
                    </div>

                    <!-- Profile Form -->
                    <div class="modern-card">
                        <h3 class="section-title">
                            <i class="fas fa-user-edit"></i>
                            Update Profile
                        </h3>
                        <form method="post" action="${pageContext.request.contextPath}/customer-profile" id="profileForm" novalidate>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Name *</label>
                                    <input type="text" class="form-control" id="name" name="name" value="${sessionScope.customer.name}" required aria-describedby="nameFeedback">
                                    <div id="nameFeedback" class="invalid-feedback">
                                        Please enter a valid name.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email *</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.customer.email}" required aria-describedby="emailFeedback">
                                    <div id="emailFeedback" class="invalid-feedback">
                                        Please enter a valid email address.
                                    </div>
                                </div>
                                <div class="col-12">
                                    <label for="address" class="form-label">Address *</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required aria-describedby="addressFeedback">${sessionScope.customer.address}</textarea>
                                    <div id="addressFeedback" class="invalid-feedback">
                                        Please enter a valid address.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="telephone" class="form-label">Telephone *</label>
                                    <input type="tel" class="form-control" id="telephone" name="telephone" value="${sessionScope.customer.telephone}" required pattern="^\+?[\d\s-]{10,}$" aria-describedby="telephoneFeedback">
                                    <div id="telephoneFeedback" class="invalid-feedback">
                                        Please enter a valid phone number.
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4 d-flex gap-3">
                                <button type="submit" class="btn btn-primary-modern">
                                    <i class="fas fa-save me-2"></i>Update Profile
                                </button>
                                <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn btn-secondary-modern">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                                </a>
                            </div>
                        </form>
                    </div>
                </c:if>

                <!-- Help Section -->
                <div class="help-section" id="help-section">
                    <h3 class="section-title">
                        <i class="fas fa-question-circle"></i>
                        Help & Support
                    </h3>
                    <div class="accordion" id="helpAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1" aria-expanded="true" aria-controls="faq1">
                                    How do I update my profile information?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    Fill out the form above with your updated details, such as name, email, address, and telephone number, then click "Update Profile" to save your changes.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                                    Why can't I see my profile details?
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    If you can't see your profile details, you may not be logged in. Please log in to your account or contact support at support@pahanaedu.com.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                                    How do I contact support?
                                </button>
                            </h2>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                <div class="accordion-body">
                                    You can reach our support team at support@pahanaedu.com or call us at +94 123 456 789. We're here to assist you!
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

        function scrollToHelp() {
            const helpSection = document.getElementById('help-section');
            if (helpSection) {
                helpSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
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

        // Form validation
        document.getElementById('profileForm')?.addEventListener('submit', function(e) {
            const form = this;
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                form.classList.add('was-validated');
            } else {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn && !submitBtn.disabled) {
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Updating...';
                    submitBtn.disabled = true;
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 3000);
                }
            }
        });

        // Real-time input validation
        document.querySelectorAll('#profileForm .form-control').forEach(input => {
            input.addEventListener('input', function() {
                if (this.checkValidity()) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-valid');
                    this.classList.add('is-invalid');
                }
            });
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

        // Initialize animations and accessibility
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.modern-card, .stat-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });

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