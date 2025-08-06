<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details #${order.id} - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px 10px 0 0;
        }
        .status-timeline {
            position: relative;
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
            background: #28a745;
        }
        .timeline-item.current::before {
            background: #007bff;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(0, 123, 255, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(0, 123, 255, 0); }
            100% { box-shadow: 0 0 0 0 rgba(0, 123, 255, 0); }
        }
        .invoice-section {
            border: 2px solid #dee2e6;
            border-radius: 10px;
            background: #fff;
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
                <a href="${pageContext.request.contextPath}/books" class="nav-link">
                    <i class="fas fa-book"></i> Books
                </a>
                <a href="${pageContext.request.contextPath}/orders" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Order Header -->
        <div class="card mb-4">
            <div class="card-header order-header">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3><i class="fas fa-receipt"></i> Order #${order.id}</h3>
                        <p class="mb-0">Placed on <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy 'at' HH:mm"/></p>
                    </div>
                    <div class="col-md-6 text-end">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">
                                <h4><span class="badge bg-warning">${order.status}</span></h4>
                            </c:when>
                            <c:when test="${order.status == 'CONFIRMED'}">
                                <h4><span class="badge bg-info">${order.status}</span></h4>
                            </c:when>
                            <c:when test="${order.status == 'SHIPPED'}">
                                <h4><span class="badge bg-primary">${order.status}</span></h4>
                            </c:when>
                            <c:when test="${order.status == 'DELIVERED'}">
                                <h4><span class="badge bg-success">${order.status}</span></h4>
                            </c:when>
                            <c:otherwise>
                                <h4><span class="badge bg-danger">${order.status}</span></h4>
                            </c:otherwise>
                        </c:choose>
                        <p class="mb-0">Total: <strong>LKR <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></strong></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Order Details -->
            <div class="col-md-8">
                <!-- Customer Information -->
                <div class="card mb-4">
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
                                <address>
                                    ${order.customer.address}
                                </address>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="card mb-4 invoice-section">
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
                                            <td>
                                                <strong>${item.book.title}</strong>
                                            </td>
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
                <div class="card">
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
                                <a href="${pageContext.request.contextPath}/orders?action=admin" class="btn btn-outline-secondary me-2">
                                    <i class="fas fa-arrow-left"></i> Back to Orders
                                </a>
                                <button class="btn btn-primary" onclick="window.print()">
                                    <i class="fas fa-print"></i> Print Order
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Status Timeline -->
            <div class="col-md-4">
                <div class="card">
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
                <div class="card mt-3">
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
                               class="btn btn-outline-info btn-sm">
                                <i class="fas fa-history"></i> View Customer Orders
                            </a>
                            <a href="${pageContext.request.contextPath}/customers" 
                               class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-user-edit"></i> Edit Customer
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Print styles
        const printStyles = `
            <style type="text/css" media="print">
                @page { margin: 0.5in; }
                body { font-size: 12pt; }
                .navbar, .card-header, .btn { display: none !important; }
                .timeline-item::before { background: #000 !important; }
                .badge { border: 1px solid #000; background: white !important; color: #000 !important; }
            </style>
        `;
        
        document.head.insertAdjacentHTML('beforeend', printStyles);
    </script>
</body>
</html>