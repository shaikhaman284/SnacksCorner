<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Order Details | Snacks Corner</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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
        .containerO {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
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

        /* Header Section */
        .headerO {
            text-align: center;
            margin-bottom: 40px;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .headerO::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
        }

        .headerO h2 {
            color: #ff6347;
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .headerO h2::before {
            content: '🛒';
            font-size: 2rem;
        }

        /* Snack Details Card */
        .details {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .details::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75);
            transition: left 0.4s ease;
        }

        .details:hover::before {
            left: 0;
        }

        .details:hover {
            border-color: #ff6347;
            transform: translateY(-5px);
            box-shadow: 0 20px 50px rgba(255, 99, 71, 0.15);
        }

        .snack-image {
            width: 100%;
            max-width: 300px;
            height: 200px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }

        .snack-image:hover {
            transform: scale(1.05);
        }

        .details p {
            margin: 15px 0;
            font-size: 1.1rem;
            color: #555;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .details p:last-child {
            border-bottom: none;
        }

        .details p strong {
            color: #333;
            font-weight: 600;
            min-width: 120px;
        }

        .price-highlight {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            padding: 15px 20px;
            border-radius: 12px;
            font-size: 1.3rem;
            font-weight: 700;
            text-align: center;
            margin-top: 20px;
            box-shadow: 0 8px 20px rgba(255, 99, 71, 0.3);
        }

        /* Status and Invoice Cards */
        .status, .invoice {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            border-left: 5px solid #28a745;
            animation: slideInRight 0.8s ease;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .status {
            border-left-color: #28a745;
        }

        .invoice {
            border-left-color: #ff6347;
        }

        .status h3 {
            color: #28a745;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .status h3::before {
            content: '✅';
            font-size: 1.5rem;
        }

        .status p {
            color: #666;
            font-size: 1.1rem;
            margin: 0;
        }

        .invoice h4 {
            color: #ff6347;
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .invoice h4::before {
            content: '🧾';
            font-size: 1.3rem;
        }

        .invoice pre {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            font-family: 'Poppins', monospace;
            font-size: 0.95rem;
            color: #555;
            border: 1px solid #e9ecef;
            white-space: pre-wrap;
            word-wrap: break-word;
        }

        .invoice form {
            margin-top: 20px;
        }

        .download-btn {
            background: linear-gradient(135deg, #28a745, #34ce57);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 12px 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .download-btn::before {
            content: '📥';
        }

        .download-btn:hover {
            background: linear-gradient(135deg, #218838, #28a745);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.4);
        }

        /* Payment Button */
        .button {
            text-align: center;
            margin: 40px 0;
        }

        #rzp-button {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 18px 40px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 25px rgba(255, 99, 71, 0.3);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin: 0 auto;
            max-width: 250px;
        }

        #rzp-button::before {
            content: '💳';
            font-size: 1.1rem;
        }

        #rzp-button::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        #rzp-button:hover::after {
            left: 100%;
        }

        #rzp-button:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(255, 99, 71, 0.4);
        }

        #rzp-button:active {
            transform: translateY(-1px);
        }

        #rzp-button.processing {
            background: linear-gradient(135deg, #6c757d, #adb5bd);
            cursor: not-allowed;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 6px solid #f3f3f3;
            border-top: 6px solid #ff6347;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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

            .containerO {
                margin: 20px auto;
                padding: 0 15px;
            }

            .headerO {
                padding: 20px;
            }

            .headerO h2 {
                font-size: 2rem;
                flex-direction: column;
                gap: 10px;
            }

            .details, .status, .invoice {
                padding: 25px 20px;
            }

            .snack-image {
                max-width: 100%;
                height: 180px;
            }

            .details p {
                font-size: 1rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .details p strong {
                min-width: auto;
            }

            .price-highlight {
                font-size: 1.1rem;
                padding: 12px 15px;
            }

            #rzp-button {
                width: 100%;
                max-width: none;
                padding: 15px 30px;
                font-size: 1.1rem;
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

            .containerO {
                margin: 15px auto;
                padding: 0 10px;
            }

            .headerO {
                padding: 15px;
            }

            .headerO h2 {
                font-size: 1.8rem;
            }

            .details, .status, .invoice {
                padding: 20px 15px;
            }

            .snack-image {
                height: 150px;
            }

            .details p {
                font-size: 0.95rem;
            }

            #rzp-button {
                padding: 12px 25px;
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

    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>

    <div class="containerO">
        <div class="headerO">
            <h2>Order Details</h2>
        </div>

        <!-- Snack Details -->
        <div class="details">
            <img src="<c:url value='${snack.imagePath}'/>" alt="${snack.name}" class="snack-image">
            
            <p><strong>🍿 Snack Name:</strong> ${snack.name}</p>
            <p><strong>📝 Description:</strong> ${snack.description}</p>
            <p><strong>🏷️ Category:</strong> ${snack.category}</p>
            
            <div class="price-highlight">
                <strong>💰 Total Price: ₹${snack.price}</strong>
            </div>
        </div>

        <!-- Payment Status (Visible after payment) -->
        <c:if test="${not empty paymentStatus}">
            <div class="status">
                <h3>Payment Successful!</h3>
                <p>${orderConfirmation}</p>
            </div>
        </c:if>

        <!-- Invoice Section (Visible after payment) -->
        <c:if test="${not empty invoiceDetails}">
            <div class="invoice">
                <h4>Invoice Details</h4>
                <pre>${invoiceDetails}</pre>
                <form action="myorder" method="get">
                    <input type="hidden" name="orderId" value="${orderId}">
                    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}">
                    <button type="submit" class="download-btn">Download Invoice</button>
                </form>
            </div>
        </c:if>

        <!-- Razorpay Payment Button (Hidden after payment) -->
        <c:if test="${empty paymentStatus}">
            <div class="button">
                <button id="rzp-button">Pay Now Securely</button>
            </div>
        </c:if>
    </div>

    <footer>
        <div class="footer-content">
            <h3>Snacks Corner</h3>
            <p>&copy; 2024 Snacks Corner | All Rights Reserved | Made with ❤️ for Snack Lovers</p>
        </div>
    </footer>

    <!-- Razorpay Script -->
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

        // Enhanced Razorpay Integration
        document.getElementById('rzp-button').onclick = function (e) {
            e.preventDefault();
            
            const button = this;
            const originalText = button.innerHTML;
            
            // Show loading state
            button.innerHTML = '⏳ Processing...';
            button.classList.add('processing');
            button.disabled = true;
            
            // Show loading overlay
            document.getElementById('loadingOverlay').style.display = 'flex';
            
            const options = {
                "key": "rzp_live_gUGMzzVnhT5cDP",
                "amount": "${amount}", // in paise
                "currency": "INR",
                "name": "Snacks Corner",
                "description": "Order for ${snack.name}",
                "image": "path/to/logo.png", // Optional: Add your logo URL here
                "order_id": "${orderId}",
                "handler": function (response) {
                    // Keep loading overlay visible during form submission
                    
                    // Submit payment details to the backend
                    const form = document.createElement("form");
                    form.method = "POST";
                    form.action = "verifyPayment";

                    const razorpayPaymentId = document.createElement("input");
                    razorpayPaymentId.type = "hidden";
                    razorpayPaymentId.name = "razorpayPaymentId";
                    razorpayPaymentId.value = response.razorpay_payment_id;

                    const razorpayOrderId = document.createElement("input");
                    razorpayOrderId.type = "hidden";
                    razorpayOrderId.name = "razorpayOrderId";
                    razorpayOrderId.value = response.razorpay_order_id;

                    const razorpaySignature = document.createElement("input");
                    razorpaySignature.type = "hidden";
                    razorpaySignature.name = "razorpaySignature";
                    razorpaySignature.value = response.razorpay_signature;

                    const snackId = document.createElement("input");
                    snackId.type = "hidden";
                    snackId.name = "snackId";
                    snackId.value = "${snack.snackid}";

                    const userId = document.createElement("input");
                    userId.type = "hidden";
                    userId.name = "userId";
                    userId.value = "${sessionScope.loggedInUser.userid}";

                    form.appendChild(razorpayPaymentId);
                    form.appendChild(razorpayOrderId);
                    form.appendChild(razorpaySignature);
                    form.appendChild(snackId);
                    form.appendChild(userId);

                    document.body.appendChild(form);
                    form.submit();
                },
                "modal": {
                    "ondismiss": function() {
                        // Reset button state if payment modal is closed
                        button.innerHTML = originalText;
                        button.classList.remove('processing');
                        button.disabled = false;
                        document.getElementById('loadingOverlay').style.display = 'none';
                    }
                },
                "theme": {
                    "color": "#ff6347"
                }
            };
            
            const rzp = new Razorpay(options);
            
            // Hide loading overlay when Razorpay modal opens
            rzp.on('payment.submit', function() {
                document.getElementById('loadingOverlay').style.display = 'none';
            });
            
            rzp.open();
        };

        // Enhanced interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Animate elements on load
            const elements = document.querySelectorAll('.details, .status, .invoice');
            elements.forEach((element, index) => {
                setTimeout(() => {
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 200);
            });

            // Add hover effects to snack details
            const detailItems = document.querySelectorAll('.details p');
            detailItems.forEach(item => {
                item.addEventListener('mouseenter', function() {
                    this.style.background = 'rgba(255, 99, 71, 0.05)';
                    this.style.borderRadius = '8px';
                    this.style.padding = '10px 15px';
                });
                
                item.addEventListener('mouseleave', function() {
                    this.style.background = 'transparent';
                    this.style.padding = '10px 0';
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
                
                // Hide loading overlay
                const loadingOverlay = document.getElementById('loadingOverlay');
                if (loadingOverlay.style.display === 'flex') {
                    loadingOverlay.style.display = 'none';
                }
            }
        });
    </script>
</body>

</html>
