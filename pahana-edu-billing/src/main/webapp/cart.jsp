<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* Reuse styles from customer-dashboard.jsp */
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --primary-color: #667eea;
            --dark-color: #2d3748;
            --border-radius: 24px;
            --shadow-light: 0 4px 25px rgba(0, 0, 0, 0.08);
            --shadow-medium: 0 8px 50px rgba(0, 0, 0, 0.12);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: rgba(247, 250, 252, 0.8);
            color: #2d3748;
            overflow-x: hidden;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: var(--shadow-light);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 0;
            position: relative;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 900;
        }

        .cart-table {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            padding: 2rem;
        }

        .btn-checkout {
            background: var(--success-gradient);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
        }

        .btn-remove {
            background: var(--secondary-gradient);
            color: white;
            border: none;
            border-radius: 16px;
            padding: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <nav class="header navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/customer-dashboard">
                <div class="brand-icon">
                    <i class="fas fa-book"></i>
                </div>
                <span class="brand-text">Pahana Edu Bookshop</span>
            </a>
            <div class="navbar-nav">
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle me-2"></i>${sessionScope.customer.name}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-orders"><i class="fas fa-history me-2"></i>My Orders</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-profile"><i class="fas fa-user-edit me-2"></i>Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer-logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1 class="page-title">Your Cart</h1>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container mt-4">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle me-2"></i>${success}
            </div>
        </c:if>

        <div class="cart-table">
            <c:choose>
                <c:when test="${empty sessionScope.cart.items}">
                    <p>Your cart is empty. <a href="${pageContext.request.contextPath}/customer-dashboard">Browse books</a>.</p>
                </c:when>
                <c:otherwise>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>Author</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessionScope.cart.items}" var="item">
                                <tr>
                                    <td>${item.book.title}</td>
                                    <td>${item.book.author}</td>
                                    <td><fmt:formatNumber value="${item.book.price}" pattern="0.00"/> LKR</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.book.price * item.quantity}" pattern="0.00"/> LKR</td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/cart">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="bookId" value="${item.book.id}">
                                            <button type="submit" class="btn btn-remove"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="text-end">
                        <h4>Total: <fmt:formatNumber value="${sessionScope.cart.items.stream().map(item -> item.book.price * item.quantity).sum()}" pattern="0.00"/> LKR</h4>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-checkout">Proceed to Checkout</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>