<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Error | Snacks Corner</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff6347 0%, #ff8a75 50%, #ffa07a 100%);
            color: #333;
            line-height: 1.5;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 20px;
        }

        /* Animated Background Elements */
        body::before {
            content: '';
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 40px 40px;
            animation: backgroundMove 25s linear infinite;
            z-index: 1;
        }

        @keyframes backgroundMove {
            0% { transform: translateX(0) translateY(0); }
            100% { transform: translateX(40px) translateY(40px); }
        }

        /* Floating Animation Elements */
        .floating-snack {
            position: fixed;
            font-size: 1.5rem;
            animation: float 8s ease-in-out infinite;
            opacity: 0.2;
            z-index: 1;
        }

        .floating-snack:nth-child(1) {
            top: 15%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-snack:nth-child(2) {
            top: 25%;
            right: 10%;
            animation-delay: 2s;
        }

        .floating-snack:nth-child(3) {
            bottom: 25%;
            left: 15%;
            animation-delay: 4s;
        }

        .floating-snack:nth-child(4) {
            bottom: 15%;
            right: 15%;
            animation-delay: 1s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            25% {
                transform: translateY(-15px) rotate(3deg);
            }
            50% {
                transform: translateY(-8px) rotate(-3deg);
            }
            75% {
                transform: translateY(-20px) rotate(2deg);
            }
        }

        /* Main Error Container - OPTIMIZED SIZE */
        .error-container {
            position: relative;
            z-index: 10;
            text-align: center;
            padding: 30px 25px;
            max-width: 480px;
            width: 100%;
            max-height: 90vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            animation: slideInUp 0.8s ease;
            overflow-y: auto;
        }

        .error-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6347, #ff8a75, #ffa07a);
            animation: gradientShift 3s ease infinite alternate;
        }

        @keyframes gradientShift {
            0% { opacity: 0.8; }
            100% { opacity: 1; }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Error Icon - SMALLER */
        .error-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            display: block;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        /* Main Heading - SMALLER */
        .error-container h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ff6347;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from {
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }
            to {
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1), 0 0 15px rgba(255, 99, 71, 0.3);
            }
        }

        /* Subtitle - SMALLER */
        .error-subtitle {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 20px;
            font-weight: 500;
        }

        /* Error Message Box - COMPACT */
        .error-message {
            background: rgba(255, 99, 71, 0.1);
            border: 2px solid rgba(255, 99, 71, 0.2);
            border-radius: 12px;
            padding: 15px;
            margin: 20px 0;
            text-align: left;
            position: relative;
            overflow: hidden;
        }

        .error-message::before {
            content: '⚠️';
            position: absolute;
            top: 12px;
            left: 12px;
            font-size: 1.2rem;
        }

        .error-message strong {
            color: #ff6347;
            font-weight: 700;
            font-size: 1rem;
            display: block;
            margin-bottom: 8px;
            margin-left: 40px;
        }

        .error-message p {
            color: #555;
            font-size: 0.9rem;
            line-height: 1.5;
            margin-left: 40px;
            word-wrap: break-word;
            margin-bottom: 0;
        }

        /* Action Buttons - COMPACT */
        .error-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 16px;
            font-size: 0.9rem;
            font-weight: 600;
            color: white;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            font-family: 'Poppins', sans-serif;
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

        .btn-primary {
            background: linear-gradient(135deg, #ff6347, #ff8a75);
        }

        .btn-primary::after {
            content: '🏠';
            font-size: 0.8rem;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #e55342, #ff6347);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 99, 71, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }

        .btn-secondary::after {
            content: '📞';
            font-size: 0.8rem;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268, #495057);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(108, 117, 125, 0.4);
        }

        .btn-refresh {
            background: linear-gradient(135deg, #28a745, #34ce57);
        }

        .btn-refresh::after {
            content: '🔄';
            font-size: 0.8rem;
        }

        .btn-refresh:hover {
            background: linear-gradient(135deg, #218838, #28a745);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(40, 167, 69, 0.4);
        }

        /* Additional Info - COMPACT */
        .additional-info {
            margin-top: 20px;
            padding: 15px;
            background: rgba(108, 117, 125, 0.1);
            border-radius: 12px;
            border-left: 3px solid #6c757d;
        }

        .additional-info h3 {
            color: #6c757d;
            font-size: 1rem;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .additional-info p {
            color: #666;
            font-size: 0.85rem;
            line-height: 1.4;
            margin-bottom: 0;
        }

        /* Laptop Responsive */
        @media (max-width: 1366px) and (min-width: 769px) {
            .error-container {
                max-width: 420px;
                padding: 25px 20px;
            }

            .error-container h1 {
                font-size: 2.2rem;
            }

            .error-subtitle {
                font-size: 1rem;
            }

            .error-icon {
                font-size: 2.5rem;
            }
        }

        /* Tablet Responsive */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .error-container {
                padding: 25px 20px;
                width: 95%;
                max-width: 400px;
            }

            .error-container h1 {
                font-size: 2rem;
            }

            .error-subtitle {
                font-size: 1rem;
            }

            .error-icon {
                font-size: 2.5rem;
            }

            .error-actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 200px;
                justify-content: center;
            }

            .floating-snack {
                font-size: 1.2rem;
            }

            .error-message {
                padding: 12px;
                text-align: center;
            }

            .error-message strong,
            .error-message p {
                margin-left: 0;
            }

            .error-message::before {
                position: relative;
                left: 0;
                top: 0;
                display: block;
                margin-bottom: 8px;
            }
        }

        /* Mobile Responsive */
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .error-container {
                padding: 20px 15px;
                max-width: 350px;
            }

            .error-container h1 {
                font-size: 1.8rem;
            }

            .error-subtitle {
                font-size: 0.95rem;
            }

            .error-icon {
                font-size: 2.2rem;
            }

            .btn {
                padding: 8px 12px;
                font-size: 0.85rem;
            }

            .floating-snack {
                font-size: 1rem;
            }
        }

        /* Custom Scrollbar for Container */
        .error-container::-webkit-scrollbar {
            width: 4px;
        }

        .error-container::-webkit-scrollbar-track {
            background: rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        .error-container::-webkit-scrollbar-thumb {
            background: #ff6347;
            border-radius: 10px;
        }

        .error-container::-webkit-scrollbar-thumb:hover {
            background: #e55342;
        }

        /* Loading Animation */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255, 99, 71, 0.3);
            border-top: 2px solid #ff6347;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }
    </style>
</head>

<body>
    <!-- Floating Snack Elements -->
    <div class="floating-snack">🍿</div>
    <div class="floating-snack">🥨</div>
    <div class="floating-snack">🍪</div>
    <div class="floating-snack">🧈</div>

    <div class="error-container">
        <div class="error-icon">😕</div>
        
        <h1>Oops!</h1>
        <p class="error-subtitle">Something went wrong while processing your request.</p>

        <c:if test="${not empty error}">
            <div class="error-message">
                <strong>Error Details:</strong>
                <p>${error}</p>
            </div>
        </c:if>

        <c:if test="${empty error}">
            <div class="error-message">
                <strong>Unknown Error:</strong>
                <p>An unexpected error occurred. Our team has been notified and is working to fix this issue.</p>
            </div>
        </c:if>

        <div class="error-actions">
            <a href="<c:url value='/home'/>" class="btn btn-primary">
                Go to Home
            </a>
            <a href="javascript:history.back()" class="btn btn-refresh">
                Go Back
            </a>
            <a href="<c:url value='/contact'/>" class="btn btn-secondary">
                Contact Support
            </a>
        </div>

        <div class="additional-info">
            <h3>Need Help?</h3>
            <p>If you continue to experience issues, please contact our support team. We're here to help!</p>
        </div>
    </div>

    <script>
        // Add click effect to buttons
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                this.classList.add('loading');
                setTimeout(() => {
                    this.classList.remove('loading');
                }, 1500);
            });
        });

        // Add some interactivity to the error container
        const errorContainer = document.querySelector('.error-container');
        errorContainer.addEventListener('mousemove', function(e) {
            const rect = this.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            const centerX = rect.width / 2;
            const centerY = rect.height / 2;
            
            const rotateX = (y - centerY) / 30;
            const rotateY = (centerX - x) / 30;
            
            this.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
        });

        errorContainer.addEventListener('mouseleave', function() {
            this.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg)';
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                window.history.back();
            } else if (e.key === 'h' || e.key === 'H') {
                window.location.href = '<c:url value="/home"/>';
            }
        });

        // Console message for developers
        console.log(`
🍿 Snacks Corner Error Page
========================
If you're a developer seeing this, check the network tab for more details.
Error: <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Unknown error" %>
Timestamp: <%= new java.util.Date() %>
User Agent: ${navigator.userAgent}
`);
    </script>
</body>

</html>
