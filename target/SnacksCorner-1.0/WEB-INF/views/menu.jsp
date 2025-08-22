<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snackcorner.app.model.Snack" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Menu | Snacks Corner</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="static/css/styles.css" rel="stylesheet">
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Header Styles - Fixed */
        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(135deg, #ff6347 0%, #ff8a75 100%);
            padding: 15px 30px;
            color: #ffffff;
            box-shadow: 0 4px 20px rgba(255, 99, 71, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
            width: 100%;
        }

        /* Logo Section - Fixed */
        .logo {
            display: flex;
            align-items: center;
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            white-space: nowrap;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logo h1::before {
            content: '🍿';
            font-size: 1.3rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-3px); }
            60% { transform: translateY(-2px); }
        }

        /* Mobile Menu Toggle - Hidden on Desktop */
        .mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            padding: 8px;
            border-radius: 5px;
            transition: all 0.3s ease;
            margin-left: 15px;
        }

        .mobile-menu-toggle:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        /* Navigation - Fixed Layout */
        nav {
            display: flex;
            align-items: center;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        /* Navigation Links - Fixed Styling */
        .nav-links {
            list-style: none;
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .nav-links li {
            position: relative;
        }

        .nav-links li a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 8px 18px;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: block;
            position: relative;
            overflow: hidden;
        }

        .nav-links li a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            transition: left 0.3s ease;
            border-radius: 25px;
            z-index: -1;
        }

        .nav-links li a:hover::before {
            left: 0;
        }

        .nav-links li a:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        /* Profile Dropdown - Fixed */
        .profile-dropdown {
            position: relative;
        }

        .profile-icon {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .profile-icon:hover {
            border-color: rgba(255, 255, 255, 0.8);
            transform: scale(1.05);
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: calc(100% + 10px);
            background: white;
            color: #333;
            min-width: 200px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            z-index: 1001;
            border-radius: 12px;
            padding: 0;
            overflow: hidden;
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .dropdown-content.show {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

        .dropdown-content p {
            margin: 0;
            padding: 15px 15px 10px;
            font-weight: 600;
            color: #ff6347;
            border-bottom: 1px solid #f0f0f0;
            background: linear-gradient(135deg, #fff5f4 0%, #ffe8e6 100%);
            font-size: 0.9rem;
        }

        .dropdown-content a {
            display: block;
            padding: 12px 15px;
            font-size: 0.9rem;
            font-weight: 500;
            color: #555;
            text-decoration: none;
            transition: all 0.3s ease;
            border-bottom: 1px solid #f8f9fa;
        }

        .dropdown-content a:hover {
            background: #f8f9fa;
            color: #ff6347;
            padding-left: 20px;
        }

        .logout-btn {
            width: 100%;
            padding: 12px 15px;
            font-size: 0.9rem;
            font-weight: 600;
            color: white;
            border: none;
            cursor: pointer;
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            transition: all 0.3s ease;
            margin: 0;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
        }

        /* Auth Links - Fixed */
        .auth-links {
            list-style: none;
            display: flex;
            gap: 12px;
            margin: 0;
            padding: 0;
        }

        .auth-links li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            padding: 8px 20px;
            border-radius: 25px;
            border: 2px solid rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            background: transparent;
            display: block;
        }

        .auth-links li a:hover {
            background: white;
            color: #ff6347;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,255,255,0.3);
        }

        /* Hero Section - Menu Page Specific */
        .hero {
            background: url('static/css/menu-bg.jpg') center/cover no-repeat;
            height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.1));
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            animation: fadeInUp 1.2s ease;
            padding: 0 20px;
            max-width: 800px;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero h2 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.4);
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.3rem;
            opacity: 0.95;
            font-weight: 400;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        /* Menu Section */
        .services {
            padding: 80px 30px;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            min-height: 60vh;
        }

        .services h2 {
            font-size: 3rem;
            color: #333;
            margin-bottom: 3rem;
            font-weight: 700;
            text-align: center;
            position: relative;
        }

        .services h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
            border-radius: 2px;
        }

        /* Cards Grid Layout */
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Individual Card Styling */
        .card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            border: 2px solid transparent;
            position: relative;
            animation: fadeInCard 0.6s ease forwards;
            opacity: 0;
        }

        @keyframes fadeInCard {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 99, 71, 0.15);
            border-color: #ff6347;
        }

        /* Card Image */
        .card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .card:hover img {
            transform: scale(1.1);
        }

        /* Card Content */
        .card h3 {
            font-size: 1.5rem;
            margin: 20px 0 10px;
            font-weight: 600;
            color: #333;
            padding: 0 20px;
        }

        .card p {
            color: #666;
            margin: 8px 0;
            padding: 0 20px;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .card p:last-of-type {
            margin-bottom: 20px;
        }

        .card strong {
            color: #ff6347;
            font-weight: 600;
        }

        /* Price Highlight */
        .card p:nth-of-type(2) {
            font-size: 1.1rem;
            font-weight: 600;
            color: #ff6347;
        }

        /* Category Badge */
        .card p:nth-of-type(3) {
            background: rgba(255, 99, 71, 0.1);
            color: #ff6347;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
            margin: 10px 20px 15px;
            display: inline-block;
            width: auto;
        }

        /* Form and Button Container */
        .card form,
        .card > a {
            padding: 0 20px 20px;
            margin: 0;
        }

        /* Button Styling */
        .btn {
            display: inline-block;
            padding: 12px 25px;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 99, 71, 0.3);
            width: 100%;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 99, 71, 0.4);
        }

        .btn:active {
            transform: translateY(-1px);
        }

        /* Loading state for buttons */
        .btn.loading {
            background: linear-gradient(135deg, #bdc3c7, #95a5a6);
            cursor: not-allowed;
        }

        /* No Snacks Message */
        .no-snacks {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .no-snacks h3 {
            font-size: 2rem;
            color: #ff6347;
            margin-bottom: 1rem;
        }

        .no-snacks p {
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        /* Enhanced Footer */
        footer {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 60px 30px 30px;
            margin-top: 0;
            position: relative;
            overflow: hidden;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75, #ff6347);
            animation: gradientShift 3s ease infinite;
        }

        @keyframes gradientShift {
            0%, 100% { transform: translateX(-100%); }
            50% { transform: translateX(100%); }
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 40px;
            position: relative;
            z-index: 2;
        }

        .footer-section h3 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #ff6347;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-section h3::before {
            content: '🍿';
            font-size: 1.2rem;
        }

        .footer-section p {
            font-size: 1rem;
            line-height: 1.7;
            color: #bdc3c7;
            margin-bottom: 20px;
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: rgba(255, 99, 71, 0.1);
            border: 2px solid rgba(255, 99, 71, 0.3);
            border-radius: 50%;
            color: #ff6347;
            text-decoration: none;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: #ff6347;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 99, 71, 0.4);
        }

        .footer-bottom {
            border-top: 1px solid #34495e;
            padding: 25px 0 0;
            text-align: center;
            margin-top: 40px;
        }

        .footer-bottom p {
            font-size: 0.95rem;
            color: #bdc3c7;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .heart {
            color: #ff6347;
            animation: heartbeat 1.5s ease-in-out infinite;
        }

        @keyframes heartbeat {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: block;
            }

            .header-container {
                padding: 12px 20px;
                position: relative;
            }

            .logo {
                width: 100%;
                justify-content: space-between;
            }

            .logo h1 {
                font-size: 1.4rem;
            }

            nav {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: linear-gradient(135deg, #ff6347, #ff8a75);
                z-index: 999;
                display: none;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            }

            nav.show {
                display: block;
                animation: slideDown 0.3s ease;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .nav-right {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
                width: 100%;
            }

            .nav-links {
                flex-direction: column;
                gap: 5px;
                width: 100%;
                margin-bottom: 15px;
            }

            .nav-links li {
                width: 100%;
            }

            .nav-links li a {
                display: block;
                padding: 12px 15px;
                text-align: center;
                width: 100%;
                border-radius: 8px;
                margin-bottom: 5px;
            }

            .auth-links {
                flex-direction: column;
                gap: 8px;
                width: 100%;
            }

            .auth-links li {
                width: 100%;
            }

            .auth-links li a {
                display: block;
                text-align: center;
                width: 100%;
                border-radius: 8px;
            }

            .hero h2 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .services {
                padding: 60px 20px;
            }

            .services h2 {
                font-size: 2.2rem;
            }

            .cards {
                grid-template-columns: 1fr;
                gap: 25px;
                padding: 0 10px;
            }

            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
                gap: 30px;
            }

            .social-links {
                justify-content: center;
            }

            .footer-bottom p {
                flex-direction: column;
                gap: 5px;
            }
        }

        @media (max-width: 480px) {
            .header-container {
                padding: 10px 15px;
            }

            .logo h1 {
                font-size: 1.2rem;
            }

            .hero {
                height: 50vh;
            }

            .hero h2 {
                font-size: 2rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .services {
                padding: 40px 15px;
            }

            .services h2 {
                font-size: 1.8rem;
            }

            .cards {
                grid-template-columns: 1fr;
                gap: 20px;
                padding: 0 5px;
            }

            .card {
                margin: 0 5px;
            }

            .card img {
                height: 200px;
            }

            footer {
                padding: 40px 20px 20px;
            }
        }

        /* Card stagger animation */
        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }
        .card:nth-child(5) { animation-delay: 0.5s; }
        .card:nth-child(6) { animation-delay: 0.6s; }
    </style>
</head>

<body>
    <header>
        <div class="header-container">
            <jsp:include page="navbar.jsp" />
        </div>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h2>🍽️ Our Menu</h2>
            <p>Discover the tasty variety of snacks we offer!</p>
        </div>
    </section>

    <section class="services">
        <h2>🍿 Delicious Snacks</h2>
        <div class="cards">
            <c:choose>
                <c:when test="${not empty snacks}">
                    <c:forEach var="snack" items="${snacks}" varStatus="status">
                        <div class="card">
                            <img src="<c:url value='${snack.imagePath}'/>" alt="${snack.name}" loading="lazy">
                            <h3>${snack.name}</h3>
                            <p>${snack.description}</p>
                            <p><strong>💰 Price:</strong> $${snack.price}</p>
                            <p><strong>📂 Category:</strong> ${snack.category}</p>
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser}">
                                    <form action="<c:url value='/order'/>" method="get" class="order-form">
                                        <input type="hidden" name="snackId" value="${snack.snackid}">
                                        <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
                                        <button type="submit" class="btn btn-primary">🛒 Order Now</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <a href="<c:url value='/register'/>" class="btn btn-primary">🔐 Login to Order</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-snacks">
                        <h3>🍿 No Snacks Available</h3>
                        <p>We're preparing something delicious for you. Please check back later!</p>
                        <a href="<c:url value='/contact'/>" class="btn btn-primary">Contact Us</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>Snacks Corner</h3>
                <p>Your favorite destination for delicious snacks and treats. Fresh, tasty, and made with love!</p>
                <div class="social-links">
                    <a href="#" aria-label="Facebook">📘</a>
                    <a href="#" aria-label="Twitter">🐦</a>
                    <a href="#" aria-label="Instagram">📷</a>
                    <a href="#" aria-label="YouTube">📺</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 Snacks Corner | All Rights Reserved | Made with <span class="heart">❤️</span> for Snack Lovers</p>
        </div>
    </footer>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById("profileMenu");
            if (dropdown) {
                dropdown.classList.toggle("show");
            }
        }

        function toggleMobileMenu() {
            const nav = document.querySelector('nav');
            nav.classList.toggle('show');
        }

        // Close dropdowns when clicking outside
        window.onclick = function (event) {
            // Close profile dropdown
            if (!event.target.matches('.profile-icon')) {
                const dropdowns = document.getElementsByClassName("dropdown-content");
                for (let i = 0; i < dropdowns.length; i++) {
                    const openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }

            // Close mobile menu when clicking outside
            const nav = document.querySelector('nav');
            const mobileToggle = document.querySelector('.mobile-menu-toggle');
            if (nav && mobileToggle && !nav.contains(event.target) && !mobileToggle.contains(event.target)) {
                nav.classList.remove('show');
            }
        }

        // Enhanced interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Animate cards on load
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                }, index * 100);
            });

            // Add loading state to order buttons
            const orderForms = document.querySelectorAll('.order-form');
            orderForms.forEach(form => {
                form.addEventListener('submit', function() {
                    const button = this.querySelector('.btn');
                    const originalText = button.innerHTML;
                    button.innerHTML = '⏳ Processing...';
                    button.classList.add('loading');
                    button.disabled = true;
                    
                    // Re-enable after 3 seconds if still on page
                    setTimeout(() => {
                        button.innerHTML = originalText;
                        button.classList.remove('loading');
                        button.disabled = false;
                    }, 3000);
                });
            });

            // Intersection Observer for scroll animations
            if ('IntersectionObserver' in window) {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.style.animation = 'fadeInCard 0.6s ease forwards';
                        }
                    });
                }, { threshold: 0.1 });

                cards.forEach(card => {
                    observer.observe(card);
                });
            }
        });

        // Keyboard navigation
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                // Close mobile menu
                const nav = document.querySelector('nav');
                if (nav && nav.classList.contains('show')) {
                    nav.classList.remove('show');
                }
                
                // Close dropdown
                const dropdown = document.getElementById("profileMenu");
                if (dropdown && dropdown.classList.contains('show')) {
                    dropdown.classList.remove('show');
                }
            }
        });

        // Search functionality (if needed in future)
        function filterSnacks(category) {
            const cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                const categoryText = card.querySelector('p:nth-of-type(3)').textContent;
                if (category === 'all' || categoryText.toLowerCase().includes(category.toLowerCase())) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>

</body>
</html>
