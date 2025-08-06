<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .book-card {
            transition: transform 0.3s;
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            height: 100%;
        }
        .book-card:hover {
            transform: translateY(-5px);
        }
        .stock-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .book-cover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            border-radius: 5px;
        }
        .low-stock {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
        }
        .out-of-stock {
            background: linear-gradient(135deg, #535353 0%, #404040 100%);
        }
        .filter-controls {
            background: #f8f9fa;
            border-radius: 10px;
        }
        .category-filter {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>
                <i class="fas fa-books"></i> 
                <c:choose>
                    <c:when test="${lowStockView}">
                        Low Stock Books (≤ ${threshold} units)
                    </c:when>
                    <c:otherwise>
                        Book Management
                    </c:otherwise>
                </c:choose>
            </h2>
            <div>
                <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#addBookModal">
                    <i class="fas fa-plus"></i> Add New Book
                </button>
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

        <!-- Search and Filter Controls -->
        <div class="card mb-4 filter-controls">
            <div class="card-body">
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
                            <button type="submit" class="btn btn-outline-primary me-2">
                                <i class="fas fa-search"></i> Search
                            </button>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-secondary">
                                <i class="fas fa-refresh"></i> Clear
                            </a>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Books Found</label>
                            <div class="form-control-plaintext">
                                <strong>${books.size()}</strong> books
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Books Grid -->
        <div class="row">
            <c:forEach items="${books}" var="book">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card book-card">
                        <div class="card-body position-relative">
                            <!-- Stock Badge -->
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
                            
                            <!-- Book Cover -->
                            <div class="book-cover mb-3 ${book.stockQuantity == 0 ? 'out-of-stock' : book.stockQuantity <= 5 ? 'low-stock' : ''}">
                                <div class="text-center">
                                    <i class="fas fa-book fa-3x mb-2"></i>
                                    <div class="small">${book.category}</div>
                                </div>
                            </div>
                            
                            <h6 class="card-title">${book.title}</h6>
                            <p class="card-text">
                                <small class="text-muted">by ${book.author}</small>
                            </p>
                            
                            <c:if test="${not empty book.isbn}">
                                <p class="small text-muted mb-2">ISBN: ${book.isbn}</p>
                            </c:if>
                            
                            <div class="mb-3">
                                <span class="h5 text-primary">LKR <fmt:formatNumber value="${book.price}" pattern="0.00"/></span>
                            </div>
                            
                            <c:if test="${not empty book.description}">
                                <p class="card-text small">
                                    ${book.description.length() > 80 ? 
                                      book.description.substring(0, 80).concat("...") : 
                                      book.description}
                                </p>
                            </c:if>
                            
                            <!-- Action Buttons -->
                            <div class="d-flex gap-1">
                                <button class="btn btn-sm btn-outline-primary flex-fill" 
                                        onclick="editBook(${book.id}, '${book.title}', '${book.author}', '${book.isbn}', '${book.price}', ${book.stockQuantity}, '${book.category}', '${book.description}')">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-info" 
                                        onclick="showStockModal(${book.id}, '${book.title}', ${book.stockQuantity})">
                                    <i class="fas fa-boxes"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/books?action=view&id=${book.id}" 
                                   class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <form method="post" action="${pageContext.request.contextPath}/books" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${book.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger" 
                                            onclick="return confirm('Are you sure you want to delete this book?')">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- No Books Found -->
        <c:if test="${empty books}">
            <div class="text-center py-5">
                <i class="fas fa-books fa-5x text-muted mb-3"></i>
                <h4 class="text-muted">No books found</h4>
                <p class="text-muted">
                    <c:choose>
                        <c:when test="${not empty searchTerm or not empty selectedCategory}">
                            Try adjusting your search criteria or 
                            <a href="${pageContext.request.contextPath}/books">view all books</a>
                        </c:when>
                        <c:otherwise>
                            Add your first book to get started
                        </c:otherwise>
                    </c:choose>
                </p>
                <c:if test="${empty searchTerm and empty selectedCategory}">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                        <i class="fas fa-plus"></i> Add First Book
                    </button>
                </c:if>
            </div>
        </c:if>
    </div>

    <!-- Add Book Modal -->
    <div class="modal fade" id="addBookModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
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
                                    <label for="bookStock" class="form-label">Initial Stock *</label>
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
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
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
            <div class="modal-content">
                <div class="modal-header">
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
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
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
            <div class="modal-content">
                <div class="modal-header">
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
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Stock
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
            
            // Reset to add operation
            document.getElementById('opAdd').checked = true;
            
            new bootstrap.Modal(document.getElementById('stockModal')).show();
        }

        // Auto-focus on search input when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.querySelector('input[name="searchTerm"]');
            if (searchInput && !searchInput.value) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>