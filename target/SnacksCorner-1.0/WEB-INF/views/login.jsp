<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Login - Snacks Corner</title>
    <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MlJ2e5u42zFoCT8FFjR61F6S9FFb8PHi9EUzQwZxuJ77Gq8gVv8HZoG56CVXU6fK" crossorigin="anonymous">
</head>

<body>
     <header>
            <div class="header-container">
                <jsp:include page="navbar.jsp" />
            </div>
        </header>

    <section class="registration-section">
        <div class="registration-content">
            <h2>Login to Your Account</h2>
            <div class="alert alert-danger" role="alert">
                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>
            </div>

            <div class="login-options">
                <button class="btn btn-primary" onclick="showUserLogin()">User Login</button>
                <button class="btn btn-secondary" onclick="showAdminLogin()">Admin Login</button>
            </div>

            <div id="userLoginForm" class="login-form" style="display: none;">
                <h3>User Login</h3>
                <form action="userLogin" method="post" class="registration-form">
                    <div class="form-group">
                        <label for="userLoginId">Login ID:</label>
                        <input type="text" name="loginId" id="userLoginId" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Enter a valid email address" />
                    </div>
                    <div class="form-group">
                        <label for="userPassword">Password:</label>
                        <input type="password" name="password" id="userPassword" required minlength="6" title="Password must be at least 6 characters long" />
                    </div>
                    <button type="submit" class="cta">Login as User</button>
                </form>
                <p id="registerLink">Don't have an account? <a href="<c:url value='/register'/>">Register here</a></p>
            </div>

            <div id="adminLoginForm" class="login-form" style="display: none;">
                <h3>Admin Login</h3>
                <form action="adminLogin" method="post" class="registration-form">
                    <div class="form-group">
                        <label for="adminLoginId">Admin ID:</label>
                        <input type="text" name="loginId" id="adminLoginId" required />
                    </div>
                    <div class="form-group">
                        <label for="adminPassword">Password:</label>
                        <input type="password" name="password" id="adminPassword" required minlength="6" title="Password must be at least 6 characters long" />
                    </div>
                    <button type="submit" class="cta">Login as Admin</button>
                </form>
            </div>

            

        </div>
    </section>

    <footer>
        <p>&copy; 2024 Snacks Corner | All Rights Reserved</p>
    </footer>

    <script>
        function toggleDropdown() {
            document.getElementById("profileMenu").classList.toggle("show");
        }

        window.onclick = function(event) {
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

        function showUserLogin() {
            document.getElementById("userLoginForm").style.display = "block";
            document.getElementById("adminLoginForm").style.display = "none";
        }

        function showAdminLogin() {
            document.getElementById("adminLoginForm").style.display = "block";
            document.getElementById("userLoginForm").style.display = "none";
        }
    </script>

</body>

</html>
