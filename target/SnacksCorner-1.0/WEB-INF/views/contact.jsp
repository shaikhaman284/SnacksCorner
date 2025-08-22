<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Contact Us | Snacks Corner</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="static/css/styles.css" rel="stylesheet">
    <script src="https://cdn.emailjs.com/dist/email.min.js"></script>
    <script>
        (function () {
            emailjs.init("UYyhcTba63VsuPggW"); // Replace with your EmailJS User ID
        })();
    </script>

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

        /* Contact Hero Section */
        .contact-hero {
            background: url('static/css/contact-bg.jpg') center/cover no-repeat;
            height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .contact-hero::before {
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

        .contact-hero h2 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.4);
            line-height: 1.2;
        }

        .contact-hero p {
            font-size: 1.3rem;
            opacity: 0.95;
            font-weight: 400;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }

        /* Contact Info Section */
        .contact-info {
            padding: 80px 30px;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            text-align: center;
        }

        .contact-info h2 {
            font-size: 3rem;
            color: #333;
            margin-bottom: 3rem;
            font-weight: 700;
            position: relative;
        }

        .contact-info h2::after {
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

        .info-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .info-card {
            background: white;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            text-decoration: none;
            color: inherit;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
            transition: left 0.4s ease;
        }

        .info-card:hover::before {
            left: 0;
        }

        .info-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 99, 71, 0.15);
            border-color: #ff6347;
        }

        .info-card img {
            width: 60px;
            height: 60px;
            margin-bottom: 20px;
            filter: drop-shadow(0 4px 8px rgba(255, 99, 71, 0.3));
        }

        .info-card h3 {
            font-size: 1.5rem;
            color: #ff6347;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .info-card p {
            color: #666;
            font-size: 1rem;
            line-height: 1.6;
            margin: 0;
        }

        /* Contact Form Section */
        .contact-form-section {
            padding: 80px 30px;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            text-align: center;
        }

        .contact-form-section h2 {
            font-size: 3rem;
            color: #333;
            margin-bottom: 3rem;
            font-weight: 700;
            position: relative;
        }

        .contact-form-section h2::after {
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

        .contact-form {
            max-width: 600px;
            margin: 0 auto;
            text-align: left;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            animation: slideInUp 1s ease;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 1rem;
        }

        .form-group label span {
            color: #ff6347;
            margin-left: 3px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #ff6347;
            outline: none;
            background: rgba(255, 99, 71, 0.05);
            box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.1);
            transform: translateY(-2px);
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(255, 99, 71, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(255, 99, 71, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .submit-btn.loading {
            background: linear-gradient(135deg, #bdc3c7, #95a5a6);
            cursor: not-allowed;
        }

        /* Map Section */
        .map {
            padding: 80px 30px;
            text-align: center;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
        }

        .map h2 {
            font-size: 3rem;
            color: #333;
            margin-bottom: 3rem;
            font-weight: 700;
            position: relative;
        }

        .map h2::after {
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

        .map-container {
            max-width: 1000px;
            margin: 0 auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            border: 4px solid #ff6347;
            animation: fadeIn 2s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .map-container iframe {
            width: 100%;
            height: 450px;
            border: none;
            filter: grayscale(20%) contrast(1.1);
            transition: filter 0.3s ease;
        }

        .map-container:hover iframe {
            filter: grayscale(0%) contrast(1);
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

        /* Success/Error Message Styles */
        .message {
            padding: 15px 20px;
            border-radius: 10px;
            margin: 20px 0;
            font-weight: 600;
            text-align: center;
            animation: slideDown 0.5s ease;
        }

        .message.success {
            background: rgba(46, 204, 113, 0.1);
            color: #27ae60;
            border-left: 4px solid #27ae60;
        }

        .message.error {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
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

            .contact-hero {
                height: 50vh;
            }

            .contact-hero h2 {
                font-size: 2.5rem;
            }

            .contact-hero p {
                font-size: 1.1rem;
            }

            .contact-info, .contact-form-section, .map {
                padding: 60px 20px;
            }

            .contact-info h2, .contact-form-section h2, .map h2 {
                font-size: 2.2rem;
            }

            .info-cards {
                grid-template-columns: 1fr;
                gap: 25px;
                padding: 0 10px;
            }

            .contact-form {
                padding: 30px 25px;
                margin: 0 10px;
            }

            .map-container iframe {
                height: 300px;
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

            .contact-hero {
                height: 40vh;
            }

            .contact-hero h2 {
                font-size: 2rem;
            }

            .contact-hero p {
                font-size: 1rem;
            }

            .contact-info, .contact-form-section, .map {
                padding: 40px 15px;
            }

            .contact-info h2, .contact-form-section h2, .map h2 {
                font-size: 1.8rem;
            }

            .info-card {
                padding: 30px 20px;
            }

            .contact-form {
                padding: 25px 20px;
                margin: 0 5px;
            }

            .form-group input,
            .form-group textarea {
                padding: 12px;
            }

            .submit-btn {
                padding: 12px;
                font-size: 1rem;
            }

            .map-container iframe {
                height: 250px;
            }

            footer {
                padding: 40px 20px 20px;
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

    <section class="contact-hero">
        <div class="hero-content">
            <h2>📞 Get in Touch</h2>
            <p>We'd love to hear from you and help with any questions!</p>
        </div>
    </section>

    <section class="contact-info">
        <h2>📋 Contact Information</h2>
        <div class="info-cards">
            <!-- Phone Card -->
            <a href="tel:+917249329343" class="info-card">
                <img src="<c:url value='/static/images/phone-icon.png'/>" alt="Phone" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                <div style="display:none; font-size: 3rem; margin-bottom: 20px;">📞</div>
                <h3>📞 Phone</h3>
                <p>+91 7249329343</p>
            </a>

            <!-- Email Card -->
            <a href="mailto:snackscorner@gmail.com" class="info-card">
                <img src="<c:url value='/static/images/email-icon.png'/>" alt="Email" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                <div style="display:none; font-size: 3rem; margin-bottom: 20px;">📧</div>
                <h3>📧 Email</h3>
                <p>snackscorner@gmail.com</p>
            </a>

            <!-- Address Card -->
            <a href="https://maps.google.com/?q=123+Snack+Street+Camp+Amravati" target="_blank" class="info-card">
                <img src="<c:url value='/static/images/location-icon.png'/>" alt="Location" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                <div style="display:none; font-size: 3rem; margin-bottom: 20px;">📍</div>
                <h3>📍 Address</h3>
                <p>123 Snack Street, Camp, Amravati</p>
            </a>
        </div>
    </section>

    <section class="contact-form-section">
        <h2>✉️ Send Us a Message</h2>
        <form class="contact-form" id="contact-form">
            <div id="messageContainer"></div>
            
            <div class="form-group">
                <label for="name">👤 Name<span>*</span></label>
                <input type="text" id="name" name="name" required placeholder="Enter your full name" />
            </div>
            
            <div class="form-group">
                <label for="email">📧 Email<span>*</span></label>
                <input type="email" id="email" name="email" required placeholder="Enter your email address" />
            </div>
            
            <div class="form-group">
                <label for="message">💬 Message<span>*</span></label>
                <textarea id="message" name="message" rows="5" required placeholder="Tell us how we can help you..."></textarea>
            </div>
            
            <button type="submit" class="submit-btn" id="submitBtn">
                🚀 Send Message
            </button>
        </form>
    </section>

    <section class="map">
        <h2>🗺️ Find Us Here</h2>
        <div class="map-container">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3806.927726648299!2d77.75638947485546!3d20.987772358106204!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bd6a2d15d81f4cd%3A0x703a9debc9500a6b!2sP.%20R.%20Pote%20Patil%20College%20of%20Engineering%20and%20Management!5e0!3m2!1sen!2sin!4v1690199124567!5m2!1sen!2sin"
                width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>Snacks Corner</h3>
                <p>Your favorite destination for delicious snacks and treats. We're here to serve you with the best quality snacks and exceptional customer service.</p>
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

        // Enhanced form submission with EmailJS
        const form = document.getElementById("contact-form");
        const submitBtn = document.getElementById("submitBtn");
        const messageContainer = document.getElementById("messageContainer");

        function showMessage(message, type) {
            messageContainer.innerHTML = `<div class="message ${type}">${message}</div>`;
            setTimeout(() => {
                messageContainer.innerHTML = '';
            }, 5000);
        }

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            // Show loading state
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '⏳ Sending...';
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;

            emailjs.sendForm("service_mhqufkc", "template_9dc938t", this)
                .then(function (response) {
                    showMessage("✅ Message sent successfully! We'll get back to you soon.", "success");
                    form.reset();
                    
                    // Add success animation
                    form.style.animation = 'slideInUp 0.5s ease';
                }, function (error) {
                    showMessage("❌ Failed to send message. Please try again or contact us directly.", "error");
                    console.error('EmailJS error:', error);
                })
                .finally(function() {
                    // Reset button state
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.classList.remove('loading');
                        submitBtn.disabled = false;
                    }, 1000);
                });
        });

        // Enhanced form interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add focus effects to form inputs
            const inputs = document.querySelectorAll('input, textarea');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });

            // Animate info cards on scroll
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.animation = 'fadeInUp 0.6s ease forwards';
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.info-card, .contact-form, .map-container').forEach(el => {
                observer.observe(el);
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
