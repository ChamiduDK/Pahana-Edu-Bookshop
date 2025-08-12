<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose>
    <c:when test="${not empty sessionScope.customer}">
        <!-- Customer is logged in, redirect to dashboard -->
        <jsp:forward page="/customer-dashboard.jsp" />
    </c:when>
    <c:otherwise>
        <!-- Show public home page -->
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Pahana Edu Bookshop - Leading Bookshop in Colombo City</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                :root {
                    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                    --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                }

                .hero-section {
                    background: var(--primary-gradient);
                    color: white;
                    padding: 120px 0;
                    position: relative;
                    overflow: hidden;
                }

                .hero-section::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="books" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><rect width="20" height="20" fill="none"/><rect x="2" y="4" width="3" height="12" fill="rgba(255,255,255,0.1)"/><rect x="6" y="2" width="3" height="14" fill="rgba(255,255,255,0.15)"/><rect x="10" y="6" width="3" height="10" fill="rgba(255,255,255,0.1)"/><rect x="14" y="3" width="3" height="13" fill="rgba(255,255,255,0.12)"/></pattern></defs><rect width="100" height="100" fill="url(%23books)"/></svg>') repeat;
                    opacity: 0.3;
                }

                .hero-content {
                    position: relative;
                    z-index: 2;
                }

                .feature-card {
                    border: none;
                    border-radius: 20px;
                    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
                    transition: all 0.4s ease;
                    overflow: hidden;
                    background: white;
                    height: 100%;
                }

                .feature-card:hover {
                    transform: translateY(-15px) scale(1.02);
                    box-shadow: 0 25px 50px rgba(0,0,0,0.2);
                }

                .feature-icon {
                    width: 90px;
                    height: 90px;
                    background: var(--primary-gradient);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 25px;
                    color: white;
                    font-size: 2.2rem;
                    transition: all 0.4s ease;
                    position: relative;
                    overflow: hidden;
                }

                .feature-icon::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: -100%;
                    width: 100%;
                    height: 100%;
                    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
                    transition: left 0.6s ease;
                }

                .feature-card:hover .feature-icon {
                    transform: scale(1.1) rotate(5deg);
                }

                .feature-card:hover .feature-icon::before {
                    left: 100%;
                }

                .sample-book {
                    border: none;
                    border-radius: 20px;
                    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                    transition: all 0.4s ease;
                    overflow: hidden;
                    background: white;
                }

                .sample-book:hover {
                    transform: translateY(-12px) rotateY(5deg);
                    box-shadow: 0 20px 40px rgba(0,0,0,0.2);
                }

                .book-cover {
                    height: 200px;
                    background: var(--primary-gradient);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: white;
                    position: relative;
                    overflow: hidden;
                }

                .book-cover::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.2) 50%, transparent 70%);
                    animation: shimmer 3s infinite;
                }

                @keyframes shimmer {
                    0% { transform: translateX(-100%); }
                    100% { transform: translateX(100%); }
                }

                .cta-section {
                    background: var(--success-gradient);
                    color: white;
                    padding: 100px 0;
                    text-align: center;
                    position: relative;
                    overflow: hidden;
                }

                .cta-section::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="50" r="1" fill="rgba(255,255,255,0.15)"/><circle cx="80" cy="30" r="1" fill="rgba(255,255,255,0.1)"/></svg>') repeat;
                    opacity: 0.6;
                }

                .login-card {
                    border: none;
                    border-radius: 25px;
                    box-shadow: 0 20px 40px rgba(0,0,0,0.15);
                    overflow: hidden;
                    backdrop-filter: blur(10px);
                }

                .login-form {
                    background: var(--primary-gradient);
                    color: white;
                    padding: 40px;
                    position: relative;
                }

                .login-form::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%);
                    animation: shimmer 4s infinite;
                }

                .stats-section {
                    background: #f8f9fa;
                    border-radius: 20px;
                    padding: 40px;
                    margin: 40px 0;
                }

                .animate-on-scroll {
                    opacity: 0;
                    transform: translateY(30px);
                    transition: all 0.6s ease;
                }

                .animate-on-scroll.animated {
                    opacity: 1;
                    transform: translateY(0);
                }

                .floating-shapes {
                    position: absolute;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                    z-index: 1;
                }

                .shape {
                    position: absolute;
                    background: rgba(255,255,255,0.1);
                    border-radius: 50%;
                    animation: float 6s ease-in-out infinite;
                }

                .shape:nth-child(1) {
                    width: 80px;
                    height: 80px;
                    top: 20%;
                    left: 10%;
                    animation-delay: 0s;
                }

                .shape:nth-child(2) {
                    width: 120px;
                    height: 120px;
                    top: 60%;
                    right: 10%;
                    animation-delay: 2s;
                }

                .shape:nth-child(3) {
                    width: 60px;
                    height: 60px;
                    top: 40%;
                    right: 30%;
                    animation-delay: 4s;
                }

                @keyframes float {
                    0%, 100% { transform: translateY(0px); }
                    50% { transform: translateY(-20px); }
                }
            </style>
        </head>
        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background: var(--primary-gradient); box-shadow: 0 2px 20px rgba(0,0,0,0.1);">
                <div class="container">
                    <a class="navbar-brand fw-bold" href="#home">
                        <i class="fas fa-graduation-cap me-2"></i>Pahana Edu Bookshop
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="#home"><i class="fas fa-home"></i> Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#books"><i class="fas fa-book"></i> Books</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#about"><i class="fas fa-info-circle"></i> About</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#contact"><i class="fas fa-phone"></i> Contact</a>
                            </li>
                            <li class="nav-item">
                                <button class="btn btn-outline-light ms-2" data-bs-toggle="modal" data-bs-target="#loginModal">
                                    <i class="fas fa-user"></i> Customer Login
                                </button>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                    <i class="fas fa-cog"></i> Admin
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <section id="home" class="hero-section">
                <div class="floating-shapes">
                    <div class="shape"></div>
                    <div class="shape"></div>
                    <div class="shape"></div>
                </div>
                <div class="container">
                    <div class="row align-items-center hero-content">
                        <div class="col-lg-8">
                            <div class="animate-on-scroll">
                                <h1 class="display-2 fw-bold mb-4" style="text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">
                                    Pahana Edu Bookshop
                                </h1>
                                <h2 class="h2 mb-4 text-warning">Leading Bookshop in Colombo City</h2>
                                <p class="lead mb-5" style="font-size: 1.3rem;">
                                    🎓 Discover knowledge, expand your horizons. From programming guides to literature classics, 
                                    we have the perfect book for every learner and reader in Sri Lanka.
                                </p>
                                <div class="d-flex flex-wrap gap-3 mb-4">
                                    <a href="#books" class="btn btn-light btn-lg px-5 py-3" style="border-radius: 50px;">
                                        <i class="fas fa-book-open"></i> Browse Books
                                    </a>
                                    <button class="btn btn-outline-light btn-lg px-5 py-3" data-bs-toggle="modal" data-bs-target="#loginModal" style="border-radius: 50px;">
                                        <i class="fas fa-user-circle"></i> Customer Login
                                    </button>
                                </div>
                                <div class="row text-center mt-5">
                                    <div class="col-3">
                                        <h3 class="fw-bold">1000+</h3>
                                        <p class="mb-0">Books</p>
                                    </div>
                                    <div class="col-3">
                                        <h3 class="fw-bold">500+</h3>
                                        <p class="mb-0">Customers</p>
                                    </div>
                                    <div class="col-3">
                                        <h3 class="fw-bold">50+</h3>
                                        <p class="mb-0">Categories</p>
                                    </div>
                                    <div class="col-3">
                                        <h3 class="fw-bold">24/7</h3>
                                        <p class="mb-0">Support</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="login-card animate-on-scroll">
                                <div class="login-form">
                                    <h4 class="mb-4 text-center">
                                        <i class="fas fa-sign-in-alt"></i> Quick Login
                                    </h4>
                                    <form id="quickLoginForm">
                                        <div class="mb-3">
                                            <label class="form-label">Account Number</label>
                                            <input type="text" class="form-control" id="quickAccountNumber" placeholder="Enter your account number" required>
                                        </div>
                                        <div class="mb-4">
                                            <label class="form-label">Phone Number</label>
                                            <input type="tel" class="form-control" id="quickPhoneNumber" placeholder="Enter your phone number" required>
                                        </div>
                                        <button type="submit" class="btn btn-light w-100 py-3" style="border-radius: 50px;">
                                            <i class="fas fa-sign-in-alt"></i> Login & Start Shopping
                                        </button>
                                    </form>
                                    <div class="text-center mt-4">
                                        <p class="mb-0">New customer? <a href="#contact" class="text-warning fw-bold">Contact us</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="py-5" style="padding: 100px 0 !important;">
                <div class="container">
                    <div class="row text-center mb-5">
                        <div class="col-12 animate-on-scroll">
                            <h2 class="display-4 fw-bold mb-4">Why Choose Pahana Edu?</h2>
                            <p class="lead text-muted" style="font-size: 1.2rem;">Your trusted partner in education and knowledge since 2010</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="feature-card text-center p-4 animate-on-scroll">
                                <div class="feature-icon">
                                    <i class="fas fa-shipping-fast"></i>
                                </div>
                                <h5 class="fw-bold mb-3">Fast Delivery</h5>
                                <p class="text-muted">Quick delivery across Colombo and suburbs. Same-day delivery available for urgent orders within the city.</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="feature-card text-center p-4 animate-on-scroll">
                                <div class="feature-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <h5 class="fw-bold mb-3">Quality Assurance</h5>
                                <p class="text-muted">Carefully curated collection of educational and reference books from trusted international and local publishers.</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="feature-card text-center p-4 animate-on-scroll">
                                <div class="feature-icon">
                                    <i class="fas fa-headset"></i>
                                </div>
                                <h5 class="fw-bold mb-3">Expert Support</h5>
                                <p class="text-muted">Our knowledgeable staff can help you find the perfect book for your academic and professional needs.</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="feature-card text-center p-4 animate-on-scroll">
                                <div class="feature-icon">
                                    <i class="fas fa-tags"></i>
                                </div>
                                <h5 class="fw-bold mb-3">Best Prices</h5>
                                <p class="text-muted">Competitive pricing with regular discounts and special offers for students and educational institutions.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Sample Books Section -->
            <section id="books" class="py-5 bg-light">
                <div class="container">
                    <div class="row mb-5">
                        <div class="col-12 text-center animate-on-scroll">
                            <h2 class="display-4 fw-bold mb-4">Featured Books</h2>
                            <p class="lead text-muted">Discover our most popular educational and reference books</p>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Programming Book -->
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card sample-book animate-on-scroll">
                                <div class="book-cover" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                    <div class="text-center">
                                        <i class="fas fa-laptop-code fa-4x mb-3"></i>
                                        <div class="h6">Programming</div>
                                    </div>
                                </div>
                                <div class="card-body text-center">
                                    <h5 class="card-title fw-bold">Java: The Complete Reference</h5>
                                    <p class="text-muted mb-2">by Herbert Schildt</p>
                                    <p class="card-text small mb-3">Comprehensive guide to Java programming with practical examples and real-world applications.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="h5 text-primary mb-0">LKR 3,500.00</span>
                                        <span class="badge bg-success">In Stock</span>
                                    </div>
                                    <button class="btn btn-primary w-100 mt-3" data-bs-toggle="modal" data-bs-target="#loginModal">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Database Book -->
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card sample-book animate-on-scroll">
                                <div class="book-cover" style="background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);">
                                    <div class="text-center">
                                        <i class="fas fa-database fa-4x mb-3 text-dark"></i>
                                        <div class="h6 text-dark">Database</div>
                                    </div>
                                </div>
                                <div class="card-body text-center">
                                    <h5 class="card-title fw-bold">Database System Concepts</h5>
                                    <p class="text-muted mb-2">by Abraham Silberschatz</p>
                                    <p class="card-text small mb-3">Essential principles of database design, implementation, and management systems.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="h5 text-primary mb-0">LKR 4,200.00</span>
                                        <span class="badge bg-warning">Low Stock</span>
                                    </div>
                                    <button class="btn btn-primary w-100 mt-3" data-bs-toggle="modal" data-bs-target="#loginModal">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Mathematics Book -->
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card sample-book animate-on-scroll">
                                <div class="book-cover" style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);">
                                    <div class="text-center">
                                        <i class="fas fa-calculator fa-4x mb-3 text-dark"></i>
                                        <div class="h6 text-dark">Mathematics</div>
                                    </div>
                                </div>
                                <div class="card-body text-center">
                                    <h5 class="card-title fw-bold">Calculus: Early Transcendentals</h5>
                                    <p class="text-muted mb-2">by James Stewart</p>
                                    <p class="card-text small mb-3">Comprehensive calculus textbook for engineering and science students.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="h5 text-primary mb-0">LKR 5,500.00</span>
                                        <span class="badge bg-success">In Stock</span>
                                    </div>
                                    <button class="btn btn-primary w-100 mt-3" data-bs-toggle="modal" data-bs-target="#loginModal">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-5 animate-on-scroll">
                        <button class="btn btn-primary btn-lg px-5 py-3" data-bs-toggle="modal" data-bs-target="#loginModal" style="border-radius: 50px;">
                            <i class="fas fa-sign-in-alt"></i> Login to View All Books
                        </button>
                    </div>
                </div>
            </section>

            <!-- Stats Section -->
            <section class="stats-section">
                <div class="container">
                    <div class="row text-center">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="animate-on-scroll">
                                <i class="fas fa-book fa-3x text-primary mb-3"></i>
                                <h3 class="fw-bold">1000+</h3>
                                <p class="text-muted">Educational Books</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="animate-on-scroll">
                                <i class="fas fa-users fa-3x text-success mb-3"></i>
                                <h3 class="fw-bold">500+</h3>
                                <p class="text-muted">Happy Students</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="animate-on-scroll">
                                <i class="fas fa-university fa-3x text-warning mb-3"></i>
                                <h3 class="fw-bold">50+</h3>
                                <p class="text-muted">Universities Served</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="animate-on-scroll">
                                <i class="fas fa-clock fa-3x text-info mb-3"></i>
                                <h3 class="fw-bold">15+</h3>
                                <p class="text-muted">Years of Excellence</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- About Section -->
            <section id="about" class="py-5">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <p class="mb-0">&copy; 2025 Pahana Edu Bookshop. All rights reserved. | Leading Educational Bookshop in Colombo</p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <a href="${pageContext.request.contextPath}/admin" class="text-light text-decoration-none">
                                <i class="fas fa-cog"></i> Admin Portal
                            </a>
                        </div>
                    </div>
                </div>
            </footer>

            <!-- Customer Login Modal -->
            <div class="modal fade" id="loginModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content login-card">
                        <div class="modal-header border-0" style="background: var(--primary-gradient); color: white;">
                            <h5 class="modal-title"><i class="fas fa-user-circle"></i> Customer Login Portal</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-0">
                            <div class="row g-0">
                                <div class="col-md-6">
                                    <div class="login-form">
                                        <h4 class="mb-4 text-center">
                                            <i class="fas fa-sign-in-alt"></i> Login to Your Account
                                        </h4>
                                        <form id="customerLoginForm">
                                            <div class="mb-3">
                                                <label class="form-label">
                                                    <i class="fas fa-id-card"></i> Account Number
                                                </label>
                                                <input type="text" class="form-control" id="accountNumber" 
                                                       placeholder="e.g., PED-20250101-1234" required>
                                                <div class="form-text text-light">Enter your unique account number</div>
                                            </div>
                                            <div class="mb-4">
                                                <label class="form-label">
                                                    <i class="fas fa-phone"></i> Phone Number
                                                </label>
                                                <input type="tel" class="form-control" id="phoneNumber" 
                                                       placeholder="e.g., 077-123-4567" required>
                                                <div class="form-text text-light">Enter your registered phone number</div>
                                            </div>
                                            <button type="submit" class="btn btn-light w-100 py-3" style="border-radius: 50px;" id="loginBtn">
                                                <i class="fas fa-sign-in-alt"></i> Login & Start Shopping
                                            </button>
                                        </form>
                                        <div class="text-center mt-4">
                                            <p class="mb-0 text-light">
                                                Forgot your account details? 
                                                <a href="tel:+94112345678" class="text-warning fw-bold text-decoration-none">
                                                    <i class="fas fa-phone"></i> Call us
                                                </a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 bg-light d-flex align-items-center">
                                    <div class="text-center w-100 p-4">
                                        <i class="fas fa-user-plus fa-5x text-primary mb-4"></i>
                                        <h5 class="mb-3">New Customer?</h5>
                                        <p class="text-muted mb-4">
                                            Create your account by visiting our store or calling us. 
                                            We'll set up your account instantly!
                                        </p>
                                        <div class="d-grid gap-2">
                                            <a href="tel:+94112345678" class="btn btn-primary" style="border-radius: 50px;">
                                                <i class="fas fa-phone"></i> Call +94 11 234 5678
                                            </a>
                                            <a href="#contact" class="btn btn-outline-primary" data-bs-dismiss="modal" style="border-radius: 50px;">
                                                <i class="fas fa-map-marker-alt"></i> Visit Our Store
                                            </a>
                                            <button class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#infoModal" data-bs-dismiss="modal" style="border-radius: 50px;">
                                                <i class="fas fa-info-circle"></i> How to Get Account
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Account Info Modal -->
            <div class="modal fade" id="infoModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fas fa-info-circle"></i> How to Get Your Account</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="text-center mb-4">
                                <i class="fas fa-user-plus fa-4x text-primary"></i>
                            </div>
                            <h6 class="fw-bold mb-3">3 Easy Ways to Create Your Account:</h6>
                            
                            <div class="d-flex align-items-start mb-3">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 30px; height: 30px; min-width: 30px;">1</div>
                                <div>
                                    <h6 class="mb-1">📞 Call Us</h6>
                                    <p class="mb-0 text-muted">Call +94 11 234 5678 and we'll create your account over the phone in 2 minutes</p>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start mb-3">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 30px; height: 30px; min-width: 30px;">2</div>
                                <div>
                                    <h6 class="mb-1">🏪 Visit Our Store</h6>
                                    <p class="mb-0 text-muted">Come to our store at 123 Main Street, Colombo 03 for instant account setup</p>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start mb-4">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 30px; height: 30px; min-width: 30px;">3</div>
                                <div>
                                    <h6 class="mb-1">📧 Email Us</h6>
                                    <p class="mb-0 text-muted">Send your details to info@pahanaedu.lk and we'll set up your account</p>
                                </div>
                            </div>
                            
                            <div class="alert alert-info">
                                <i class="fas fa-lightbulb"></i>
                                <strong>What you need:</strong> Just your name, phone number, and address. Account creation is FREE!
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a href="tel:+94112345678" class="btn btn-primary">
                                <i class="fas fa-phone"></i> Call Now
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Customer login functionality
                document.getElementById('customerLoginForm').addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    const accountNumber = document.getElementById('accountNumber').value.trim();
                    const phoneNumber = document.getElementById('phoneNumber').value.trim();
                    const loginBtn = document.getElementById('loginBtn');
                    
                    if (!accountNumber || !phoneNumber) {
                        showToast('Please enter both account number and phone number', 'warning');
                        return;
                    }
                    
                    // Show loading state
                    loginBtn.disabled = true;
                    loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging in...';
                    
                    // Submit login request
                    fetch('${pageContext.request.contextPath}/customer', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `action=login&accountNumber=${encodeURIComponent(accountNumber)}&telephone=${encodeURIComponent(phoneNumber)}`
                    })
                    .then(response => response.json())
                    .then(data => {
                        loginBtn.disabled = false;
                        loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Login & Start Shopping';
                        
                        if (data.success) {
                            showToast('Login successful! Redirecting to your dashboard...', 'success');
                            setTimeout(() => {
                                window.location.href = '${pageContext.request.contextPath}/customer-dashboard.jsp';
                            }, 1500);
                        } else {
                            showToast(data.message, 'danger');
                        }
                    })
                    .catch(error => {
                        console.error('Login error:', error);
                        loginBtn.disabled = false;
                        loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Login & Start Shopping';
                        showToast('Login failed. Please check your connection and try again.', 'danger');
                    });
                });

                // Smooth scrolling for navigation links
                document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                    anchor.addEventListener('click', function (e) {
                        e.preventDefault();
                        const target = document.querySelector(this.getAttribute('href'));
                        if (target) {
                            target.scrollIntoView({
                                behavior: 'smooth',
                                block: 'start'
                            });
                        }
                    });
                });

                // Scroll animations
                function handleScrollAnimations() {
                    const elements = document.querySelectorAll('.animate-on-scroll');
                    
                    elements.forEach(element => {
                        const elementTop = element.getBoundingClientRect().top;
                        const elementVisible = 150;
                        
                        if (elementTop < window.innerHeight - elementVisible) {
                            element.classList.add('animated');
                        }
                    });
                }

                // Initialize animations on scroll
                window.addEventListener('scroll', handleScrollAnimations);
                document.addEventListener('DOMContentLoaded', handleScrollAnimations);

                // Auto-focus on account number when modal opens
                document.getElementById('loginModal').addEventListener('shown.bs.modal', function () {
                    document.getElementById('accountNumber').focus();
                });

                // Format phone number as user types
                document.getElementById('phoneNumber').addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length >= 3) {
                        value = value.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
                    }
                    e.target.value = value;
                });

                // Utility functions
                function showToast(message, type) {
                    const toastHtml = `
                        <div class="toast align-items-center text-white bg-${type} border-0" role="alert" 
                             style="position: fixed; top: 100px; right: 20px; z-index: 1060; border-radius: 15px;">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-circle' : 'info-circle'}"></i> 
                                    ${message}
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    `;
                    
                    const toastContainer = document.createElement('div');
                    toastContainer.innerHTML = toastHtml;
                    const toastElement = toastContainer.firstElementChild;
                    
                    document.body.appendChild(toastElement);
                    const bsToast = new bootstrap.Toast(toastElement);
                    bsToast.show();
                    
                    toastElement.addEventListener('hidden.bs.toast', function () {
                        document.body.removeChild(toastElement);
                    });
                }

                // Demo functionality for sample books
                function showLoginPrompt() {
                    const modal = new bootstrap.Modal(document.getElementById('loginModal'));
                    modal.show();
                    showToast('Please login to add books to cart', 'info');
                }

                // Add click handlers to sample book buttons
                document.addEventListener('DOMContentLoaded', function() {
                    const sampleBookButtons = document.querySelectorAll('.sample-book button');
                    sampleBookButtons.forEach(button => {
                        button.addEventListener('click', showLoginPrompt);
                    });
                });

                // Enhanced typing effect for hero section
                function typeWriter(element, text, speed = 100) {
                    let i = 0;
                    element.innerHTML = '';
                    
                    function type() {
                        if (i < text.length) {
                            element.innerHTML += text.charAt(i);
                            i++;
                            setTimeout(type, speed);
                        }
                    }
                    type();
                }

                // Initialize page
                document.addEventListener('DOMContentLoaded', function() {
                    // Add some interactive elements
                    const heroTitle = document.querySelector('.hero-section h1');
                    if (heroTitle) {
                        heroTitle.style.opacity = '0';
                        setTimeout(() => {
                            heroTitle.style.opacity = '1';
                            heroTitle.style.animation = 'fadeIn 1s ease-in';
                        }, 500);
                    }
                });
            </script>
        </body>
        </html>
    </c:otherwise>
</c:choose>
                    