<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile</title>
        <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            .message{
                width: 80%;
                margin-bottom: 20px;
            }
            .cardM {
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                width: 80%;
                padding: 1rem;
                margin-bottom: 20px;
            }
            .btn-edit {
                background-color: #ff5722;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                padding: 8px 15px;
                transition: 0.3s;
            }
            .btn-edit:hover {
                background-color: #e64a19;
            }
            .eye-icon {
                cursor: pointer;
                position: relative;
                
            }
        </style>
    </head>
    <body>
        <header>
            <div class="header-container">
                <jsp:include page="navbar.jsp" />
            </div>
        </header>
        
        <!-- Flash Message Display -->
        <div class="containerM">
            <div class="message">
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            </div>
            
            <h2 class="mb-4">My Profile</h2>
            <div class="cardM p-3">
                <h5>Profile Details</h5>
                <!-- Profile Update Form -->
                <form action="updateProfile" method="post">
                    <input type="hidden" name="userId" value="${customer.userid}">
                    <input type="hidden" name="id" value="${sessionScope.loggedInUser.userid}">
                    
                    <p><strong>Name:</strong> <input type="text" name="name" value="${customer.name}" required></p>
                    <p><strong>Email:</strong> <input type="email" name="email" value="${customer.email}" required></p>
                    <p><strong>Phone:</strong> <input type="text" name="number" value="${customer.number}" required></p>
                    <p><strong>Address:</strong> <input type="text" name="address" value="${customer.address}" required></p>
                    <p><strong>City:</strong> <input type="text" name="city" value="${customer.city}" required></p>
                    
                    <!-- New Fields -->
                    <p><strong>Gender:</strong>
                        <select name="gender" required>
                            <option value="male" ${customer.gender == 'male' ? 'selected' : ''}>Male</option>
                            <option value="female" ${customer.gender == 'female' ? 'selected' : ''}>Female</option>
                            <option value="other" ${customer.gender == 'other' ? 'selected' : ''}>Other</option>
                        </select>
                    </p>
                    
                    <p><strong>State:</strong> <input type="text" name="state" value="${customer.state}" required></p>
                    <p><strong>Login Id:</strong> <input type="text" name="loginId" value="${customer.loginId}" required></p>
                    
                    <!-- Password with Eye Icon -->
                    <p><strong>Password:</strong>
                        <div style="position: relative;">
                            <input id="password" type="password" name="password" value="${customer.password}" required>
                            <i class="fas fa-eye eye-icon" id="togglePassword" onclick="togglePassword()"></i>
                        </div>
                    </p>
                    <button type="submit" class="btn btn-edit">Update Profile</button>
                </form>
            </div>
            
            <h3>Previous Orders</h3>
            <c:if test="${not empty orders}">
                <c:forEach var="order" items="${orders}">
                    <div class="cardM">
                        <h5>Order ID: ${order.orderId}</h5>
                        <p><strong>Date:</strong> ${order.orderDate}</p>
                        <p><strong>Snack:</strong> ${order.snack.name}</p>
                        <p><strong>Amount Paid:</strong> ₹${order.amount}</p>
                        <p><strong>Status:</strong> <span class="badge bg-success">${order.status}</span></p>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty orders}">
                <div class="alert alert-warning text-center">
                    No previous orders found.
                </div>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function togglePassword() {
                var passwordField = document.getElementById("password");
                var eyeIcon = document.getElementById("togglePassword");

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
