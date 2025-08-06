<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Order Management - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .status-badge {
            font-size: 0.8em;
        }
        .order-actions {
            min-width: 150px;
        }
        .filter-controls {
            background: #f8f9fa;
            border-radius: 10px;
        }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-book"></i> Pahana Edu Bookshop
            </a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                    <i class="fas fa-dashboard"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/customers" class="nav-link">
                    <i class="fas fa-users"></i> Customers
                </a>
                <a href="${pageContext.request.contextPath}/orders" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-cogs"></i> Admin Order Management</h2>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Back to Orders
            </a>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Filter Controls -->
        <div class="card mb-4 filter-controls">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <label class="form-label">Filter by Status:</label>
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
                        <label class="form-label">Search Customer:</label>
                        <input type="text" class="form-control" id="customerFilter" placeholder="Customer name or account..." onkeyup="filterOrders()">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Date Range:</label>
                        <input type="date" class="form-control" id="dateFilter" onchange="filterOrders()">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-outline-secondary w-100" onclick="clearFilters()">
                            <i class="fas fa-refresh"></i> Clear Filters
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders Table -->
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-list"></i> All Orders (<span id="orderCount">${orders.size()}</span>)</h5>
            </div>
            <div class="card-body">
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
                                    <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="badge bg-warning status-badge">${order.status}</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <span class="badge bg-info status-badge">${order.status}</span>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">
                                                <span class="badge bg-primary status-badge">${order.status}</span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <span class="badge bg-success status-badge">${order.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger status-badge">${order.status}</span>
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
                                        <div class="btn-group-vertical gap-1">
                                            <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.id}" 
                                               class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            
                                            <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                                                <div class="btn-group">
                                                    <button class="btn btn-sm btn-outline-success dropdown-toggle" 
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

                <c:if test="${empty orders}">
                    <div class="text-center py-5">
                        <i class="fas fa-shopping-cart fa-5x text-muted mb-3"></i>
                        <h5 class="text-muted">No orders found</h5>
                        <p class="text-muted">Orders will appear here once customers place them</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Status Update Form (Hidden) -->
    <form id="statusUpdateForm" method="post" action="${pageContext.request.contextPath}/orders" style="display: none;">
        <input type="hidden" name="action" value="updateStatus">
        <input type="hidden" name="orderId" id="statusOrderId">
        <input type="hidden" name="status" id="statusValue">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateOrderStatus(orderId, newStatus) {
            const statusNames = {
                'PENDING': 'Pending',
                'CONFIRMED': 'Confirmed',
                'SHIPPED': 'Shipped',
                'DELIVERED': 'Delivered',
                'CANCELLED': 'Cancelled'
            };
            
            const message = `Are you sure you want to change the order status to "${statusNames[newStatus]}"?`;
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
                
                // Status filter
                if (statusFilter && status !== statusFilter) {
                    showRow = false;
                }
                
                // Customer filter
                if (customerFilter && !customer.includes(customerFilter)) {
                    showRow = false;
                }
                
                // Date filter
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

        // Initialize tooltips
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    </script>
</body>
</html>