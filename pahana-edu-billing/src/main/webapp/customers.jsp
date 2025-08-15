<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Pahana Edu Bookshop</title>
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

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
            color: white;
        }

        /* Account Badge */
        .account-badge {
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
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

            .card-body {
                padding: 1.5rem;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/customers">
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
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="topbar">
            <div class="topbar-title">
                <h4>Customer Management</h4>
                <div class="topbar-subtitle">Manage customer information and view their orders</div>
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
                    <h5 class="mb-1" style="color: var(--dark-color); font-weight: 700;">Customer List</h5>
                    <p class="text-muted mb-0">View and manage all customers</p>
                </div>
                <button class="action-btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                    <i class="fas fa-plus"></i> Add New Customer
                </button>
            </div>

            <!-- Search Controls -->
            <div class="card mb-4 loading">
                <div class="card-header">
                    <h5><i class="fas fa-search"></i> Search Customers</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <form method="get" action="${pageContext.request.contextPath}/customers">
                                <input type="hidden" name="action" value="search">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="searchTerm" 
                                           placeholder="Search by name, account number, or telephone..." value="${searchTerm}">
                                    <button type="submit" class="action-btn btn-primary">
                                        <i class="fas fa-search"></i> Search
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <a href="${pageContext.request.contextPath}/customers" class="action-btn btn-secondary w-100">
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
                        <div class="card customer-card h-100 loading">
                            <div class="card-body position-relative">
                                <span class="account-badge bg-primary">
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
                                <div class="d-flex flex-wrap gap-2">
                                    <button class="action-btn btn-primary flex-fill" 
                                            onclick="editCustomer(${customer.id}, '${customer.accountNumber}', '${customer.name}', '${customer.address}', '${customer.telephone}', '${customer.email}', ${customer.unitsConsumed})">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <a href="${pageContext.request.contextPath}/orders?action=customer&customerId=${customer.id}" 
                                       class="action-btn btn-info">
                                        <i class="fas fa-shopping-cart"></i> Orders
                                    </a>
                                    <form method="post" action="${pageContext.request.contextPath}/customers" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${customer.id}">
                                        <button type="submit" class="action-btn btn-danger" 
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
                <div class="empty-state loading">
                    <i class="fas fa-users"></i>
                    <h5>No Customers Found</h5>
                    <p>Add your first customer to get started.</p>
                    <button class="action-btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                        <i class="fas fa-plus"></i> Add Customer
                    </button>
                </div>
            </c:if>
        </div>
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
                                <button type="button" class="action-btn btn-secondary" onclick="generateAccountNumber()">
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
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="action-btn btn-primary">
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
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="action-btn btn-primary">
                            <i class="fas fa-save"></i> Update Customer
                        </button>
                    </div>
                </form>
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

        document.getElementById('addCustomerModal').addEventListener('shown.bs.modal', function() {
            if (!document.getElementById('accountNumber').value) {
                generateAccountNumber();
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