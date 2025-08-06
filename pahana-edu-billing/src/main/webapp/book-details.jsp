<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Details - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all1.min.css" rel="stylesheet">
    <style>
        .book-cover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 200px;
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
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-book"></i> Pahana Edu Bookshop
            </a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link"><i class="fas fa-dashboard"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/customers" class="nav-link"><i class="fas fa-users"></i> Customers</a>
                <a href="${pageContext.request.contextPath}/orders" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders</a>
                <a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="fas fa-books"></i> Books</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2><i class="fas fa-book"></i> Book Details</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty viewBook}">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="book-cover mb-3 ${viewBook.stockQuantity == 0 ? 'out-of-stock' : viewBook.stockQuantity <= 5 ? 'low-stock' : ''}">
                                <div class="text-center">
                                    <i class="fas fa-book fa-3x mb-2"></i>
                                    <div class="small">${viewBook.category}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <h4>${viewBook.title}</h4>
                            <p><strong>Author:</strong> ${viewBook.author}</p>
                            <c:if test="${not empty viewBook.isbn}">
                                <p><strong>ISBN:</strong> ${viewBook.isbn}</p>
                            </c:if>
                            <p><strong>Price:</strong> LKR <fmt:formatNumber value="${viewBook.price}" pattern="0.00"/></p>
                            <p><strong>Stock:</strong> 
                                <c:choose>
                                    <c:when test="${viewBook.stockQuantity == 0}">
                                        <span class="badge bg-danger">Out of Stock</span>
                                    </c:when>
                                    <c:when test="${viewBook.stockQuantity <= 5}">
                                        <span class="badge bg-warning">Low: ${viewBook.stockQuantity}</span>
                                    </c:when>
                                    <c:when test="${viewBook.stockQuantity <= 10}">
                                        <span class="badge bg-info">Stock: ${viewBook.stockQuantity}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">Stock: ${viewBook.stockQuantity}</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p><strong>Category:</strong> ${viewBook.category}</p>
                            <c:if test="${not empty viewBook.description}">
                                <p><strong>Description:</strong> ${viewBook.description}</p>
                            </c:if>
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/books?action=edit&id=${viewBook.id}" 
                                   class="btn btn-outline-primary"><i class="fas fa-edit"></i> Edit</a>
                                <a href="${pageContext.request.contextPath}/books" 
                                   class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back to Books</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${empty viewBook}">
            <div class="text-center py-5">
                <i class="fas fa-book fa-5x text-muted mb-3"></i>
                <h4 class="text-muted">Book Not Found</h4>
                <p class="text-muted">The requested book could not be found.</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to Books
                </a>
            </div>
        </c:if>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>