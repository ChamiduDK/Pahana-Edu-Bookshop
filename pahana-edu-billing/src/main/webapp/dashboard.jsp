<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Pahana Edu Bookshop</title>
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
            background-attachment: fixed;
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="0.5" fill="white" opacity="0.1"/><circle cx="25" cy="25" r="0.3" fill="white" opacity="0.05"/><circle cx="75" cy="75" r="0.4" fill="white" opacity="0.08"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            z-index: -1;
            opacity: 0.3;
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
            position: relative;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 800;
            text-decoration: none;
            color: var(--dark-color);
            position: relative;
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
            position: relative;
            overflow: hidden;
        }

        .brand-icon::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0%, 100% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            50% { transform: translateX(100%) translateY(100%) rotate(45deg); }
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
            background-clip: text;
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

        .user-profile {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 2rem;
            background: rgba(0, 0, 0, 0.02);
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 18px;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: white;
            font-size: 1.2rem;
            position: relative;
            overflow: hidden;
        }

        .user-avatar::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: avatarShine 2s infinite;
        }

        @keyframes avatarShine {
            0%, 100% { transform: translateX(-100%); }
            50% { transform: translateX(100%); }
        }

        .user-details h6 {
            margin: 0;
            font-weight: 700;
            color: var(--dark-color);
            font-size: 0.95rem;
        }

        .user-details small {
            color: #64748b;
            font-weight: 500;
        }

        .logout-btn {
            width: 100%;
            padding: 1rem;
            background: var(--danger-gradient);
            border: none;
            color: white;
            border-radius: var(--border-radius);
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .logout-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .logout-btn:hover::before {
            left: 100%;
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
        }

        /* Welcome Section */
        .welcome-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 0;
            margin-bottom: 2.5rem;
            box-shadow: var(--shadow-medium);
            overflow: hidden;
            position: relative;
        }

        .welcome-hero {
            display: grid;
            grid-template-columns: 1fr 400px;
            align-items: center;
            min-height: 300px;
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 25px;
        }

        .welcome-content {
            padding: 3rem;
            position: relative;
            z-index: 2;
        }

        .welcome-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            line-height: 1.2;
        }

        .welcome-subtitle {
            color: #64748b;
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .welcome-stats {
            display: flex;
            gap: 2rem;
            margin-top: 2rem;
        }

        .welcome-stat {
            text-align: center;
        }

        .welcome-stat-number {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--dark-color);
        }

        .welcome-stat-label {
            font-size: 0.85rem;
            color: #64748b;
            font-weight: 500;
        }

        .welcome-image {
            background: var(--primary-gradient);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .welcome-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300"><defs><pattern id="books" x="0" y="0" width="40" height="40" patternUnits="userSpaceOnUse"><rect width="40" height="40" fill="none"/><rect x="8" y="10" width="6" height="20" fill="white" opacity="0.1"/><rect x="16" y="8" width="6" height="24" fill="white" opacity="0.15"/><rect x="24" y="12" width="6" height="16" fill="white" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23books)"/></svg>');
            opacity: 0.3;
        }

        .dashboard-icon {
            font-size: 8rem;
            color: rgba(255, 255, 255, 0.9);
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            border-top: 4px solid #677be6;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-heavy);
        }

        .stat-card:hover::before {
            transform: scaleX(1);
        }

        .stat-card.customers::before { background: var(--danger-gradient); }
        .stat-card.orders::before { background: var(--success-gradient); }
        .stat-card.books::before { background: var(--warning-gradient); }
        .stat-card.pending::before { background: var(--secondary-gradient); }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }

        .stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            position: relative;
            overflow: hidden;
        }

        .stat-card.customers .stat-icon {
            background: var(--danger-gradient);
            color: white;
        }

        .stat-card.orders .stat-icon {
            background: var(--success-gradient);
            color: white;
        }

        .stat-card.books .stat-icon {
            background: var(--warning-gradient);
            color: white;
        }

        .stat-card.pending .stat-icon {
            background: var(--secondary-gradient);
            color: white;
        }

        .stat-icon::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        }

        

        .stat-title {
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            line-height: 1;
        }

        .stat-change {
            font-size: 0.85rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .stat-change.positive {
            color: #10b981;
        }

        .stat-change.warning {
            color: #f59e0b;
        }

        /* Content Cards */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 2rem;
        }

        .content-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .content-card:hover {
            box-shadow: var(--shadow-medium);
        }

        .card-header {
            padding: 2rem 2rem 1rem 2rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card-title i {
            width: 40px;
            height: 40px;
            background: var(--primary-gradient);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .card-body {
            padding: 2rem;
        }

        /* Quick Actions */
        .quick-actions .action-btn {
            display: flex;
            align-items: center;
            padding: 1.25rem 1.5rem;
            border: 2px solid #c9cdd1;
            border-radius: var(--border-radius);
            text-decoration: none;
            color: #475569;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 1rem;
            font-weight: 600;
            position: relative;
            overflow: hidden;
            background: white;
        }

        .quick-actions .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: 0;
        }

        .quick-actions .action-btn:hover {
            border-color: transparent;
            color: white;
            transform: translateX(8px) scale(1.02);
            box-shadow: var(--shadow-medium);
        }

        .quick-actions .action-btn:hover::before {
            left: 0;
        }

        .quick-actions .action-btn i {
            margin-right: 1rem;
            width: 20px;
            font-size: 1.1rem;
            position: relative;
            z-index: 1;
        }

        .quick-actions .action-btn span {
            position: relative;
            z-index: 1;
        }

        /* Recent Orders */
        .order-item {
            display: flex;
            align-items: center;
            padding: 1.5rem 0;
            border-bottom: 1px solid #393a3b;
            transition: all 0.3s ease;
        }

        .order-item:hover {
            background: rgba(99, 102, 241, 0.02);
            border-radius: 12px;
            padding: 1.5rem 1rem;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-info {
            flex-grow: 1;
        }

        .order-id {
            font-weight: 700;
            color: var(--dark-color);
            font-size: 0.95rem;
        }

        .order-customer {
            color: #64748b;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .order-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: #d97706;
        }

        .status-delivered {
            background: rgba(16, 185, 129, 0.1);
            color: #059669;
        }

        .status-processing {
            background: rgba(6, 182, 212, 0.1);
            color: #0891b2;
        }

        /* Session Timer */
        .session-timer {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border: 2px solid rgba(99, 102, 241, 0.2);
        }

        .session-timer.warning {
            background: rgba(245, 158, 11, 0.1);
            color: #d97706;
            border-color: rgba(245, 158, 11, 0.2);
        }

        .session-timer.danger {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border-color: rgba(239, 68, 68, 0.2);
            animation: pulse 1s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        /* Mobile Responsive */
        @media (max-width: 1400px) {
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 1200px) {
            .content-grid {
                grid-template-columns: 1fr 1fr;
            }
            
            .welcome-hero {
                grid-template-columns: 1fr;
            }
            
            .welcome-image {
                min-height: 250px;
            }
        }

        @media (max-width: 992px) {
            :root {
                --sidebar-width: 100%;
            }

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

            .content-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .stats-container {
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
            }

            .topbar {
                padding: 0 1.5rem;
            }

            .content-area {
                padding: 2rem 1.5rem;
            }
            
            .welcome-title {
                font-size: 2rem;
            }
            
            .welcome-stats {
                flex-direction: column;
                gap: 1rem;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .welcome-hero {
                grid-template-columns: 1fr;
            }

            .welcome-image {
                min-height: 200px;
                order: -1;
            }
            
            .welcome-content {
                padding: 2rem;
            }

            .topbar {
                padding: 0 1rem;
                height: 70px;
            }
            
            .topbar-title h4 {
                font-size: 1.25rem;
            }

            .content-area {
                padding: 1.5rem 1rem;
            }
            
            .welcome-title {
                font-size: 1.75rem;
            }
            
            .stat-value {
                font-size: 2rem;
            }
            
            .card-body {
                padding: 1.5rem;
            }
            
            .stat-card {
                padding: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .topbar {
                flex-direction: column;
                height: auto;
                padding: 1rem;
                gap: 1rem;
                align-items: flex-start;
            }
            
            .topbar-title {
                width: 100%;
            }
            
            .welcome-stats {
                flex-direction: row;
                justify-content: space-between;
                text-align: center;
            }
            
            .welcome-stat {
                flex: 1;
            }
            
            .welcome-stat-number {
                font-size: 1.25rem;
            }
            
            .welcome-stat-label {
                font-size: 0.75rem;
            }
            
            .stat-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .stat-icon {
                align-self: flex-end;
                width: 50px;
                height: 50px;
            }
            
            .action-btn {
                padding: 1rem;
                font-size: 0.9rem;
            }
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

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-gradient);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--secondary-gradient);
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
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
            
            <div class="nav-section">
                <div class="nav-section-title">Analytics</div>
                <div class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-chart-line"></i>
                        Reports
                    </a>
                </div>
                <div class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-chart-bar"></i>
                        Analytics
                    </a>
                </div>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">System</div>
                <div class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-cog"></i>
                        Settings
                    </a>
                </div>
            </div>
        </nav>

        <div class="user-profile">
            <div class="user-info">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="user-details">
                    <h6>${sessionScope.user.username}</h6>
                    <small>${sessionScope.user.role}</small>
                </div>
            </div>
            <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-title">
                <h4>Dashboard Overview</h4>
                <div class="topbar-subtitle">Welcome back, ${sessionScope.user.username}! Here's your business summary.</div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="session-timer" id="sessionTimer">
                    <i class="fas fa-clock"></i>
                    <span>30:00</span>
                </div>
                <button class="btn btn-link d-md-none" onclick="toggleSidebar()">
                    <i class="fas fa-bars fa-lg"></i>
                </button>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show loading" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Welcome Section -->
            <div class="welcome-section loading">
                <div class="welcome-hero">
                    <div class="welcome-content">
                        <% 
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);
                            String greeting = hour < 12 ? "Morning" : hour < 18 ? "Afternoon" : "Evening";
                        %>
                        <h1 class="welcome-title">
                            Good <%= greeting %>, ${sessionScope.user.username}!
                        </h1>
                        <p class="welcome-subtitle">
                            Welcome to your modern dashboard. Monitor your bookshop's performance, 
                            track sales, and manage your inventory all in one place.
                        </p>
                        
                        <div class="welcome-stats">
                            <div class="welcome-stat">
                                <div class="welcome-stat-number">${totalCustomers}</div>
                                <div class="welcome-stat-label">Active Customers</div>
                            </div>
                            <div class="welcome-stat">
                                <div class="welcome-stat-number">${totalOrders}</div>
                                <div class="welcome-stat-label">Total Orders</div>
                            </div>
                            <div class="welcome-stat">
                                <div class="welcome-stat-number">${totalBooks}</div>
                                <div class="welcome-stat-label">Books Available</div>
                            </div>
                        </div>
                    </div>
                    <div class="welcome-image">
                        <i class="fas fa-books dashboard-icon"></i>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-container">
                <div class="stat-card customers loading">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Total Customers</div>
                            <div class="stat-value">${totalCustomers}</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+12% this month</span>
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card orders loading">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Total Orders</div>
                            <div class="stat-value">${totalOrders}</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+8% this month</span>
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card books loading">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Books in Stock</div>
                            <div class="stat-value">${totalBooks}</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+5% this month</span>
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card pending loading">
                    <div class="stat-header">
                        <div>
                            <div class="stat-title">Pending Orders</div>
                            <div class="stat-value">${pendingOrders}</div>
                            <div class="stat-change warning">
                                <i class="fas fa-clock"></i>
                                <span>Need attention</span>
                            </div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-hourglass-half"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content Grid -->
            <div class="content-grid">
                <!-- Quick Actions -->
                <div class="content-card loading">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fas fa-bolt"></i>
                            Quick Actions
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="quick-actions">
                            <a href="${pageContext.request.contextPath}/customers" class="action-btn">
                                <i class="fas fa-user-plus"></i>
                                <span>Add New Customer</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/orders" class="action-btn">
                                <i class="fas fa-cart-plus"></i>
                                <span>Create New Order</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/books" class="action-btn">
                                <i class="fas fa-plus-circle"></i>
                                <span>Add New Book</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/orders?action=admin" class="action-btn">
                                <i class="fas fa-cogs"></i>
                                <span>Manage Orders</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Recent Orders -->
                <div class="content-card loading">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fas fa-clock"></i>
                            Recent Orders
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty recentOrders}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-shopping-bag fa-3x mb-3" style="color: #e2e8f0;"></i>
                                <h6>No recent orders</h6>
                                <small>Orders will appear here when customers place them</small>
                            </div>
                        </c:if>

                        <c:forEach items="${recentOrders}" var="order" varStatus="status">
                            <div class="order-item">
                                <div class="order-info">
                                    <div class="order-id">Order #${order.id}</div>
                                    <div class="order-customer">${order.customer.name}</div>
                                </div>
                                <div class="text-end">
                                    <div class="order-status status-${order.status.toLowerCase()}">${order.status}</div>
                                    <div class="small text-muted mt-1">
                                        LKR <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${not empty recentOrders}">
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/orders?action=admin" class="btn btn-outline-primary">
                                    <i class="fas fa-eye"></i> View All Orders
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Low Stock Alerts -->
                <div class="content-card loading">
                    <div class="card-header">
                        <h5 class="card-title">
                            <i class="fas fa-exclamation-triangle"></i>
                            Stock Alerts
                            <c:if test="${not empty lowStockBooks}">
                                <span class="badge bg-danger ms-2">${lowStockBooks.size()}</span>
                            </c:if>
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty lowStockBooks}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-check-circle fa-3x mb-3" style="color: #10b981;"></i>
                                <h6>All books well stocked!</h6>
                                <small>No low stock alerts at this time</small>
                            </div>
                        </c:if>

                        <c:forEach items="${lowStockBooks}" var="book" varStatus="status">
                            <div class="stock-item">
                                <div class="stock-info">
                                    <div class="stock-title">${book.title}</div>
                                    <div class="stock-author">by ${book.author}</div>
                                </div>
                                <div class="text-end">
                                    <div class="stock-quantity">${book.stockQuantity} left</div>
                                    <div class="small text-muted mt-1">
                                        LKR <fmt:formatNumber value="${book.price}" pattern="#,##0.00"/>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${not empty lowStockBooks}">
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-warning">
                                    <i class="fas fa-warehouse"></i> Manage Inventory
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Mobile Menu Overlay -->
    <div class="mobile-overlay" id="mobileOverlay" onclick="toggleSidebar()"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Session Timer
        let sessionMinutes = 30;
        let sessionSeconds = 0;
        
        function updateSessionTimer() {
            const timerElement = document.getElementById('sessionTimer');
            const timerSpan = timerElement.querySelector('span');
            
            if (!timerSpan) {
                console.log('Timer span not found');
                return;
            }
            
            if (sessionSeconds === 0 && sessionMinutes === 0) {
                timerElement.innerHTML = '<i class="fas fa-exclamation-triangle"></i><span>Expired</span>';
                timerElement.className = 'session-timer danger';
                showSessionExpiredModal();
                return;
            }
            
            if (sessionSeconds === 0) {
                sessionMinutes--;
                sessionSeconds = 59;
            } else {
                sessionSeconds--;
            }
            
            const formattedTime = `${sessionMinutes.toString().padStart(2, '0')}:${sessionSeconds.toString().padStart(2, '0')}`;
            timerSpan.textContent = formattedTime;
            
            // Warning when 5 minutes left
            if (sessionMinutes < 5 && sessionMinutes >= 1) {
                timerElement.className = 'session-timer warning';
            } else if (sessionMinutes < 1) {
                timerElement.className = 'session-timer danger';
            }
        }
        
        function showSessionExpiredModal() {
            const modal = new bootstrap.Modal(document.createElement('div'));
            modal._element.innerHTML = `
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">Session Expired</h5>
                        </div>
                        <div class="modal-body text-center">
                            <i class="fas fa-clock fa-3x text-danger mb-3"></i>
                            <p>Your session has expired for security reasons.</p>
                            <p>Please log in again to continue.</p>
                        </div>
                        <div class="modal-footer border-0 justify-content-center">
                            <button type="button" class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                                Login Again
                            </button>
                        </div>
                    </div>
                </div>
            `;
            document.body.appendChild(modal._element);
            modal.show();
        }
        
        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');
            
            sidebar.classList.toggle('show');
            
            if (overlay) {
                overlay.classList.toggle('show');
            }
            
            // Prevent body scroll when sidebar is open on mobile
            if (sidebar.classList.contains('show')) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = 'auto';
            }
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            // Start session timer
            setInterval(updateSessionTimer, 1000);
            
            // Staggered animations
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Auto-refresh dashboard data every 10 minutes
            setTimeout(() => {
                window.location.reload();
            }, 10 * 60 * 1000);
            
            // Close mobile sidebar when clicking on links
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth <= 992) {
                        toggleSidebar();
                    }
                });
            });
        });
        
        // Handle window resize
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');
            
            if (window.innerWidth > 992) {
                sidebar.classList.remove('show');
                if (overlay) {
                    overlay.classList.remove('show');
                }
                document.body.style.overflow = 'auto';
            }
        });
        
        // Smooth scroll behavior
        document.documentElement.style.scrollBehavior = 'smooth';
        
        // Add loading states for dynamic content
        function showLoadingState(element) {
            element.innerHTML = `
                <div class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            `;
        }
        
        // Enhanced hover effects
        document.querySelectorAll('.stat-card, .content-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
        
        // Add ripple effect to buttons
        document.querySelectorAll('.action-btn, .btn').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.classList.add('ripple');
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });
    </script>
    
    <style>
        /* Mobile Overlay */
        .mobile-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            z-index: 998;
            display: none;
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .mobile-overlay.show {
            display: block;
            opacity: 1;
        }
        
        /* Improved mobile sidebar */
        @media (max-width: 992px) {
            .sidebar {
                box-shadow: var(--shadow-heavy);
            }
        }
        
        /* Ripple Effect */
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: scale(0);
            animation: ripple-animation 0.6s linear;
            pointer-events: none;
        }
        
        @keyframes ripple-animation {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
        
        /* Stock Item Styling */
        .stock-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.05) 0%, rgba(245, 158, 11, 0.05) 100%);
            border: 1px solid rgba(239, 68, 68, 0.1);
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .stock-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-light);
        }
        
        .stock-info {
            flex-grow: 1;
        }
        
        .stock-title {
            font-weight: 600;
            color: var(--dark-color);
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }
        
        .stock-author {
            color: #64748b;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .stock-quantity {
            background: var(--danger-gradient);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
    </style>
</body>
</html>