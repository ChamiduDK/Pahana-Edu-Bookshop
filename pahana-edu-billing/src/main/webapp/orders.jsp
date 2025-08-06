<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
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
            top: 10px;
            right: 10px;
        }
        .book-selection {
            max-height: 300px;
            overflow-y: auto;
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
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-shopping-cart"></i> Order Management</h2>
            <div>
                <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#createOrderModal">
                    <i class="fas fa-plus"></i> Create New Order
                </button>
                <a href="${pageContext.request.contextPath}/orders?action=admin" class="btn btn-outline-info">
                    <i class="fas fa-cog"></i> Admin View
                </a>
            </div>
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

        <!-- Recent Orders -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-clock"></i> Recent Orders</h5>
            </div>
            <div class="card-body">
                <c:if test="${empty orders}">
                    <div class="text-center py-4">
                        <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No orders yet</h5>
                        <p class="text-muted">Create your first order to get started</p>
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
                                    <c:if test="${status.index < 10}"> <!-- Show only recent 10 orders -->
                                        <tr>
                                            <td><strong>#${order.id}</strong></td>
                                            <td>${order.customer.name}</td>
                                            <td><span class="badge bg-primary">${order.customer.accountNumber}</span></td>
                                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                                            <td>
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
                                            </td>
                                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.id}" 
                                                   class="btn btn-sm btn-outline-primary">
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
                            <a href="${pageContext.request.contextPath}/orders?action=admin" class="btn btn-outline-secondary">
                                View All Orders (${orders.size()} total)
                            </a>
                        </div>
                    </c:if>
                </c:if>
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
                                <a href="${pageContext.request.contextPath}/customers" target="_blank">
                                    <i class="fas fa-plus"></i> Add new customer
                                </a>
                            </div>
                        </div>

                        <!-- Book Selection -->
                        <div class="mb-4">
                            <label class="form-label">Select Books *</label>
                            <div class="book-selection border rounded p-3">
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
                                                <strong>$<fmt:formatNumber value="${book.price}" pattern="0.00"/></strong>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <input type="number" class="form-control quantity-input" 
                                                   name="quantity" min="1" max="${book.stockQuantity}" 
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
                                    <strong id="totalAmount">$0.00</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="createOrderBtn" disabled>
                            <i class="fas fa-shopping-cart"></i> Create Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
                            <span>$${subtotal.toFixed(2)}</span>
                        </div>`;
                    }
                });
                
                summaryHtml += '</div>';
                createOrderBtn.disabled = totalAmount === 0;
            }
            
            summaryDiv.innerHTML = summaryHtml;
            totalAmountSpan.textContent = '$' + totalAmount.toFixed(2);
        }

        // Reset form when modal is hidden
        document.getElementById('createOrderModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('createOrderForm').reset();
            document.querySelectorAll('.quantity-input').forEach(input => {
                input.disabled = true;
                input.value = '';
            });
            updateOrderSummary();
        });

        // Validate form before submission
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
    </script>
</body>
</html>