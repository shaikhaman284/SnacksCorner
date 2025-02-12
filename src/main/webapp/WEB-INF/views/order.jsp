<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Order Page</title>
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
            }

            .containerO {
                max-width: 700px;
                margin: 50px auto;
                padding: 30px;
                border-radius: 10px;
                background-color: #ffffff;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .headerO {
                text-align: center;
                margin-bottom: 20px;
            }

            .headerO h2 {
                color: #ff5722; /* Matches the header theme */
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .details, .status, .invoice {
                margin-top: 20px;
                padding: 20px;
                border-radius: 8px;
                background-color: #f7f7f7;
                border: 1px solid #ddd;
            }

            .details p, .status p, .invoice pre {
                margin: 10px 0;
                font-size: 16px;
                color: #555;
            }

            .details p strong, .status h3, .invoice h4 {
                font-size: 18px;
                color: #333;
            }

            .button {
                text-align: center;
                margin-top: 30px;
            }

            .button button {
                background-color: #ff5722;
                color: #ffffff;
                border: none;
                border-radius: 6px;
                padding: 12px 20px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .button button:hover {
                background-color: #e64a19;
            }

            form button {
                margin-top: 10px;
                background-color: #4caf50;
                color: #fff;
                border: none;
                border-radius: 6px;
                padding: 10px 15px;
                font-size: 14px;
                cursor: pointer;
            }

            form button:hover {
                background-color: #45a049;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                }

                .header h2 {
                    font-size: 24px;
                }

                .details p, .status p, .invoice pre {
                    font-size: 14px;
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

        <div class="containerO">
            <div class="headerO">
                <h2>Order Details</h2>
            </div>

            <!-- Snack Details -->
            <div class="details">
                <!-- Display snack image -->
                <img src="<c:url value='${snack.imagePath}'/>" alt="${snack.name}" style="width: 150px; height: auto; border-radius: 10px;">

                <p><strong>Snack Name:</strong> ${snack.name}</p>
                <p><strong>Description:</strong> ${snack.description}</p>
                <p><strong>Category:</strong> ${snack.category}</p>
                <p><strong>Price:</strong> ₹${snack.price}</p>
                
            </div>

            <!-- Payment Status (Visible after payment) -->
            <c:if test="${not empty paymentStatus}">
                <div class="status">
                    <h3>${paymentStatus}</h3>
                    <p>${orderConfirmation}</p>
                </div>
            </c:if>

            <!-- Invoice Section (Visible after payment) -->
            <c:if test="${not empty invoiceDetails}">
                <div class="invoice">
                    <h4>Invoice:</h4>
                    <pre>${invoiceDetails}</pre>
                    <form action="myorder" method="get">
                        <input type="hidden" name="orderId" value="${orderId}">
                        <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}">
                        <button type="submit">Download Invoice</button>
                    </form>
                </div>
            </c:if>

            <!-- Razorpay Payment Button (Hidden after payment) -->
            <c:if test="${empty paymentStatus}">
                <div class="button">
                    <button id="rzp-button">Pay Now</button>
                </div>
            </c:if>
        </div>

        <!-- Razorpay Script -->
        <script>
            document.getElementById('rzp-button').onclick = function (e) {
                var options = {
                    "key": "rzp_live_gUGMzzVnhT5cDP",
                    "amount": "${amount}", // in paise
                    "currency": "INR",
                    "name": "Snack Corner",
                    "description": "Order for ${snack.name}",
                    "image": "path/to/logo.png", // Optional: Add your logo URL here
                    "order_id": "${orderId}",
                    "handler": function (response) {
                        // Submit payment details to the backend
                        var form = document.createElement("form");
                        form.method = "POST";
                        form.action = "verifyPayment";

                        var razorpayPaymentId = document.createElement("input");
                        razorpayPaymentId.type = "hidden";
                        razorpayPaymentId.name = "razorpayPaymentId";
                        razorpayPaymentId.value = response.razorpay_payment_id;

                        var razorpayOrderId = document.createElement("input");
                        razorpayOrderId.type = "hidden";
                        razorpayOrderId.name = "razorpayOrderId";
                        razorpayOrderId.value = response.razorpay_order_id;

                        var razorpaySignature = document.createElement("input");
                        razorpaySignature.type = "hidden";
                        razorpaySignature.name = "razorpaySignature";
                        razorpaySignature.value = response.razorpay_signature;

                        var snackId = document.createElement("input");
                        snackId.type = "hidden";
                        snackId.name = "snackId";
                        snackId.value = "${snack.snackid}";

                        var userId = document.createElement("input");
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
                    "theme": {
                        "color": "#ff5722"
                    }
                };
                var rzp = new Razorpay(options);
                rzp.open();
                e.preventDefault();
            };
        </script>

        <script>
            function toggleDropdown() {
                document.getElementById("profileMenu").classList.toggle("show");
            }

// Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                if (!event.target.matches('.profile-icon')) {
                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    for (var i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            }

        </script>
    </body>
</html>
