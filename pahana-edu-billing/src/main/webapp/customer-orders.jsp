<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders for ${customer.name} - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .customer-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
        }
        .order-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .order-card:hover {
            transform: translateY(-5px);
        }
        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
        }
        .summary-card {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
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

    <div class="container mt-4">
        <!-- Customer Header -->
        <div class="card customer-header mb-4">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h3><i class="fas fa-user-circle"></i> ${customer.name}</h3>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="mb-1"><i class="fas fa-id-card"></i> Account: <strong>${customer.accountNumber}</strong></p>
                                <p class="mb-1"><i class="fas fa-phone"></i> ${customer.telephone}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="mb-1"><i class="fas fa-map-marker-alt"></i> ${customer.address}</p>
                                <c:if test="${not empty customer.email}">
                                    <p class="mb-1"><i class="fas fa-envelope"></i> ${customer.email}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <div class="summary-card p-3 rounded">
                            <h4><i class="fas fa-cubes"></i> ${customer.unitsConsumed}</h4>
                            <small>Total Units Consumed</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4><i class="fas fa-history"></i> Order History (${orders.size()} orders)</h4>
            <div>
                <a href="${pageContext.request.contextPath}/customers" class="btn btn-outline-secondary me-2">
                    <i class="fas fa-arrow-left"></i> Back to Customers
                </a>
                <button class="btn btn-primary" onclick="window.print()">
                    <i class="fas fa-print"></i> Print History
                </button>
            </div>
        </div>

        <!-- Order Statistics -->
        <c:if test="${not empty orders}">
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-shopping-cart fa-2x text-primary mb-2"></i>
                            <h4>${orders.size()}</h4>
                            <small class="text-muted">Total Orders</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-dollar-sign fa-2x text-success mb-2"></i>
                            <h4>
                                <c:set var="totalAmount" value="0"/>
                                <c:forEach items="${orders}" var="order">
                                    <c:set var="totalAmount" value="${totalAmount + order.totalAmount}"/>
                                </c:forEach>
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="$"/>
                            </h4>
                            <small class="text-muted">Total Spent</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
                            <h4>
                                <c:set var="deliveredCount" value="0"/>
                                <c:forEach items="${orders}" var="order">
                                    <c:if test="${order.status == 'DELIVERED'}">
                                        <c:set var="deliveredCount" value="${deliveredCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${deliveredCount}
                            </h4>
                            <small class="text-muted">Delivered</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <i class="fas fa-clock fa-2x text-warning mb-2"></i>
                            <h4>
                                <c:set var="pendingCount" value="0"/>
                                <c:forEach items="${orders}" var="order">
                                    <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${pendingCount}
                            </h4>
                            <small class="text-muted">Pending</small>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Orders List -->
        <c:if test="${empty orders}">
            <div class="card">
                <div class="card-body text-center py-5">
                    <i class="fas fa-shopping-cart fa-5x text-muted mb-3"></i>
                    <h4 class="text-muted">No orders yet</h4>
                    <p class="text-muted">This customer hasn't placed any orders yet.</p>
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Create First Order
                    </a>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty orders}">
            <div class="row">
                <c:forEach items="${orders}" var="order">
                    <div class="col-lg-6 mb-4">
                        <div class="card order-card h-100">
                            <div class="card-body position-relative">
                                <span class="status-badge">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="badge bg-warning">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == 'CONFIRMED'}">
                                            <span class="badge bg-info">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPED'}">
                                            <span class="badge bg-primary">${order.status}</span>
                                        </c:when>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <span class="badge bg-success">${order.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>

                                <h5 class="card-title">Order #${order.id}</h5>
                                
                                <div class="mb-3">
                                    <p class="card-text mb-1">
                                        <i class="fas fa-calendar text-muted"></i> 
                                        <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                                    </p>
                                    <p class="card-text mb-1">
                                        <i class="fas fa-user text-muted"></i> 
                                        Placed by: ${order.placedByUser.username}
                                    </p>
                                    <p class="card-text mb-1">
                                        <i class="fas fa-boxes text-muted"></i> 
                                        ${order.orderItems.size()} items
                                    </p>
                                </div>

                                <!-- Order Items Preview -->
                                <div class="mb-3">
                                    <h6 class="text-muted">Items:</h6>
                                    <div class="small">
                                        <c:forEach items="${order.orderItems}" var="item" varStatus="status">
                                            <div class="d-flex justify-content-between">
                                                <span>${item.book.title} x ${item.quantity}</span>
                                                <span><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="$"/></span>
                                            </div>
                                            <c:if test="${status.index >= 2 && orders.size() > 3}">
                                                <div class="text-muted">... and ${order.orderItems.size() - 3} more items</div>
                                                <c:set var="break" value="true"/>
                                            </c:if>
                                            <c:if test="${break}">
                                                <c:remove var="break"/>
                                                <c:set var="break" value="false"/>
                                                <c:forEach begin="${status.index + 1}" end="${order.orderItems.size() - 1}" var="i">
                                                    <c:set var="skip" value="true"/>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="text-primary mb-0">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/>
                                        </h5>
                                    </div>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.id}" 
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye"></i> View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Summary Table for Print -->
            <div class="d-print-block d-none mt-4">
                <h4>Detailed Order Summary</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Order #</th>
                            <th>Date</th>
                            <th>Items</th>
                            <th>Total</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td>#${order.id}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
                                <td>${order.orderItems.size()}</td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                                <td>${order.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3">Total</th>
                            <th>
                                <c:set var="grandTotal" value="0"/>
                                <c:forEach items="${orders}" var="order">
                                    <c:set var="grandTotal" value="${grandTotal + order.totalAmount}"/>
                                </c:forEach>
                                <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="$"/>
                            </th>
                            <th></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Print styles
        const printStyles = `
            <style type="text/css" media="print">
                @page { 
                    margin: 0.5in;
                    size: A4;
                }
                body { 
                    font-size: 11pt;
                    line-height: 1.3;
                }
                .navbar, .btn:not(.d-print-block), .card:not(.customer-header) { 
                    display: none !important; 
                }
                .customer-header {
                    background: white !important;
                    color: black !important;
                    border: 2px solid #000;
                }
                .d-print-block {
                    display: block !important;
                }
                .summary-card {
                    background: white !important;
                    color: black !important;
                    border: 1px solid #000;
                }
                h3, h4 { 
                    color: #000 !important;
                    page-break-after: avoid;
                }
                .table {
                    page-break-inside: avoid;
                }
            </style>
        `;
        
        document.head.insertAdjacentHTML('beforeend', printStyles);
    </script>
</body>
</html>