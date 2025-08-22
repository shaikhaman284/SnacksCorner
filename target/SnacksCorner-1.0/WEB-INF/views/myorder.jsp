<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Orders | Snacks Corner</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
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
            margin-bottom: 50px;
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
            content: '📦';
            font-size: 2.5rem;
        }

        .page-header p {
            color: #666;
            font-size: 1.1rem;
            margin-top: 10px;
        }

        /* Orders Grid */
        .orders-grid {
            display: grid;
            gap: 25px;
            grid-template-columns: 1fr;
        }

        /* Individual Order Card */
        .cardM.order-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            border: 2px solid transparent;
            position: relative;
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

        .cardM.order-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
            transition: left 0.4s ease;
        }

        .cardM.order-card:hover::before {
            left: 0;
        }

        .cardM.order-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(255, 99, 71, 0.15);
            border-color: #ff6347;
        }

        .order-card {
            display: flex;
            align-items: center;
            gap: 25px;
            padding: 30px;
        }

        /* Order Image */
        .order-image {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
            flex-shrink: 0;
        }

        .order-image:hover {
            transform: scale(1.05);
        }

        /* Order Content */
        .order-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .order-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .order-title::before {
            content: '🧾';
            font-size: 1.2rem;
        }

        .order-info {
            font-size: 1rem;
            color: #666;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
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
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-badge.success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .status-badge.success::before {
            content: '✅';
        }

        .status-badge.pending {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-badge.pending::before {
            content: '⏳';
        }

        /* Action Buttons */
        .order-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            flex-wrap: wrap;
        }

        .btn-download {
            background: linear-gradient(135deg, #28a745, #34ce57);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-download::before {
            content: '📥';
        }

        .btn-download:hover {
            background: linear-gradient(135deg, #218838, #28a745);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.4);
            color: white;
        }

        .btn-reorder {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 99, 71, 0.3);
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-reorder::before {
            content: '🔄';
        }

        .btn-reorder:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 99, 71, 0.4);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 40px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-top: 40px;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .empty-state p {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .empty-state .btn {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            padding: 15px 30px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .empty-state .btn::before {
            content: '🛒';
        }

        .empty-state .btn:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 99, 71, 0.4);
            color: white;
        }

        /* Invoice Template (Hidden) */
        .invoice-template {
            display: none;
            max-width: 800px;
            margin: 0 auto;
            padding: 40px;
            background: white;
            font-family: 'Poppins', sans-serif;
            color: #333;
        }

        .invoice-header {
            text-align: center;
            margin-bottom: 40px;
            border-bottom: 3px solid #ff6347;
            padding-bottom: 20px;
        }

        .invoice-header h1 {
            color: #ff6347;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .invoice-header p {
            color: #666;
            font-size: 1.1rem;
        }

        .invoice-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }

        .invoice-section h3 {
            color: #ff6347;
            font-size: 1.3rem;
            margin-bottom: 15px;
            border-bottom: 2px solid #ff6347;
            padding-bottom: 5px;
        }

        .invoice-section p {
            margin-bottom: 8px;
            line-height: 1.6;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .invoice-table th,
        .invoice-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .invoice-table th {
            background: #ff6347;
            color: white;
            font-weight: 600;
        }

        .invoice-total {
            text-align: right;
            font-size: 1.2rem;
            font-weight: 700;
            color: #ff6347;
            margin-top: 20px;
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

            .order-card {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
                padding: 25px 20px;
            }

            .order-image {
                width: 100%;
                max-width: 300px;
                height: 200px;
                align-self: center;
            }

            .order-actions {
                width: 100%;
                justify-content: center;
            }

            .btn-download,
            .btn-reorder {
                flex: 1;
                justify-content: center;
                min-width: 120px;
            }

            .empty-state {
                padding: 60px 20px;
            }

            .empty-state h3 {
                font-size: 1.8rem;
            }

            footer {
                padding: 40px 20px 20px;
            }

            .invoice-details {
                grid-template-columns: 1fr;
                gap: 20px;
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

            .order-card {
                padding: 20px 15px;
            }

            .order-image {
                height: 180px;
            }

            .order-title {
                font-size: 1.2rem;
            }

            .order-info {
                font-size: 0.9rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .order-actions {
                flex-direction: column;
            }

            .empty-state {
                padding: 40px 15px;
            }

            .empty-state h3 {
                font-size: 1.6rem;
            }

            .empty-state-icon {
                font-size: 3rem;
            }
        }

        /* Stagger Animation for Order Cards */
        .cardM.order-card:nth-child(1) { animation-delay: 0.1s; }
        .cardM.order-card:nth-child(2) { animation-delay: 0.2s; }
        .cardM.order-card:nth-child(3) { animation-delay: 0.3s; }
        .cardM.order-card:nth-child(4) { animation-delay: 0.4s; }
        .cardM.order-card:nth-child(5) { animation-delay: 0.5s; }
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
            <h2>My Orders</h2>
            <p>Track and manage all your delicious snack orders</p>
        </div>

        <div class="orders-grid">
            <c:if test="${not empty orders}">
                <c:forEach var="order" items="${orders}" varStatus="status">
                    <div class="cardM order-card">
                        <img src="<c:url value='${order.snack.imagePath}'/>" alt="${order.snack.name}" class="order-image">
                        
                        <div class="order-content">
                            <h5 class="order-title">Order #${order.orderId}</h5>
                            
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
                                <span class="status-badge success">${order.status}</span>
                            </div>

                            <div class="order-actions">
                                <button class="btn-download" onclick="downloadInvoice('${order.orderId}', '${order.snack.name}', '${order.orderDate}', '${order.amount}')">
                                    Download Invoice
                                </button>
                                <a href="<c:url value='/order'/>?snackId=${order.snack.snackid}&userId=${sessionScope.loggedInUser.userid}" class="btn-reorder">
                                    Reorder
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden Invoice Template for PDF Generation -->
                    <div id="invoice-${order.orderId}" class="invoice-template">
                        <div class="invoice-header">
                            <h1>🍿 Snacks Corner</h1>
                            <p>Invoice for Order #${order.orderId}</p>
                        </div>

                        <div class="invoice-details">
                            <div class="invoice-section">
                                <h3>Bill To:</h3>
                                <p><strong>Customer:</strong> ${sessionScope.loggedInUser.name}</p>
                                <p><strong>Email:</strong> ${sessionScope.loggedInUser.email}</p>
                                <p><strong>Phone:</strong> ${sessionScope.loggedInUser.number}</p>
                                <p><strong>Address:</strong> ${sessionScope.loggedInUser.address}</p>
                            </div>

                            <div class="invoice-section">
                                <h3>Order Details:</h3>
                                <p><strong>Order ID:</strong> ${order.orderId}</p>
                                <p><strong>Order Date:</strong> ${order.orderDate}</p>
                                <p><strong>Payment Status:</strong> ${order.status}</p>
                                <p><strong>Payment Method:</strong> Online Payment</p>
                            </div>
                        </div>

                        <table class="invoice-table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Description</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>${order.snack.name}</td>
                                    <td>${order.snack.description}</td>
                                    <td>1</td>
                                    <td>₹${order.amount}</td>
                                    <td>₹${order.amount}</td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="invoice-total">
                            <p><strong>Total Amount: ₹${order.amount}</strong></p>
                        </div>

                        <div style="margin-top: 40px; text-align: center; color: #666; font-size: 0.9rem;">
                            <p>Thank you for choosing Snacks Corner!</p>
                            <p>For any queries, contact us at info@snackscorner.com</p>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty orders}">
                <div class="empty-state">
                    <div class="empty-state-icon">📦</div>
                    <h3>No Orders Yet</h3>
                    <p>You haven't placed any orders yet. Start exploring our delicious snacks and place your first order!</p>
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

    // Enhanced Invoice Download Function
    function downloadInvoice(orderId, snackName, orderDate, amount) {
        const invoiceElement = document.getElementById('invoice-' + orderId);
        const downloadBtn = event.target;
        const originalText = downloadBtn.innerHTML;
        
        if (!invoiceElement) {
            alert('Invoice not found for this order.');
            return;
        }

        // Show loading state
        downloadBtn.innerHTML = '⏳ Generating...';
        downloadBtn.disabled = true;

        // Show the invoice before generating PDF
        invoiceElement.style.display = 'block';

        // Configure PDF options
        const opt = {
            margin: 0.5,
            filename: 'Snacks_Corner_Invoice_' + orderId + '.pdf',
            image: { type: 'jpeg', quality: 0.98 },
            html2canvas: { scale: 2, useCORS: true },
            jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
        };

        // Generate and download PDF
        html2pdf()
            .from(invoiceElement)
            .set(opt)
            .save()
            .then(() => {
                // Hide the invoice again after PDF generation
                invoiceElement.style.display = 'none';
                
                // Reset button state
                downloadBtn.innerHTML = originalText;
                downloadBtn.disabled = false;
                
                // Show success message
                showNotification('Invoice downloaded successfully!', 'success');
            })
            .catch((error) => {
                console.error('PDF generation failed:', error);
                
                // Hide the invoice on error
                invoiceElement.style.display = 'none';
                
                // Reset button state
                downloadBtn.innerHTML = originalText;
                downloadBtn.disabled = false;
                
                // Show error message
                showNotification('Failed to generate invoice. Please try again.', 'error');
            });
    }

    // Fixed Notification function
    function showNotification(message, type) {
        const notification = document.createElement('div');
        notification.className = 'notification notification-' + type;
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.classList.add('notification-exit');
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 300);
        }, 3000);
    }

    // Add CSS for notification classes
    const style = document.createElement('style');
    style.textContent = `
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            z-index: 10000;
            animation: slideInRight 0.3s ease;
        }
        
        .notification-success {
            background: #28a745;
        }
        
        .notification-error {
            background: #dc3545;
        }
        
        .notification-exit {
            animation: slideOutRight 0.3s ease;
        }
        
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
    `;
    document.head.appendChild(style);

    // Rest of your existing JavaScript code...

        // Enhanced interactions
        document.addEventListener('DOMContentLoaded', function() {
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

            // Add loading animation to reorder buttons
            const reorderButtons = document.querySelectorAll('.btn-reorder');
            reorderButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const originalText = this.innerHTML;
                    this.innerHTML = '⏳ Processing...';
                    this.style.pointerEvents = 'none';
                    
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.style.pointerEvents = 'auto';
                    }, 1000);
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
    </script>
</body>

</html>
