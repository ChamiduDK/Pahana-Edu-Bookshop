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
            background: #f1f5f9;
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

        /* Order Header Card */
        .order-header {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .order-header .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 700;
        }

        /* Status Timeline */
        .status-timeline {
            position: relative;
            padding: 1rem 0;
        }

        .status-timeline::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 0;
            height: 100%;
            width: 2px;
            background: #e9ecef;
        }

        .timeline-item {
            position: relative;
            padding-left: 45px;
            padding-bottom: 20px;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: 9px;
            top: 5px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #6c757d;
        }

        .timeline-item.active::before {
            background: var(--success-color);
        }

        .timeline-item.current::before {
            background: var(--primary-color);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(102, 126, 234, 0); }
            100% { box-shadow: 0 0 0 0 rgba(102, 126, 234, 0); }
        }

        /* Cards */
        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
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
        }

        .card-body {
            padding: 2rem;
        }

        /* Action Buttons */
        .action-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            color: white;
        }

        .btn-info {
            background: var(--success-gradient);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
            color: white;
        }

        /* Table */
        .table {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        .table th, .table td {
            padding: 1rem;
            vertical-align: middle;
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

        /* Print Styles */
        @media print {
            @page { margin: 0.5in; }
            body { font-size: 12pt; }
            .sidebar, .topbar, .action-btn { display: none !important; }
            .main-content { margin-left: 0 !important; }
            .timeline-item::before { background: #000 !important; }
            .status-badge { border: 1px solid #000; background: white !important; color: #000 !important; }
            .card { box-shadow: none; }
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
                    <div class="col-md-6">
                        <h3><i class="fas fa-receipt"></i> Order #${order.id}</h3>
                        <p class="mb-0">Placed on <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy 'at' HH:mm"/></p>
                    </div>
                    <div class="col-md-6 text-end">
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
                        <p class="mb-0">Total: <strong>LKR <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></strong></p>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Order Details -->
                <div class="col-md-8">
                    <!-- Customer Information -->
                    <div class="card mb-4 loading">
                        <div class="card-header">
                            <h5><i class="fas fa-user"></i> Customer Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Customer Details</h6>
                                    <p class="mb-1"><strong>Name:</strong> ${order.customer.name}</p>
                                    <p class="mb-1"><strong>Account #:</strong> 
                                        <span class="badge bg-primary">${order.customer.accountNumber}</span>
                                    </p>
                                    <p class="mb-1"><strong>Phone:</strong> ${order.customer.telephone}</p>
                                    <c:if test="${not empty order.customer.email}">
                                        <p class="mb-1"><strong>Email:</strong> ${order.customer.email}</p>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <h6>Shipping Address</h6>
                                    <address>${order.customer.address}</address>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="card mb-4 loading">
                        <div class="card-header">
                            <h5><i class="fas fa-list"></i> Order Items</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-striped mb-0">
                                    <thead>
                                        <tr>
                                            <th>Book</th>
                                            <th>Author</th>
                                            <th>Category</th>
                                            <th class="text-center">Quantity</th>
                                            <th class="text-end">Unit Price</th>
                                            <th class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${order.orderItems}" var="item">
                                            <tr>
                                                <td><strong>${item.book.title}</strong></td>
                                                <td>${item.book.author}</td>
                                                <td>${item.book.category}</td>
                                                <td class="text-center">
                                                    <span class="badge bg-secondary">${item.quantity}</span>
                                                </td>
                                                <td class="text-end">
                                                    LKR <fmt:formatNumber value="${item.unitPrice}" pattern="0.00"/>
                                                </td>
                                                <td class="text-end">
                                                    <strong>LKR <fmt:formatNumber value="${item.subtotal}" pattern="0.00"/></strong>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="5" class="text-end">Total Amount:</th>
                                            <th class="text-end">
                                                <h5 class="mb-0">LKR <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></h5>
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
                            <h5><i class="fas fa-cogs"></i> Order Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Processed by:</strong> ${order.placedByUser.username}</p>
                                    <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                </div>
                                <div class="col-md-6 text-end">
                                    <a href="${pageContext.request.contextPath}/orders?action=admin" class="action-btn btn-secondary me-2">
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
                <div class="col-md-4">
                    <!-- Order Status Timeline -->
                    <div class="card mb-4 loading">
                        <div class="card-header">
                            <h5><i class="fas fa-truck"></i> Order Timeline</h5>
                        </div>
                        <div class="card-body">
                            <div class="status-timeline">
                                <div class="timeline-item active">
                                    <div class="timeline-content">
                                        <h6 class="mb-1">Order Placed</h6>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy HH:mm"/>
                                        </small>
                                        <p class="small mb-0">Order has been successfully placed</p>
                                    </div>
                                </div>
                                <div class="timeline-item ${order.status == 'CONFIRMED' or order.status == 'SHIPPED' or order.status == 'DELIVERED' ? 'active' : ''} ${order.status == 'CONFIRMED' ? 'current' : ''}">
                                    <div class="timeline-content">
                                        <h6 class="mb-1">Order Confirmed</h6>
                                        <c:if test="${order.status == 'CONFIRMED' or order.status == 'SHIPPED' or order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed</small>
                                        </c:if>
                                        <c:if test="${order.status == 'PENDING'}">
                                            <small class="text-muted">Waiting for confirmation</small>
                                        </c:if>
                                        <p class="small mb-0">Order confirmed and being prepared</p>
                                    </div>
                                </div>
                                <div class="timeline-item ${order.status == 'SHIPPED' or order.status == 'DELIVERED' ? 'active' : ''} ${order.status == 'SHIPPED' ? 'current' : ''}">
                                    <div class="timeline-content">
                                        <h6 class="mb-1">Order Shipped</h6>
                                        <c:if test="${order.status == 'SHIPPED' or order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed</small>
                                        </c:if>
                                        <c:if test="${order.status != 'SHIPPED' and order.status != 'DELIVERED'}">
                                            <small class="text-muted">Waiting to ship</small>
                                        </c:if>
                                        <p class="small mb-0">Order is on its way to you</p>
                                    </div>
                                </div>
                                <div class="timeline-item ${order.status == 'DELIVERED' ? 'active current' : ''}">
                                    <div class="timeline-content">
                                        <h6 class="mb-1">Order Delivered</h6>
                                        <c:if test="${order.status == 'DELIVERED'}">
                                            <small class="text-success">✓ Completed</small>
                                            <p class="small mb-0">Order delivered successfully!</p>
                                            <p class="small text-info">📧 Bill email sent to customer</p>
                                        </c:if>
                                        <c:if test="${order.status != 'DELIVERED'}">
                                            <small class="text-muted">Pending delivery</small>
                                            <p class="small mb-0">Order will be delivered soon</p>
                                        </c:if>
                                    </div>
                                </div>
                                <c:if test="${order.status == 'CANCELLED'}">
                                    <div class="timeline-item active">
                                        <div class="timeline-content">
                                            <h6 class="mb-1 text-danger">Order Cancelled</h6>
                                            <small class="text-danger">❌ Cancelled</small>
                                            <p class="small mb-0">This order has been cancelled</p>
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
                            <div class="row text-center">
                                <div class="col-6">
                                    <div class="border-end">
                                        <h4 class="text-primary">${customerTotalUnits}</h4>
                                        <small class="text-muted">Total Units Purchased</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <h4 class="text-success">${order.orderItems.size()}</h4>
                                    <small class="text-muted">Items in This Order</small>
                                </div>
                            </div>
                            <hr>
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/orders?action=customer&customerId=${order.customer.id}" 
                                   class="action-btn btn-info">
                                    <i class="fas fa-history"></i> View Customer Orders
                                </a>
                                <a href="${pageContext.request.contextPath}/customers" 
                                   class="action-btn btn-secondary">
                                    <i class="fas fa-user-edit"></i> Edit Customer
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
            const loadingElements = document.querySelectorAll('.loading');
            loadingElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
            });

            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth <= 992) {
                        toggleSidebar();
                    }
                });
            });
        });

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