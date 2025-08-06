<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-book"></i> Pahana Edu Bookshop
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header">
                        <h5>Help Topics</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#getting-started" class="list-group-item list-group-item-action">Getting Started</a>
                        <a href="#books" class="list-group-item list-group-item-action">Managing Books</a>
                        <a href="#orders" class="list-group-item list-group-item-action">Orders</a>
                        <a href="#admin" class="list-group-item list-group-item-action">Admin Features</a>
                        <a href="#troubleshooting" class="list-group-item list-group-item-action">Troubleshooting</a>
                    </div>
                </div>
            </div>

            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-question-circle"></i> Help & Documentation</h3>
                    </div>
                    <div class="card-body">
                        <section id="getting-started" class="mb-5">
                            <h4>Getting Started</h4>
                            <p>Welcome to Pahana Edu Bookshop Management System. This system helps you manage your bookstore inventory, process orders, and track sales.</p>
                            
                            <h5>First Steps:</h5>
                            <ol>
                                <li>Log in with your credentials</li>
                                <li>Navigate to the Dashboard to see system overview</li>
                                <li>Use the sidebar menu to access different features</li>
                            </ol>
                        </section>

                        <section id="books" class="mb-5">
                            <h4>Managing Books</h4>
                            <p>The book management section allows you to:</p>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-primary">
                                        <div class="card-body">
                                            <h6><i class="fas fa-plus"></i> Adding Books</h6>
                                            <ul>
                                                <li>Click "Add New Book" button</li>
                                                <li>Fill in required details (Title, Author, ISBN, Price)</li>
                                                <li>Set stock quantity and category</li>
                                                <li>Add description for better organization</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-success">
                                        <div class="card-body">
                                            <h6><i class="fas fa-search"></i> Searching Books</h6>
                                            <ul>
                                                <li>Use the search bar to find books by title, author, or ISBN</li>
                                                <li>Filter by category for organized browsing</li>
                                                <li>View detailed book information</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section id="orders" class="mb-5">
                            <h4>Order Management</h4>
                            <p>Process and track customer orders efficiently:</p>
                            
                            <div class="alert alert-info">
                                <h6><i class="fas fa-info-circle"></i> Order Process</h6>
                                <p>Orders go through these stages:</p>
                                <span class="badge bg-warning">PENDING</span> →
                                <span class="badge bg-primary">CONFIRMED</span> →
                                <span class="badge bg-info">SHIPPED</span> →
                                <span class="badge bg-success">DELIVERED</span>
                            </div>

                            <h5>Features:</h5>
                            <ul>
                                <li>Automatic stock quantity updates</li>
                                <li>Email notifications for order confirmations</li>
                                <li>Bill calculation based on quantity and unit price</li>
                                <li>Order history tracking</li>
                            </ul>
                        </section>

                        <section id="admin" class="mb-5">
                            <h4>Admin Features</h4>
                            <p>Admin users have additional capabilities:</p>
                            
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card border-warning">
                                        <div class="card-body text-center">
                                            <i class="fas fa-users fa-2x text-warning mb-2"></i>
                                            <h6>User Management</h6>
                                            <p>Create and manage user accounts</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-info">
                                        <div class="card-body text-center">
                                            <i class="fas fa-chart-bar fa-2x text-info mb-2"></i>
                                            <h6>Reports</h6>
                                            <p>View sales and inventory reports</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card border-danger">
                                        <div class="card-body text-center">
                                            <i class="fas fa-cog fa-2x text-danger mb-2"></i>
                                            <h6>System Settings</h6>
                                            <p>Configure system preferences</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section id="troubleshooting" class="mb-5">
                            <h4>Troubleshooting</h4>
                            
                            <div class="accordion" id="troubleshootingAccordion">
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingOne">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                            Cannot Login
                                        </button>
                                    </h2>
                                    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#troubleshootingAccordion">
                                        <div class="accordion-body">
                                            <ul>
                                                <li>Check username and password spelling</li>
                                                <li>Ensure caps lock is off</li>
                                                <li>Contact admin for password reset</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingTwo">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                            Stock Not Updating
                                        </button>
                                    </h2>
                                    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#troubleshootingAccordion">
                                        <div class="accordion-body">
                                            <ul>
                                                <li>Refresh the page</li>
                                                <li>Check if order was successfully processed</li>
                                                <li>Verify admin permissions for stock updates</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="headingThree">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                                            Email Notifications Not Working
                                        </button>
                                    </h2>
                                    <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#troubleshootingAccordion">
                                        <div class="accordion-body">
                                            <ul>
                                                <li>Check email configuration in EmailUtil.java</li>
                                                <li>Verify SMTP settings</li>
                                                <li>Check spam folder</li>
                                                <li>Ensure valid email addresses</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <div class="alert alert-success">
                            <h5><i class="fas fa-phone"></i> Need More Help?</h5>
                            <p class="mb-0">Contact our support team:</p>
                            <ul class="mb-0">
                                <li>Email: support@pahanaedu.com</li>
                                <li>Phone: +94 123 456 789</li>
                                <li>Hours: Monday - Friday, 9 AM - 6 PM</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>