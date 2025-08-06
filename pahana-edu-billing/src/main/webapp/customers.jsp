<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .customer-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .customer-card:hover {
            transform: translateY(-5px);
        }
        .account-badge {
            position: absolute;
            top: 10px;
            right: 10px;
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
                <a href="${pageContext.request.contextPath}/orders" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-users"></i> Customer Management</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                <i class="fas fa-plus"></i> Add New Customer
            </button>
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

        <!-- Search Controls -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <form method="get" action="${pageContext.request.contextPath}/customers">
                            <input type="hidden" name="action" value="search">
                            <div class="input-group">
                                <input type="text" class="form-control" name="searchTerm" 
                                       placeholder="Search by name, account number, or telephone..." value="${searchTerm}">
                                <button type="submit" class="btn btn-outline-primary">
                                    <i class="fas fa-search"></i> Search
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/customers" class="btn btn-outline-secondary w-100">
                            <i class="fas fa-refresh"></i> Show All Customers
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customers Grid -->
        <div class="row">
            <c:forEach items="${customers}" var="customer">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card customer-card h-100">
                        <div class="card-body position-relative">
                            <span class="badge bg-primary account-badge">
                                ${customer.accountNumber}
                            </span>
                            
                            <h5 class="card-title">${customer.name}</h5>
                            
                            <div class="mb-3">
                                <p class="card-text mb-1">
                                    <i class="fas fa-map-marker-alt text-muted"></i> 
                                    <small>${customer.address}</small>
                                </p>
                                <p class="card-text mb-1">
                                    <i class="fas fa-phone text-muted"></i> 
                                    <small>${customer.telephone}</small>
                                </p>
                                <c:if test="${not empty customer.email}">
                                    <p class="card-text mb-1">
                                        <i class="fas fa-envelope text-muted"></i> 
                                        <small>${customer.email}</small>
                                    </p>
                                </c:if>
                            </div>
                            
                            <div class="mb-3">
                                <span class="badge bg-success">Units Consumed: ${customer.unitsConsumed}</span>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-outline-primary flex-fill" 
                                        onclick="editCustomer(${customer.id}, '${customer.accountNumber}', '${customer.name}', '${customer.address}', '${customer.telephone}', '${customer.email}', ${customer.unitsConsumed})">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <a href="${pageContext.request.contextPath}/orders?action=customer&customerId=${customer.id}" 
                                   class="btn btn-sm btn-info">
                                    <i class="fas fa-shopping-cart"></i> Orders
                                </a>
                                <form method="post" action="${pageContext.request.contextPath}/customers" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${customer.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger" 
                                            onclick="return confirm('Are you sure you want to delete this customer?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty customers}">
            <div class="text-center py-5">
                <i class="fas fa-users fa-5x text-muted mb-3"></i>
                <h4 class="text-muted">No customers found</h4>
                <p class="text-muted">Add your first customer to get started</p>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                    <i class="fas fa-plus"></i> Add Customer
                </button>
            </div>
        </c:if>
    </div>

    <!-- Add Customer Modal -->
    <div class="modal fade" id="addCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-user-plus"></i> Add New Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/customers">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="mb-3">
                            <label for="accountNumber" class="form-label">Account Number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
                                <button type="button" class="btn btn-outline-secondary" onclick="generateAccountNumber()">
                                    <i class="fas fa-magic"></i> Generate
                                </button>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="customerName" class="form-label">Full Name *</label>
                            <input type="text" class="form-control" id="customerName" name="name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="customerAddress" class="form-label">Address *</label>
                            <textarea class="form-control" id="customerAddress" name="address" rows="3" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="customerTelephone" class="form-label">Telephone *</label>
                            <input type="tel" class="form-control" id="customerTelephone" name="telephone" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="customerEmail" class="form-label">Email (Optional)</label>
                            <input type="email" class="form-control" id="customerEmail" name="email">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Add Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Customer Modal -->
    <div class="modal fade" id="editCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-user-edit"></i> Edit Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/customers">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="editCustomerId">
                        
                        <div class="mb-3">
                            <label for="editAccountNumber" class="form-label">Account Number</label>
                            <input type="text" class="form-control" id="editAccountNumber" name="accountNumber" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCustomerName" class="form-label">Full Name *</label>
                            <input type="text" class="form-control" id="editCustomerName" name="name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCustomerAddress" class="form-label">Address *</label>
                            <textarea class="form-control" id="editCustomerAddress" name="address" rows="3" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCustomerTelephone" class="form-label">Telephone *</label>
                            <input type="tel" class="form-control" id="editCustomerTelephone" name="telephone" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCustomerEmail" class="form-label">Email (Optional)</label>
                            <input type="email" class="form-control" id="editCustomerEmail" name="email">
                        </div>
                        
                        <div class="mb-3">
                            <label for="editUnitsConsumed" class="form-label">Units Consumed</label>
                            <input type="number" class="form-control" id="editUnitsConsumed" name="unitsConsumed" min="0">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editCustomer(id, accountNumber, name, address, telephone, email, unitsConsumed) {
            document.getElementById('editCustomerId').value = id;
            document.getElementById('editAccountNumber').value = accountNumber;
            document.getElementById('editCustomerName').value = name;
            document.getElementById('editCustomerAddress').value = address;
            document.getElementById('editCustomerTelephone').value = telephone;
            document.getElementById('editCustomerEmail').value = email || '';
            document.getElementById('editUnitsConsumed').value = unitsConsumed;
            
            new bootstrap.Modal(document.getElementById('editCustomerModal')).show();
        }

        function generateAccountNumber() {
            fetch('${pageContext.request.contextPath}/customers?action=generateAccount')
                .then(response => response.text())
                .then(accountNumber => {
                    document.getElementById('accountNumber').value = accountNumber;
                })
                .catch(error => {
                    console.error('Error generating account number:', error);
                    alert('Failed to generate account number');
                });
        }

        // Auto-generate account number when modal opens
        document.getElementById('addCustomerModal').addEventListener('shown.bs.modal', function() {
            if (!document.getElementById('accountNumber').value) {
                generateAccountNumber();
            }
        });
    </script>
</body>
</html>