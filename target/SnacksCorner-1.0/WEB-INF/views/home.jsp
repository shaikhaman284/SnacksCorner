<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Snacks Corner</title>
        <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    </head>

    <body>
        <header>
            <div class="header-container">
                <jsp:include page="navbar.jsp" />
            </div>
        </header>

        <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
        <section class="hero">
            <div class="hero-content">
                <h2>Welcome to Snacks Corner!</h2>
                <p>Your one-stop destination for delicious snacks and treats.</p>
                <a href="<c:url value='/menu'/>" class="cta">Explore Now</a>
            </div>
        </section>

        <section class="about">
            <h2>About Us</h2>
            <p>At Snacks Corner, we serve fresh and tasty snacks that satisfy your cravings. From crispy fries to savory bites, we have everything to make your snack time perfect!</p>
        </section>

        <section class="services">
            <h2>Our Specials</h2>
            <div class="cards">
                <div class="card">
                    <img src="<c:url value='/static/images/snack1.jpg'/>" alt="Crispy Fries">
                    <h3>Crispy Fries</h3>
                    <p>Freshly made and seasoned to perfection.</p>
                </div>
                <div class="card">
                    <img src="<c:url value='/static/images/snack2.jpg'/>" alt="Cheesy Nachos">
                    <h3>Cheesy Nachos</h3>
                    <p>Loaded with cheese and all your favorite toppings.</p>
                </div>
                <div class="card">
                    <img src="<c:url value='/static/images/snack3.jpg'/>" alt="Spicy Tacos">
                    <h3>Spicy Tacos</h3>
                    <p>Deliciously spicy and full of flavor.</p>
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
