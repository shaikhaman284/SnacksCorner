<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Profile | Snacks Corner</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
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

        /* Main Container */
        .containerM {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 30px;
            animation: fadeInUp 1s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
        }

        .page-header h2 {
            color: #ff6347;
            font-size: 2.8rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .page-header h2::before {
            content: '👤';
            font-size: 2.5rem;
        }

        .page-header p {
            color: #666;
            font-size: 1.1rem;
            margin-top: 10px;
        }

        /* Messages */
        .message {
            margin-bottom: 30px;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 500;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            animation: slideInDown 0.5s ease;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .alert-warning {
            background: rgba(255, 193, 7, 0.1);
            color: #856404;
            border-left: 4px solid #ffc107;
        }

        /* Profile Card */
        .cardM {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            border: 2px solid transparent;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .cardM::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
            transition: left 0.4s ease;
        }

        .cardM:hover::before {
            left: 0;
        }

        .cardM:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 50px rgba(255, 99, 71, 0.15);
            border-color: #ff6347;
        }

        .profile-card {
            padding: 40px;
        }

        .profile-card h5 {
            font-size: 1.8rem;
            color: #ff6347;
            font-weight: 700;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-card h5::before {
            content: '✏️';
            font-size: 1.5rem;
        }

        /* Form Styling */
        .profile-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .form-field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-field.full-width {
            grid-column: 1 / -1;
        }

        .form-field label {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-field input,
        .form-field select {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 14px 15px;
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
        }

        .form-field input:focus,
        .form-field select:focus {
            border-color: #ff6347;
            outline: none;
            background: rgba(255, 99, 71, 0.05);
            box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.1);
            transform: translateY(-2px);
        }

        /* Password Field with Eye Icon */
        .password-field {
            position: relative;
        }

        .password-field input {
            padding-right: 45px;
        }

        .eye-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            cursor: pointer;
            transition: color 0.3s ease;
            font-size: 1.1rem;
        }

        .eye-icon:hover {
            color: #ff6347;
        }

        /* Submit Button */
        .btn-edit {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 15px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(255, 99, 71, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            width: 100%;
            max-width: 300px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-edit::before {
            content: '💾';
        }

        .btn-edit::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn-edit:hover::after {
            left: 100%;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(255, 99, 71, 0.4);
        }

        .btn-edit:active {
            transform: translateY(-1px);
        }

        /* Orders Section */
        .orders-section h3 {
            font-size: 2.2rem;
            color: #333;
            margin-bottom: 30px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .orders-section h3::before {
            content: '📦';
            font-size: 2rem;
        }

        /* Order Cards */
        .order-card {
            padding: 30px;
            margin-bottom: 20px;
            animation: slideInLeft 0.6s ease;
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .order-card h5 {
            font-size: 1.4rem;
            color: #ff6347;
            font-weight: 700;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .order-card h5::before {
            content: '🧾';
        }

        .order-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            font-size: 1rem;
            color: #666;
        }

        .order-info:last-child {
            border-bottom: none;
        }

        .order-info strong {
            color: #333;
            font-weight: 600;
            min-width: 100px;
        }

        /* Status Badge */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .bg-success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .bg-success::before {
            content: '✅';
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .empty-state-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
        }

        .empty-state h4 {
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .empty-state p {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 25px;
        }

        .empty-state .btn {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .empty-state .btn::before {
            content: '🛒';
        }

        .empty-state .btn:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 99, 71, 0.4);
            color: white;
        }

        /* Enhanced Footer */
        footer {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 60px 30px 30px;
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
            text-align: center;
            position: relative;
            z-index: 2;
        }

        .footer-content h3 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #ff6347;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .footer-content h3::before {
            content: '🍿';
            font-size: 1.2rem;
        }

        .footer-content p {
            font-size: 1rem;
            line-height: 1.7;
            color: #bdc3c7;
            margin-bottom: 20px;
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

            .containerM {
                margin: 20px auto;
                padding: 0 20px;
            }

            .page-header {
                padding: 30px 20px;
            }

            .page-header h2 {
                font-size: 2.2rem;
                flex-direction: column;
                gap: 10px;
            }

            .profile-form {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .profile-card {
                padding: 30px 20px;
            }

            .btn-edit {
                max-width: none;
                width: 100%;
            }

            .orders-section h3 {
                font-size: 1.8rem;
            }

            .order-card {
                padding: 25px 20px;
            }

            .order-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .order-info strong {
                min-width: auto;
            }

            .empty-state {
                padding: 40px 20px;
            }

            footer {
                padding: 40px 20px 20px;
            }
        }

        @media (max-width: 480px) {
            .header-container {
                padding: 10px 15px;
            }

            .logo h1 {
                font-size: 1.2rem;
            }

            .containerM {
                padding: 0 15px;
            }

            .page-header {
                padding: 25px 15px;
            }

            .page-header h2 {
                font-size: 2rem;
            }

            .profile-card {
                padding: 25px 15px;
            }

            .form-field input,
            .form-field select {
                padding: 12px 12px;
            }

            .btn-edit {
                padding: 12px 25px;
                font-size: 1rem;
            }

            .order-card {
                padding: 20px 15px;
            }

            .empty-state {
                padding: 30px 15px;
            }

            .empty-state-icon {
                font-size: 3rem;
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

    <div class="containerM">
        <div class="page-header">
            <h2>My Profile</h2>
            <p>Manage your account information and view your order history</p>
        </div>

        <!-- Flash Message Display -->
        <div class="message">
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ✅ ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ❌ ${error}
                </div>
            </c:if>
        </div>

        <!-- Profile Card -->
        <div class="cardM profile-card">
            <h5>Profile Details</h5>
            
            <!-- Profile Update Form -->
            <form action="updateProfile" method="post">
                <input type="hidden" name="userId" value="${customer.userid}">
                <input type="hidden" name="id" value="${sessionScope.loggedInUser.userid}">
                
                <div class="profile-form">
                    <div class="form-field">
                        <label>👤 Name:</label>
                        <input type="text" name="name" value="${customer.name}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>📧 Email:</label>
                        <input type="email" name="email" value="${customer.email}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>📞 Phone:</label>
                        <input type="text" name="number" value="${customer.number}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>⚧️ Gender:</label>
                        <select name="gender" required>
                            <option value="male" ${customer.gender == 'male' ? 'selected' : ''}>Male</option>
                            <option value="female" ${customer.gender == 'female' ? 'selected' : ''}>Female</option>
                            <option value="other" ${customer.gender == 'other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    
                    <div class="form-field full-width">
                        <label>🏠 Address:</label>
                        <input type="text" name="address" value="${customer.address}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>🏙️ City:</label>
                        <input type="text" name="city" value="${customer.city}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>🗺️ State:</label>
                        <input type="text" name="state" value="${customer.state}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>🆔 Login ID:</label>
                        <input type="text" name="loginId" value="${customer.loginId}" required>
                    </div>
                    
                    <div class="form-field">
                        <label>🔒 Password:</label>
                        <div class="password-field">
                            <input id="password" type="password" name="password" value="${customer.password}" required>
                            <i class="fas fa-eye eye-icon" id="togglePassword" onclick="togglePassword()"></i>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn-edit">Update Profile</button>
            </form>
        </div>

        <!-- Orders Section -->
        <div class="orders-section">
            <h3>Previous Orders</h3>
            
            <c:if test="${not empty orders}">
                <c:forEach var="order" items="${orders}" varStatus="status">
                    <div class="cardM order-card">
                        <h5>Order #${order.orderId}</h5>
                        
                        <div class="order-info">
                            <strong>📅 Date:</strong> ${order.orderDate}
                        </div>
                        
                        <div class="order-info">
                            <strong>🍿 Snack:</strong> ${order.snack.name}
                        </div>
                        
                        <div class="order-info">
                            <strong>💰 Amount:</strong> ₹${order.amount}
                        </div>
                        
                        <div class="order-info">
                            <strong>📊 Status:</strong> 
                            <span class="badge bg-success">${order.status}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            
            <c:if test="${empty orders}">
                <div class="empty-state">
                    <div class="empty-state-icon">📦</div>
                    <h4>No Previous Orders</h4>
                    <p>You haven't placed any orders yet. Start exploring our delicious snacks!</p>
                    <a href="<c:url value='/menu'/>" class="btn">Start Shopping</a>
                </div>
            </c:if>
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <h3>Snacks Corner</h3>
            <p>&copy; 2024 Snacks Corner | All Rights Reserved | Made with ❤️ for Snack Lovers</p>
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

        // Password toggle functionality
        function togglePassword() {
            const passwordField = document.getElementById("password");
            const eyeIcon = document.getElementById("togglePassword");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                eyeIcon.classList.remove("fa-eye");
                eyeIcon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                eyeIcon.classList.remove("fa-eye-slash");
                eyeIcon.classList.add("fa-eye");
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
            const form = document.querySelector('form');
            form.addEventListener('submit', function() {
                const submitBtn = this.querySelector('.btn-edit');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '⏳ Updating...';
                submitBtn.disabled = true;
                
                // Re-enable after 3 seconds if still on page
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }, 3000);
            });

            // Animate order cards on load
            const orderCards = document.querySelectorAll('.order-card');
            orderCards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateX(0)';
                }, index * 150);
            });

            // Add hover effects to order info items
            const orderInfoItems = document.querySelectorAll('.order-info');
            orderInfoItems.forEach(item => {
                item.addEventListener('mouseenter', function() {
                    this.style.background = 'rgba(255, 99, 71, 0.05)';
                    this.style.borderRadius = '8px';
                    this.style.padding = '10px 15px';
                });
                
                item.addEventListener('mouseleave', function() {
                    this.style.background = 'transparent';
                    this.style.padding = '8px 0';
                });
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

        // Auto-hide success/error messages
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'all 0.5s ease';
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => {
                    if (alert.parentNode) {
                        alert.parentNode.removeChild(alert);
                    }
                }, 500);
            });
        }, 5000);
    </script>

</body>

</html>
