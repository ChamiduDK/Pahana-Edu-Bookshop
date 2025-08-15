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

        .btn-info {
            background: var(--success-gradient);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
            color: white;
        }

        /* Status Badge */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        /* Book Selection */
        .book-selection {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            padding: 1rem;
        }

        .book-item:hover {
            background: rgba(0, 0, 0, 0.02);
            border-radius: 8px;
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

        /* Modal */
        .modal-content {
            border-radius: var(--border-radius);
        }

        .modal-header {
            border-bottom: none;
            padding: 1.5rem;
        }

        .modal-footer {
            border-top: none;
            padding: 1.5rem;
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

            <!-- Header with Actions -->
            <div class="d-flex justify-content-between align-items-center mb-4 loading">
                <div>
                    <h5 class="mb-1" style="color: var(--dark-color); font-weight: 700;">Recent Orders</h5>
                    <p class="text-muted mb-0">View and manage your order history</p>
                </div>
                <div class="d-flex gap-3">
                    <button class="action-btn btn-primary" data-bs-toggle="modal" data-bs-target="#createOrderModal">
                        <i class="fas fa-plus"></i> Create New Order
                    </button>
                    <a href="${pageContext.request.contextPath}/orders?action=admin" class="action-btn btn-info">
                        <i class="fas fa-cog"></i> Admin View
                    </a>
                </div>
            </div>

            <!-- Recent Orders -->
            <div class="card mb-4 loading">
                <div class="card-header">
                    <h5><i class="fas fa-clock"></i> Recent Orders</h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty orders}">
                        <div class="empty-state loading">
                            <i class="fas fa-shopping-cart"></i>
                            <h5>No Orders Found</h5>
                            <p>Create your first order to get started.</p>
                            <button class="action-btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#createOrderModal">
                                <i class="fas fa-plus"></i> Create First Order
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${not empty orders}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Account #</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Order Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order" varStatus="status">
                                        <c:if test="${status.index < 10}">
                                            <tr>
                                                <td><strong>#${order.id}</strong></td>
                                                <td>${order.customer.name}</td>
                                                <td><span class="badge bg-primary">${order.customer.accountNumber}</span></td>
                                                <td>LKR <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></td>
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
                                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.id}" 
                                                       class="action-btn btn-primary">
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
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/orders?action=admin" class="action-btn btn-info">
                                    View All Orders (${orders.size()} total)
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
                    <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Create New Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/orders" id="createOrderForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        <!-- Customer Selection -->
                        <div class="mb-4">
                            <label for="customerId" class="form-label">Select Customer *</label>
                            <select class="form-select" name="customerId" id="customerId" required>
                                <option value="">Choose a customer...</option>
                                <c:forEach items="${customers}" var="customer">
                                    <option value="${customer.id}">
                                        ${customer.accountNumber} - ${customer.name} (${customer.telephone})
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text">
                                <a href="${pageContext.request.contextPath}/customers" target="_blank" class="text-decoration-none">
                                    <i class="fas fa-plus"></i> Add new customer
                                </a>
                            </div>
                        </div>
                        <!-- Book Selection -->
                        <div class="mb-4">
                            <label class="form-label">Select Books *</label>
                            <div class="book-selection">
                                <c:forEach items="${books}" var="book">
                                    <div class="row mb-3 align-items-center book-item">
                                        <div class="col-md-6">
                                            <div class="form-check">
                                                <input class="form-check-input book-checkbox" type="checkbox" 
                                                       name="bookId" value="${book.id}" id="book_${book.id}"
                                                       onchange="toggleQuantityInput(${book.id})">
                                                <label class="form-check-label" for="book_${book.id}">
                                                    <strong>${book.title}</strong><br>
                                                    <small class="text-muted">by ${book.author}</small><br>
                                                    <small class="text-success">Stock: ${book.stockQuantity}</small>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="text-center">
                                                <strong>LKR <fmt:formatNumber value="${book.price}" pattern="0.00"/></strong>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <input type="number" class="form-control quantity-input" 
                                                   name="quantity_${book.id}" min="1" max="${book.stockQuantity}" 
                                                   placeholder="Qty" disabled 
                                                   onchange="updateOrderSummary()">
                                        </div>
                                    </div>
                                    <hr>
                                </c:forEach>
                            </div>
                        </div>
                        <!-- Order Summary -->
                        <div class="card bg-light">
                            <div class="card-body">
                                <h6><i class="fas fa-calculator"></i> Order Summary</h6>
                                <div id="orderSummary">
                                    <p class="text-muted">Select books to see order summary</p>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <strong>Total Amount:</strong>
                                    <strong id="totalAmount">LKR 0.00</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="action-btn btn-primary" id="createOrderBtn" disabled>
                            <i class="fas fa-shopping-cart"></i> Create Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('show');
            document.body.style.overflow = sidebar.classList.contains('show') ? 'hidden' : 'auto';
        }

        function toggleQuantityInput(bookId) {
            const checkbox = document.getElementById('book_' + bookId);
            const quantityInput = checkbox.closest('.book-item').querySelector('.quantity-input');
            
            if (checkbox.checked) {
                quantityInput.disabled = false;
                quantityInput.value = 1;
            } else {
                quantityInput.disabled = true;
                quantityInput.value = '';
            }
            
            updateOrderSummary();
        }

        function updateOrderSummary() {
            const checkedBoxes = document.querySelectorAll('.book-checkbox:checked');
            const summaryDiv = document.getElementById('orderSummary');
            const totalAmountSpan = document.getElementById('totalAmount');
            const createOrderBtn = document.getElementById('createOrderBtn');
            
            let summaryHtml = '';
            let totalAmount = 0;
            
            if (checkedBoxes.length === 0) {
                summaryHtml = '<p class="text-muted">Select books to see order summary</p>';
                createOrderBtn.disabled = true;
            } else {
                summaryHtml = '<div class="small">';
                
                checkedBoxes.forEach(checkbox => {
                    const bookId = checkbox.value;
                    const quantityInput = checkbox.closest('.book-item').querySelector('.quantity-input');
                    const quantity = parseInt(quantityInput.value) || 0;
                    
                    if (quantity > 0) {
                        const price = bookPrices[bookId];
                        const subtotal = price * quantity;
                        totalAmount += subtotal;
                        
                        summaryHtml += `<div class="d-flex justify-content-between">
                            <span>${bookTitles[bookId]} x ${quantity}</span>
                            <span>LKR ${subtotal.toFixed(2)}</span>
                        </div>`;
                    }
                });
                
                summaryHtml += '</div>';
                createOrderBtn.disabled = totalAmount === 0;
            }
            
            summaryDiv.innerHTML = summaryHtml;
            totalAmountSpan.textContent = 'LKR ' + totalAmount.toFixed(2);
        }

        document.getElementById('createOrderModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('createOrderForm').reset();
            document.querySelectorAll('.quantity-input').forEach(input => {
                input.disabled = true;
                input.value = '';
            });
            updateOrderSummary();
        });

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
                const quantityInput = checkbox.closest('.book-item').querySelector('.quantity-input');
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
        });

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