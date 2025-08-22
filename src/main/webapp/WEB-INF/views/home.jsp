<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Snacks Corner - Delicious Snacks & Treats</title>
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


        /* Hero Section - Fixed with Background */
        .hero {
            background: url('static/css/hero-bg.jpg') center/cover no-repeat;
            height: 100vh;
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
            margin-bottom: 1.5rem;
            font-weight: 700;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.3);
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 2.5rem;
            opacity: 0.95;
            font-weight: 400;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
        }

        .cta {
            display: inline-block;
            background: white;
            color: #ff6347;
            padding: 18px 40px;
            text-decoration: none;
            font-weight: 700;
            border-radius: 50px;
            transition: all 0.4s ease;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            font-size: 1.1rem;
            position: relative;
            overflow: hidden;
        }

        .cta::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,99,71,0.1), transparent);
            transition: left 0.6s ease;
        }

        .cta:hover::before {
            left: 100%;
        }

        .cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.4);
        }

        /* About Section */
        .about {
            padding: 80px 50px;
            text-align: center;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
        }

        .about h2 {
            font-size: 3rem;
            color: #333;
            margin-bottom: 2rem;
            font-weight: 700;
            position: relative;
        }

        .about h2::after {
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

        .about p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto;
            color: #666;
            line-height: 1.8;
            font-weight: 400;
        }

        /* Services Section */
        .services {
            padding: 80px 50px;
            text-align: center;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        }

        .services h2 {
            font-size: 3rem;
            color: #333;
            margin-bottom: 3rem;
            font-weight: 700;
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

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 2px solid transparent;
            opacity: 1;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(255, 99, 71, 0.2);
            border-color: #ff6347;
        }

        .card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .card:hover img {
            transform: scale(1.05);
        }

        .card h3 {
            font-size: 1.4rem;
            margin: 15px 0 8px;
            font-weight: 600;
            color: #333;
            padding: 0 20px;
        }

        .card p {
            color: #666;
            margin: 8px 0;
            padding: 0 20px;
            line-height: 1.5;
            font-size: 0.95rem;
        }

        .card p:last-of-type {
            margin-bottom: 20px;
        }

        .card strong {
            color: #ff6347;
            font-weight: 600;
        }

        .card form,
        .card > a {
            padding: 0 20px 20px;
            margin: 0;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            font-size: 0.95rem;
            font-weight: 600;
            color: white;
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 99, 71, 0.3);
            width: 100%;
            text-align: center;
        }

        .btn:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 99, 71, 0.4);
        }

/* Enhanced Footer */
footer {
    background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
    color: white;
    margin-top: 80px;
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
    padding: 60px 30px 30px;
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

.footer-about p {
    font-size: 1rem;
    line-height: 1.7;
    color: #bdc3c7;
    margin-bottom: 20px;
}

.footer-links h4 {
    font-size: 1.2rem;
    font-weight: 600;
    margin-bottom: 15px;
    color: white;
}

.footer-links ul {
    list-style: none;
    padding: 0;
}

.footer-links ul li {
    margin-bottom: 8px;
}

.footer-links ul li a {
    color: #bdc3c7;
    text-decoration: none;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
}

.footer-links ul li a::before {
    content: '→';
    opacity: 0;
    transform: translateX(-10px);
    transition: all 0.3s ease;
}

.footer-links ul li a:hover {
    color: #ff6347;
    padding-left: 15px;
}

.footer-links ul li a:hover::before {
    opacity: 1;
    transform: translateX(0);
}

.footer-contact h4 {
    font-size: 1.2rem;
    font-weight: 600;
    margin-bottom: 15px;
    color: white;
}

.contact-item {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
    color: #bdc3c7;
    font-size: 0.95rem;
}

.contact-icon {
    font-size: 1.1rem;
    width: 20px;
    text-align: center;
    color: #ff6347;
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
    padding: 25px 30px;
    text-align: center;
    background: rgba(0, 0, 0, 0.2);
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

.footer-bottom .heart {
    color: #ff6347;
    animation: heartbeat 1.5s ease-in-out infinite;
}

@keyframes heartbeat {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
}

/* Mobile Footer Responsive */
@media (max-width: 768px) {
    .footer-content {
        grid-template-columns: 1fr;
        padding: 40px 20px 20px;
        gap: 30px;
        text-align: center;
    }
    
    .footer-section h3 {
        justify-content: center;
    }
    
    .contact-item {
        justify-content: center;
    }
    
    .social-links {
        justify-content: center;
    }
    
    .footer-bottom {
        padding: 20px;
    }
    
    .footer-bottom p {
        font-size: 0.9rem;
        flex-direction: column;
        gap: 5px;
    }
}

@media (max-width: 480px) {
    .footer-content {
        padding: 30px 15px 15px;
    }
    
    .footer-section h3 {
        font-size: 1.3rem;
    }
    
    .social-links a {
        width: 35px;
        height: 35px;
        font-size: 1.1rem;
    }
}


        /* Mobile Responsive - Fixed */
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

            .profile-dropdown .dropdown-content {
                right: 10px;
                min-width: 180px;
            }

            .hero h2 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .about, .services {
                padding: 50px 25px;
            }

            .about h2, .services h2 {
                font-size: 2.2rem;
            }

            .cards {
                grid-template-columns: 1fr;
                gap: 25px;
                padding: 0 15px;
            }
        }

        @media (max-width: 480px) {
            .header-container {
                padding: 10px 15px;
            }

            .logo h1 {
                font-size: 1.2rem;
            }

            .hero h2 {
                font-size: 2rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .cta {
                padding: 15px 30px;
                font-size: 1rem;
            }

            .about h2, .services h2 {
                font-size: 1.8rem;
            }

            .about, .services {
                padding: 40px 20px;
            }

            .cards {
                padding: 0 10px;
            }
        }
    </style>
</head>

<body>
    <header>
        <div class="header-container">
            <jsp:include page="navbar.jsp" />
        </div>
    </header>

    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
    
    <section class="hero">
        <div class="hero-content">
            <h2>Welcome to Snacks Corner!</h2>
            <p>Your one-stop destination for delicious snacks and treats.</p>
            <a href="<c:url value='/menu'/>" class="cta">Explore Now</a>
        </div>
    </section>

    <section class="about">
        <h2>About Us</h2>
        <p>At Snacks Corner, we serve fresh and tasty snacks that satisfy your cravings. From crispy fries to savory bites, we have everything to make your snack time perfect!</p>
    </section>

    <section class="services">
        <h2>Featured Snacks</h2>
        <div class="cards">
            <c:forEach var="snack" items="${snacks}" varStatus="status">
                <c:if test="${status.index < 3}">
                    <div class="card">
                        <img src="<c:url value='${snack.imagePath}'/>" alt="${snack.name}">
                        <h3>${snack.name}</h3>
                        <p>${snack.description}</p>
                        <p><strong>Price:</strong> $${snack.price}</p>
                        <p><strong>Category:</strong> ${snack.category}</p>
                        <c:choose>
                            <c:when test="${not empty sessionScope.loggedInUser}">
                                <form action="<c:url value='/order'/>" method="get">
                                    <input type="hidden" name="snackId" value="${snack.snackid}">
                                    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
                                    <button type="submit" class="btn btn-primary">Order Now</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/register'/>" class="btn btn-primary">Login to Buy</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </section>

    <footer>
    <div class="footer-content">
        <div class="footer-section footer-about">
            <h3>Snacks Corner</h3>
            <p>Your favorite destination for delicious snacks and treats. We serve fresh, tasty snacks that satisfy your cravings and bring joy to your snack time.</p>
            <div class="social-links">
                <a href="#" aria-label="Facebook">📘</a>
                <a href="#" aria-label="Twitter">🐦</a>
                <a href="#" aria-label="Instagram">📷</a>
                <a href="#" aria-label="YouTube">📺</a>
            </div>
        </div>
        
        <div class="footer-section footer-links">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="<c:url value='/home'/>">Home</a></li>
                <li><a href="<c:url value='/menu'/>">Our Menu</a></li>
                <li><a href="<c:url value='/contact'/>">Contact Us</a></li>
                <c:if test="${empty sessionScope.loggedInUser}">
                    <li><a href="<c:url value='/register'/>">Join Us</a></li>
                    <li><a href="<c:url value='/login'/>">Sign In</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.loggedInUser}">
                    <li><a href="<c:url value='/myprofile'/>?userId=${sessionScope.loggedInUser.userid}">My Profile</a></li>
                    <li><a href="<c:url value='/myorder'/>?userId=${sessionScope.loggedInUser.userid}">My Orders</a></li>
                </c:if>
            </ul>
        </div>
        
        <div class="footer-section footer-contact">
            <h4>Get in Touch</h4>
            <div class="contact-item">
                <span class="contact-icon">📧</span>
                <span>info@snackscorner.com</span>
            </div>
            <div class="contact-item">
                <span class="contact-icon">📞</span>
                <span>1-800-SNACKS</span>
            </div>
            <div class="contact-item">
                <span class="contact-icon">📍</span>
                <span>123 Snack Street, Food City</span>
            </div>
            <div class="contact-item">
                <span class="contact-icon">⏰</span>
                <span>Open Daily: 9:00 AM - 9:00 PM</span>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>
            &copy; 2024 Snacks Corner | All Rights Reserved | Made with 
            <span class="heart">❤️</span> 
            for Snack Lovers
        </p>
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
            // Smooth scroll for CTA button
            const ctaButton = document.querySelector('.cta');
            if (ctaButton) {
                ctaButton.addEventListener('click', function(e) {
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = 'scale(1)';
                    }, 150);
                });
            }

            // Add loading effect for cards
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            });
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
    </script>

</body>

</html>
