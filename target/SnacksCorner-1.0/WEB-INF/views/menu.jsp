<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.snackcorner.app.model.Snack" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Menu | Snacks Corner</title>
        <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

        <style>

            .btn {
                padding: 10px 20px;
                font-size: 1rem;
                font-weight: 500;
                color: #ffffff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .btn-primary {
                background-color: #ff6347; /* Same as the header color */
            }

            .btn-primary:hover {
                background-color: #e55342; /* Darker shade for primary button hover */
            }

            .btn:active {
                transform: scale(0.98); /* Adds a slight press-down effect */
            }

        </style>
    </head>

    <body>
        <header>
            <div class="header-container">
                <jsp:include page="navbar.jsp" />
            </div>
        </header>

        <section class="hero">
            <div class="hero-content">
                <h2>Our Menu</h2>
                <p>Discover the tasty variety of snacks we offer!</p>
            </div>
        </section>

        <section class="services">
            <h2>Snacks</h2>
            <div class="cards">
                <c:forEach var="snack" items="${snacks}" varStatus="status">
                    <div class="card">
                        <!-- Display snack image dynamically -->
                        <img src="<c:url value='${snack.imagePath}'/>" alt="${snack.name}">

                        <h3>${snack.name}</h3>
                        <p>${snack.description}</p>
                        <p><strong>Price:</strong> $${snack.price}</p>
                        <p><strong>Category:</strong> ${snack.category}</p>

                        <c:choose>
                            <c:when test="${not empty sessionScope.loggedInUser}">
                                <form action="<c:url value='/order'/>" method="get">
                                    <input type="hidden" name="snackId" value="${snack.snackid}">
                                    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
                                    <button type="submit" class="btn btn-primary">Buy</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/register'/>" class="btn btn-primary">Buy</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </section>

        <footer>
            <p>&copy; 2024 Snacks Corner | All Rights Reserved</p>
        </footer>

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
