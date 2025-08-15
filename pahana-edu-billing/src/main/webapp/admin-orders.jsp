<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Order Management - Pahana Edu Bookshop</title>
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

        /* Filter Controls */
        .filter-controls {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
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

        /* Status Badge */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
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

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
            color: white;
        }

        /* Dropdown */
        .dropdown-menu {
            border-radius: 12px;
            box-shadow: var(--shadow-light);
            border: none;
        }

        .dropdown-item {
            padding: 0.5rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .dropdown-item:hover {
            background: var(--primary-gradient);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
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

            .table-responsive {
                font-size: 0.9rem;
            }

            .order-actions .btn-group-vertical {
                display: flex;
                flex-direction: row;
                gap: 0.5rem;
            }

            .order-actions .btn {
                font-size: 0.75rem;
                padding: 0.4rem 0.8rem;
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
                <h4>Admin Order Management</h4>
                <div class="topbar-subtitle">Manage all orders and update statuses</div>
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
                    <i class="fas fa-exclamation-circle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show loading" role="alert">
                    <i class="fas fa-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Filter Controls -->
            <div class="card mb-4 filter-controls loading">
                <div class="card-header">
                    <h5><i class="fas fa-filter"></i> Filter Orders</h5>
                </div>
                <div class="card-body">
                    <div class="row align-items-end g-3">
                        <div class="col-md-3">
                            <label class="form-label">Filter by Status</label>
                            <select class="form-select" id="statusFilter" onchange="filterOrders()">
                                <option value="">All Orders</option>
                                <option value="PENDING">Pending</option>
                                <option value="CONFIRMED">Confirmed</option>
                                <option value="SHIPPED">Shipped</option>
                                <option value="DELIVERED">Delivered</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Search Customer</label>
                            <input type="text" class="form-control" id="customerFilter" placeholder="Customer name or account..." onkeyup="filterOrders()">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Date Range</label>
                            <input type="date" class="form-control" id="dateFilter" onchange="filterOrders()">
                        </div>
                        <div class="col-md-3">
                            <button class="action-btn btn-secondary w-100" onclick="clearFilters()">
                                <i class="fas fa-refresh"></i> Clear Filters
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Orders Table -->
            <div class="card loading">
                <div class="card-header">
                    <h5><i class="fas fa-list"></i> All Orders (<span id="orderCount">${orders.size()}</span>)</h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty orders}">
                        <div class="empty-state">
                            <i class="fas fa-shopping-cart"></i>
                            <h5>No Orders Found</h5>
                            <p>Orders will appear here once customers place them.</p>
                            <a href="${pageContext.request.contextPath}/orders" class="action-btn btn-primary">
                                <i class="fas fa-arrow-left"></i> Back to Orders
                            </a>
                        </div>
                    </c:if>

                    <c:if test="${not empty orders}">
                        <div class="table-responsive">
                            <table class="table table-hover" id="ordersTable">
                                <thead>
                                    <tr>
                                        <th>Order #</th>
                                        <th>Customer</th>
                                        <th>Account #</th>
                                        <th>Items</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Order Date</th>
                                        <th>Placed By</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr class="order-row" 
                                            data-status="${order.status}" 
                                            data-customer="${order.customer.name} ${order.customer.accountNumber}"
                                            data-date="<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/>">
                                            <td><strong>#${order.id}</strong></td>
                                            <td>
                                                <div class="fw-bold">${order.customer.name}</div>
                                                <small class="text-muted">${order.customer.telephone}</small>
                                            </td>
                                            <td><span class="badge bg-primary">${order.customer.accountNumber}</span></td>
                                            <td>
                                                <span class="badge bg-info">${order.orderItems.size()} items</span>
                                                <div class="small text-muted">
                                                    <c:forEach items="${order.orderItems}" var="item" varStatus="status">
                                                        ${item.book.title} (${item.quantity})<c:if test="${!status.last}">, </c:if>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td>LKR <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span class="status-badge bg-warning">${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CONFIRMED'}">
                                                        <span class="status-badge bg-info">${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'SHIPPED'}">
                                                        <span class="status-badge bg-primary">${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <span class="status-badge bg-success">${order.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge bg-danger">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy"/>
                                                <div class="small text-muted">
                                                    <fmt:formatDate value="${order.orderDate}" pattern="HH:mm"/>
                                                </div>
                                            </td>
                                            <td>
                                                <small class="text-muted">
                                                    <i class="fas fa-user"></i> ${order.placedByUser.username}
                                                </small>
                                            </td>
                                            <td class="order-actions">
                                                <div class="d-flex flex-column gap-2">
                                                    <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.id}" 
                                                       class="action-btn btn-primary">
                                                        <i class="fas fa-eye"></i> View
                                                    </a>
                                                    <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                                                        <div class="btn-group">
                                                            <button class="action-btn btn-success dropdown-toggle" 
                                                                    data-bs-toggle="dropdown">
                                                                <i class="fas fa-edit"></i> Status
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <c:if test="${order.status != 'CONFIRMED'}">
                                                                    <li><a class="dropdown-item" href="#" 
                                                                           onclick="updateOrderStatus(${order.id}, 'CONFIRMED')">
                                                                        <i class="fas fa-check text-info"></i> Confirm
                                                                    </a></li>
                                                                </c:if>
                                                                <c:if test="${order.status == 'CONFIRMED'}">
                                                                    <li><a class="dropdown-item" href="#" 
                                                                           onclick="updateOrderStatus(${order.id}, 'SHIPPED')">
                                                                        <i class="fas fa-shipping-fast text-primary"></i> Ship
                                                                    </a></li>
                                                                </c:if>
                                                                <c:if test="${order.status == 'SHIPPED'}">
                                                                    <li><a class="dropdown-item" href="#" 
                                                                           onclick="updateOrderStatus(${order.id}, 'DELIVERED')">
                                                                        <i class="fas fa-check-double text-success"></i> Deliver
                                                                    </a></li>
                                                                </c:if>
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li><a class="dropdown-item text-danger" href="#" 
                                                                       onclick="updateOrderStatus(${order.id}, 'CANCELLED')">
                                                                    <i class="fas fa-times text-danger"></i> Cancel
                                                                </a></li>
                                                            </ul>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Status Update Form (Hidden) -->
    <form id="statusUpdateForm" method="post" action="${pageContext.request.contextPath}/orders" style="display: none;">
        <input type="hidden" name="action" value="updateStatus">
        <input type="hidden" name="orderId" id="statusOrderId">
        <input type="hidden" name="status" id="statusValue">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
            document.body.style.overflow = sidebar.classList.contains('show') ? 'hidden' : 'auto';
        }

        function updateOrderStatus(orderId, newStatus) {
            const statusNames = {
                'PENDING': 'Pending',
                'CONFIRMED': 'Confirmed',
                'SHIPPED': 'Shipped',
                'DELIVERED': 'Delivered',
                'CANCELLED': 'Cancelled'
            };
            
            let message = `Are you sure you want to change the order status to "${statusNames[newStatus]}"?`;
            if (newStatus === 'DELIVERED') {
                message += '\n\nThis will automatically send a bill email to the customer.';
            }
            
            if (confirm(message)) {
                document.getElementById('statusOrderId').value = orderId;
                document.getElementById('statusValue').value = newStatus;
                document.getElementById('statusUpdateForm').submit();
            }
        }

        function filterOrders() {
            const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
            const customerFilter = document.getElementById('customerFilter').value.toLowerCase();
            const dateFilter = document.getElementById('dateFilter').value;
            
            const rows = document.querySelectorAll('.order-row');
            let visibleCount = 0;
            
            rows.forEach(row => {
                const status = row.dataset.status.toLowerCase();
                const customer = row.dataset.customer.toLowerCase();
                const date = row.dataset.date;
                
                let showRow = true;
                
                if (statusFilter && status !== statusFilter) {
                    showRow = false;
                }
                
                if (customerFilter && !customer.includes(customerFilter)) {
                    showRow = false;
                }
                
                if (dateFilter && date !== dateFilter) {
                    showRow = false;
                }
                
                if (showRow) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('orderCount').textContent = visibleCount;
        }

        function clearFilters() {
            document.getElementById('statusFilter').value = '';
            document.getElementById('customerFilter').value = '';
            document.getElementById('dateFilter').value = '';
            filterOrders();
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

            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
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