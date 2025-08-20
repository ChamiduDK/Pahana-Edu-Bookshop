<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Customer Profile</h1>
        
        <!-- Test if customer object exists -->
        <c:choose>
            <c:when test="${not empty sessionScope.customer}">
                <div class="alert alert-success">
                    <h4>Welcome, ${sessionScope.customer.name}!</h4>
                    <p>Customer ID: ${sessionScope.customer.id}</p>
                    <p>Email: ${sessionScope.customer.email}</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">
                    <h4>No customer data found in session</h4>
                    <p>Please <a href="${pageContext.request.contextPath}/login.jsp">login</a> first.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Display any error messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <strong>Error:</strong> ${error}
            </div>
        </c:if>

        <!-- Display any success messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <strong>Success:</strong> ${success}
            </div>
        </c:if>

        <!-- Simple profile form for testing -->
        <div class="card mt-4">
            <div class="card-header">
                <h5>Update Profile</h5>
            </div>
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/customer-profile">
                    <div class="mb-3">
                        <label for="name" class="form-label">Name *</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="${sessionScope.customer.name}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email *</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               value="${sessionScope.customer.email}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="address" class="form-label">Address *</label>
                        <textarea class="form-control" id="address" name="address" rows="3" required>${sessionScope.customer.address}</textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="telephone" class="form-label">Telephone *</label>
                        <input type="tel" class="form-control" id="telephone" name="telephone" 
                               value="${sessionScope.customer.telephone}" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                    <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn btn-secondary">Back to Dashboard</a>
                </form>
            </div>
        </div>

        <!-- Debug information -->
        <div class="card mt-4">
            <div class="card-header">
                <h6>Debug Information</h6>
            </div>
            <div class="card-body">
                <p><strong>Context Path:</strong> ${pageContext.request.contextPath}</p>
                <p><strong>Session ID:</strong> ${pageContext.session.id}</p>
                <p><strong>Request URI:</strong> ${pageContext.request.requestURI}</p>
                <p><strong>Server Info:</strong> ${pageContext.servletContext.serverInfo}</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>