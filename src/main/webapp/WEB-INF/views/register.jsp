<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Register - Snacks Corner</title>
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

        /* Registration Section with Background */
        .registration-section {
            background: url('static/css/hero-bg.jpg') center/cover no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            position: relative;
        }

        .registration-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2));
            z-index: 1;
        }

        /* Registration Form Container */
        .registration-content {
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 100%;
            padding: 40px 35px;
            text-align: center;
            backdrop-filter: blur(10px);
            animation: fadeInUp 1s ease;
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

        .registration-content h2 {
            font-size: 2.5rem;
            color: #ff6347;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .registration-content > p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .registration-content a {
            color: #ff6347;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .registration-content a:hover {
            color: #e55342;
            text-decoration: underline;
        }

        /* Error Message */
        .error-message {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.95rem;
            border-left: 4px solid #e74c3c;
        }

        /* Form Styling with Two Columns */
        .registration-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 20px;
            text-align: left;
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            flex: 1;
        }

        .form-group.full-width {
            width: 100%;
        }

        .form-group label {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
        }

        .form-group input,
        .form-group select {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #ff6347;
            outline: none;
            background: rgba(255, 99, 71, 0.05);
            box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.1);
        }

        /* Password Group with Eye Icon */
        .form-group.password-group {
            position: relative;
        }

        .eye-icon {
            position: absolute;
            right: 15px;
            top: 38px;
            font-size: 1.2rem;
            color: #aaa;
            cursor: pointer;
            transition: color 0.3s ease;
            z-index: 10;
        }

        .eye-icon:hover {
            color: #ff6347;
        }

        /* Submit Button */
        .cta {
            padding: 15px 0;
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(255, 99, 71, 0.3);
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .cta:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(255, 99, 71, 0.4);
        }

        .cta:active {
            transform: translateY(-1px);
        }

        /* Footer */
        footer {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            text-align: center;
            padding: 40px 20px;
            margin-top: 0;
        }

        footer p {
            font-size: 1rem;
            font-weight: 500;
            opacity: 0.9;
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

            .registration-content {
                max-width: 95vw;
                padding: 30px 25px;
            }

            .registration-content h2 {
                font-size: 2rem;
            }

            .form-row {
                flex-direction: column;
                gap: 20px;
            }

            .eye-icon {
                top: 38px;
                right: 12px;
            }
        }

        @media (max-width: 480px) {
            .header-container {
                padding: 10px 15px;
            }

            .logo h1 {
                font-size: 1.2rem;
            }

            .registration-content {
                padding: 25px 20px;
                margin: 10px;
            }

            .registration-content h2 {
                font-size: 1.8rem;
            }

            .form-group input,
            .form-group select {
                padding: 10px 12px;
            }

            .cta {
                padding: 12px 0;
                font-size: 1rem;
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

    <section class="registration-section">
        <div class="registration-content">
            <h2>Create Your Account</h2>
            <c:if test="${not empty message}">
                <p class="error-message">${message}</p>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>

            <p>Join us and start enjoying the best snacks in town!</p>
            <form action="register" method="post" class="registration-form">
                <!-- Row 1: Name and Mobile Number -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="number">Mobile Number:</label>
                        <input type="text" id="number" name="number" required>
                    </div>
                </div>
                
                <!-- Row 2: Email and Gender -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender:</label>
                        <select id="gender" name="gender" required>
                            <option value="">Select Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                </div>
                
                <!-- Full Width: Address -->
                <div class="form-group full-width">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" required>
                </div>
                
                <!-- Row 3: City and State -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City:</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                    <div class="form-group">
                        <label for="state">State:</label>
                        <input type="text" id="state" name="state" required>
                    </div>
                </div>
                
                <!-- Row 4: Login ID and Password -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="loginId">Login ID:</label>
                        <input type="text" id="loginId" name="loginId" required>
                    </div>
                    <div class="form-group password-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                        <span class="eye-icon" id="togglePassword" onclick="togglePassword()">
                            👁️
                        </span>
                    </div>
                </div>
                
                <button type="submit" class="cta">Register Now</button>
            </form>
            <p style="margin-top: 20px;">Already have an account? <a href="<c:url value='/login'/>">Login here</a></p>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Snacks Corner | All Rights Reserved | Made with ❤️</p>
    </footer>

    <script>
        function togglePassword() {
            var passwordField = document.getElementById("password");
            var eyeIcon = document.getElementById("togglePassword");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                eyeIcon.innerHTML = "🙈";
            } else {
                passwordField.type = "password";
                eyeIcon.innerHTML = "👁️";
            }
        }

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

        // Enhanced form interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add focus effects to form inputs
            const inputs = document.querySelectorAll('input, select');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });

            // Form submission effect
            const form = document.querySelector('.registration-form');
            form.addEventListener('submit', function() {
                const submitBtn = this.querySelector('.cta');
                submitBtn.innerHTML = '⏳ Creating Account...';
                submitBtn.disabled = true;
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
