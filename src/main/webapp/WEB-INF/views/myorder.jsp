<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Orders</title>
        <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .containerM {
                max-width: 90%;
                margin-top: 50px;
                margin-left: 200px;
                text-align: left;
            }
            .cardM {
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                width: 80%;
                overflow: hidden;
                transition: transform 0.3s ease;
                text-align: left;
                padding: 1rem;
            }
            .order-card {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
                padding: 20px;
                background-color: #ffffff;
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .order-card:hover {
                transform: scale(1.02);
            }
            .order-image {
                width: 200px;
                height: 200px;
                object-fit: cover;
                border-radius: 10px;
                border: 1px solid #ddd;
            }
            .btn-download {
                background-color: #ff5722;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                padding: 8px 15px;
                transition: 0.3s;
            }
            .btn-download:hover {
                background-color: #e64a19;
            }
            .order-title {
                font-size: 18px;
                font-weight: bold;
                color: #343a40;
            }
            .order-info {
                font-size: 14px;
                color: #6c757d;
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
            <h2 class="mb-4">My Orders</h2>
            <c:if test="${not empty orders}">
                <c:forEach var="order" items="${orders}">
                    <div class="cardM order-card mb-3">
                        <img src="<c:url value='${order.snack.imagePath}'/>" alt="${order.snack.name}" class="order-image">
                        <div class="card-body">
                            <h5 class="order-title">Order ID: ${order.orderId}</h5>
                            <p class="order-info">Date: ${order.orderDate}</p>
                            <p class="order-info">Snack: ${order.snack.name}</p>
                            <p class="order-info">Amount Paid: ₹${order.amount}</p>
                            <p class="order-info">Status: <span class="badge bg-success">${order.status}</span></p>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty orders}">
                <div class="alert alert-warning text-center">
                    No orders found. Start shopping now!
                </div>
            </c:if>
        </div>

        <script>
            function downloadInvoice(orderId) {
                var invoiceElement = document.getElementById('invoice-' + orderId);
                invoiceElement.style.display = 'block'; // Show the invoice before generating the PDF

                html2pdf()
                        .from(invoiceElement)
                        .save('Invoice_' + orderId + '.pdf')
                        .then(() => {
                            invoiceElement.style.display = 'none'; // Hide it again after PDF download
                        });
            }
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
