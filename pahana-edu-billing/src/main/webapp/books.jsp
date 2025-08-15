<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management - Pahana Edu Bookshop</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

        /* Book Cards */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .book-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .book-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-heavy);
        }

        .book-cover {
            background: var(--primary-gradient);
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            border-radius: 15px;
            margin-bottom: 1.5rem;
        }

        .low-stock {
            background: var(--warning-gradient);
        }

        .out-of-stock {
            background: var(--dark-gradient);
        }

        .stock-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .book-info {
            text-align: center;
        }

        .book-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .book-author, .book-isbn {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .book-price {
            font-size: 1.1rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
        }

        .book-actions {
            display: flex;
    gap: 0.5rem;
    justify-content: center;
    flex-wrap: wrap;
    flex-direction: row;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-warning {
            background: var(--warning-gradient);
            color: white;
        }

        .btn-danger {
            background: var(--danger-gradient);
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

        /* Filter Controls */
        .filter-controls {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-light);
            margin-bottom: 2rem;
        }

        /* Add Book Button */
        .add-book-btn {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: var(--border-radius);
            font-weight: 700;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-light);
        }

        .add-book-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
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

        /* Mobile Responsive */
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

            .book-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
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

            .book-actions {
                flex-direction: column;
            }

            .action-btn {
                justify-content: center;
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
                    <i class = "fas fa-graduation-cap"></i>
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/orders">
                        <i class="fas fa-shopping-bag"></i>
                        Orders
                    </a>
                </div>
                <div class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/books">
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
                <h4>
                    <c:choose>
                        <c:when test="${lowStockView}">
                            Low Stock Books (≤ ${threshold} units)
                        </c:when>
                        <c:otherwise>
                            Book Management
                        </c:otherwise>
                    </c:choose>
                </h4>
                <div class="topbar-subtitle">Manage your book inventory</div>
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

            <!-- Header with Add Button and Filters -->
            <div class="d-flex justify-content-between align-items-center mb-4 loading">
                <div>
                    <h5 class="mb-1" style="color: var(--dark-color); font-weight: 700;">Book Inventory</h5>
                    <p class="text-muted mb-0">Manage and monitor your book collection</p>
                </div>
                <div class="d-flex gap-3">
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline-info dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fas fa-filter"></i> Quick Filters
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/books">
                                <i class="fas fa-list"></i> All Books
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/books?action=lowStock&threshold=5">
                                <i class="fas fa-exclamation-triangle text-danger"></i> Critical Stock (≤5)
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/books?action=lowStock&threshold=10">
                                <i class="fas fa-exclamation-circle text-warning"></i> Low Stock (≤10)
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/books?action=lowStock&threshold=0">
                                <i class="fas fa-times-circle text-danger"></i> Out of Stock
                            </a></li>
                        </ul>
                    </div>
                    <button class="add-book-btn" data-bs-toggle="modal" data-bs-target="#addBookModal">
                        <i class="fas fa-book"></i> Add New Book
                    </button>
                </div>
            </div>

            <!-- Search and Filter Controls -->
            <div class="filter-controls loading">
                <form method="get" action="${pageContext.request.contextPath}/books">
                    <input type="hidden" name="action" value="search">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="form-label">Search Books</label>
                            <input type="text" class="form-control" name="searchTerm" 
                                   placeholder="Search by title, author, or ISBN..." value="${searchTerm}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="category">
                                <option value="all">All Categories</option>
                                <option value="Programming" ${selectedCategory == 'Programming' ? 'selected' : ''}>Programming</option>
                                <option value="Database" ${selectedCategory == 'Database' ? 'selected' : ''}>Database</option>
                                <option value="Web" ${selectedCategory == 'Web' ? 'selected' : ''}>Web Development</option>
                                <option value="Mathematics" ${selectedCategory == 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                                <option value="Science" ${selectedCategory == 'Science' ? 'selected' : ''}>Science</option>
                                <option value="Literature" ${selectedCategory == 'Literature' ? 'selected' : ''}>Literature</option>
                                <option value="History" ${selectedCategory == 'History' ? 'selected' : ''}>History</option>
                                <option value="Other" ${selectedCategory == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button type="submit" class="action-btn btn-primary me-2">
                                <i class="fas fa-search"></i> Search
                            </button>
                            <a href="${pageContext.request.contextPath}/books" class="action-btn btn-secondary">
                                <i class="fas fa-refresh"></i> Clear
                            </a>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <div class="form-control-plaintext">
                                <strong>${books.size()}</strong> books found
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Books Grid -->
            <c:if test="${empty books}">
                <div class="empty-state loading">
                    <i class="fas fa-book-open"></i>
                    <h5>No Books Found</h5>
                    <p>
                        <c:choose>
                            <c:when test="${not empty searchTerm or not empty selectedCategory}">
                                Try adjusting your search criteria or view all books.
                            </c:when>
                            <c:otherwise>
                                Add your first book to get started.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <a href="${pageContext.request.contextPath}/books" class="add-book-btn mt-3">
                        <i class="fas fa-book"></i> 
                        <c:choose>
                            <c:when test="${not empty searchTerm or not empty selectedCategory}">
                                View All Books
                            </c:when>
                            <c:otherwise>
                                Add First Book
                            </c:otherwise>
                        </c:choose>
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty books}">
                <div class="book-grid">
                    <c:forEach items="${books}" var="book" varStatus="status">
                        <div class="book-card loading" style="animation-delay: ${status.index * 0.1}s">
                            <div class="book-cover ${book.stockQuantity == 0 ? 'out-of-stock' : book.stockQuantity <= 5 ? 'low-stock' : ''}">
                                <div class="text-center">
                                    <i class="fas fa-book fa-3x mb-2"></i>
                                    <div class="small">${book.category}</div>
                                </div>
                            </div>
                            <span class="stock-badge">
                                <c:choose>
                                    <c:when test="${book.stockQuantity == 0}">
                                        <span class="badge bg-danger">Out of Stock</span>
                                    </c:when>
                                    <c:when test="${book.stockQuantity <= 5}">
                                        <span class="badge bg-warning">Low: ${book.stockQuantity}</span>
                                    </c:when>
                                    <c:when test="${book.stockQuantity <= 10}">
                                        <span class="badge bg-info">Stock: ${book.stockQuantity}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">Stock: ${book.stockQuantity}</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <div class="book-info">
                                <div class="book-title">${book.title}</div>
                                <div class="book-author">by ${book.author}</div>
                                <c:if test="${not empty book.isbn}">
                                    <div class="book-isbn">ISBN: ${book.isbn}</div>
                                </c:if>
                                <div class="book-price">LKR <fmt:formatNumber value="${book.price}" pattern="0.00"/></div>
                                <c:if test="${not empty book.description}">
                                    <p class="small text-muted">
                                        ${book.description.length() > 80 ? 
                                          book.description.substring(0, 80).concat("...") : 
                                          book.description}
                                    </p>
                                </c:if>
                                <div class="book-actions">
                                    <a href="${pageContext.request.contextPath}/books?action=view&id=${book.id}" 
                                       class="action-btn btn-primary">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <button class="action-btn btn-warning" 
                                            onclick="editBook(${book.id}, '${book.title}', '${book.author}', '${book.isbn}', '${book.price}', ${book.stockQuantity}, '${book.category}', '${book.description}')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="action-btn btn-info" 
                                            onclick="showStockModal(${book.id}, '${book.title}', ${book.stockQuantity})">
                                        <i class="fas fa-boxes"></i> Stock
                                    </button>
                                    <a href="#" onclick="confirmDelete(${book.id}, '${book.title}')" 
                                       class="action-btn btn-danger">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Add Book Modal -->
    <div class="modal fade" id="addBookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="border-radius: var(--border-radius);">
                <div class="modal-header border-0">
                    <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Add New Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/books">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="bookTitle" class="form-label">Title *</label>
                                    <input type="text" class="form-control" id="bookTitle" name="title" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="bookCategory" class="form-label">Category</label>
                                    <select class="form-select" id="bookCategory" name="category">
                                        <option value="">Select Category</option>
                                        <option value="Programming">Programming</option>
                                        <option value="Database">Database</option>
                                        <option value="Web">Web Development</option>
                                        <option value="Mathematics">Mathematics</option>
                                        <option value="Science">Science</option>
                                        <option value="Literature">Literature</option>
                                        <option value="History">History</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="bookAuthor" class="form-label">Author *</label>
                                    <input type="text" class="form-control" id="bookAuthor" name="author" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="bookIsbn" class="form-label">ISBN</label>
                                    <input type="text" class="form-control" id="bookIsbn" name="isbn">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="bookPrice" class="form-label">Price *</label>
                                    <div class="input-group">
                                        <span class="input-group-text">LKR</span>
                                        <input type="number" class="form-control" id="bookPrice" name="price" 
                                               step="0.01" min="0" required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for "bookStock" class="form-label">Initial Stock *</label>
                                    <input type="number" class="form-control" id="bookStock" name="stockQuantity" 
                                           min="0" value="0" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="bookDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="bookDescription" name="description" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="action-btn btn-primary">
                            <i class="fas fa-save"></i> Add Book
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Book Modal -->
    <div class="modal fade" id="editBookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="border-radius: var(--border-radius);">
                <div class="modal-header border-0">
                    <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/books">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="editBookId">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="editBookTitle" class="form-label">Title *</label>
                                    <input type="text" class="form-control" id="editBookTitle" name="title" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="editBookCategory" class="form-label">Category</label>
                                    <select class="form-select" id="editBookCategory" name="category">
                                        <option value="">Select Category</option>
                                        <option value="Programming">Programming</option>
                                        <option value="Database">Database</option>
                                        <option value="Web">Web Development</option>
                                        <option value="Mathematics">Mathematics</option>
                                        <option value="Science">Science</option>
                                        <option value="Literature">Literature</option>
                                        <option value="History">History</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="editBookAuthor" class="form-label">Author *</label>
                                    <input type="text" class="form-control" id="editBookAuthor" name="author" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="editBookIsbn" class="form-label">ISBN</label>
                                    <input type="text" class="form-control" id="editBookIsbn" name="isbn">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="editBookPrice" class="form-label">Price *</label>
                                    <div class="input-group">
                                        <span class="input-group-text">LKR</span>
                                        <input type="number" class="form-control" id="editBookPrice" name="price" 
                                               step="0.01" min="0" required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="editBookStock" class="form-label">Current Stock</label>
                                    <input type="number" class="form-control" id="editBookStock" name="stockQuantity" 
                                           min="0" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="editBookDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="editBookDescription" name="description" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="action-btn btn-primary">
                            <i class="fas fa-save"></i> Update Book
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Stock Management Modal -->
    <div class="modal fade" id="stockModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content" style="border-radius: var(--border-radius);">
                <div class="modal-header border-0">
                    <h5 class="modal-title"><i class="fas fa-boxes"></i> Manage Stock</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/books">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updateStock">
                        <input type="hidden" name="bookId" id="stockBookId">
                        <div class="mb-3">
                            <h6 id="stockBookTitle"></h6>
                            <p class="text-muted">Current Stock: <span id="currentStock" class="fw-bold"></span></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Operation</label>
                            <div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="operation" value="add" id="opAdd" checked>
                                    <label class="form-check-label" for="opAdd">
                                        <i class="fas fa-plus text-success"></i> Add Stock
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="operation" value="subtract" id="opSubtract">
                                    <label class="form-check-label" for="opSubtract">
                                        <i class="fas fa-minus text-warning"></i> Remove Stock
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="operation" value="set" id="opSet">
                                    <label class="form-check-label" for="opSet">
                                        <i class="fas fa-edit text-info"></i> Set Stock Level
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="stockQuantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="stockQuantity" name="quantity" min="0" required>
                        </div>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            <strong>Note:</strong> Stock changes will be reflected immediately and may affect order processing.
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="action-btn btn-primary">
                            <i class="fas fa-save"></i> Update Stock
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: var(--border-radius);">
                <div class="modal-header border-0">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-danger"></i>
                        Confirm Delete
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete book <strong id="bookTitleToDelete"></strong>?</p>
                    <p class="text-danger small">
                        <i class="fas fa-warning"></i>
                        This action cannot be undone.
                    </p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="action-btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteBtn" class="action-btn btn-danger">
                        <i class="fas fa-trash"></i> Delete
                    </a>
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

        function editBook(id, title, author, isbn, price, stockQuantity, category, description) {
            document.getElementById('editBookId').value = id;
            document.getElementById('editBookTitle').value = title;
            document.getElementById('editBookAuthor').value = author;
            document.getElementById('editBookIsbn').value = isbn || '';
            document.getElementById('editBookPrice').value = price;
            document.getElementById('editBookStock').value = stockQuantity;
            document.getElementById('editBookCategory').value = category || '';
            document.getElementById('editBookDescription').value = description || '';
            new bootstrap.Modal(document.getElementById('editBookModal')).show();
        }

        function showStockModal(bookId, title, currentStock) {
            document.getElementById('stockBookId').value = bookId;
            document.getElementById('stockBookTitle').textContent = title;
            document.getElementById('currentStock').textContent = currentStock;
            document.getElementById('stockQuantity').value = '';
            document.getElementById('opAdd').checked = true;
            new bootstrap.Modal(document.getElementById('stockModal')).show();
        }

        function confirmDelete(bookId, bookTitle) {
            document.getElementById('bookTitleToDelete').textContent = bookTitle;
            document.getElementById('confirmDeleteBtn').href = 
                '${pageContext.request.contextPath}/books?action=delete&id=' + bookId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.querySelector('input[name="searchTerm"]');
            if (searchInput && !searchInput.value) {
                searchInput.focus();
            }

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