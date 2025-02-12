
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

     
        <script src="https://cdn.emailjs.com/dist/email.min.js"></script>
        <script>
            (function () {
                emailjs.init("UYyhcTba63VsuPggW"); // Replace with your EmailJS User ID
            })();
        </script>
    </head>

    <body>
        <header>
            <div class="header-container">
                <jsp:include page="navbar.jsp" />
            </div>
        </header>

        <section class="contact-hero">
            <div class="hero-content">
                <h2>Get in Touch</h2>
                <p>We'd love to hear from you!</p>
            </div>
        </section>

        <section class="contact-info">
            <h2>Contact Information</h2>
            <div class="info-cards">
                <!-- Phone Card -->
                <a href="tel:+917249329343" class="info-card" style="text-decoration: none; color: inherit;">
                    <img src="<c:url value='/static/images/phone-icon.png'/>" alt="Phone">
                    <h3>Phone</h3>
                    <p>+91 7249329343</p>
                </a>

                <!-- Email Card -->
                <a href="mailto:snackscorner@gmail.com" class="info-card" style="text-decoration: none; color: inherit;">
                    <img src="<c:url value='/static/images/email-icon.png'/>" alt="Email">
                    <h3>Email</h3>
                    <p>snackscorner@gmail.com</p>
                </a>

                <!-- Address Card -->
                <a href="https://maps.google.com/?q=123+Snack+Street+Camp+Amravati" target="_blank" class="info-card" style="text-decoration: none; color: inherit;">
                    <img src="<c:url value='/static/images/location-icon.png'/>" alt="Location">
                    <h3>Address</h3>
                    <p>123 Snack Street, Camp, Amravati</p>
                </a>
            </div>
        </section>

        <section class="contact-form-section">
            <h2>Send Us a Message</h2>
            <form class="contact-form" id="contact-form">
                <div class="form-group">
                    <label for="name">Name<span>*</span></label><br><br>
                    <input type="text" id="name" name="name" required placeholder="Your Name">
                </div>
                <div class="form-group">
                    <label for="email">Email<span>*</span></label><br><br>
                    <input type="email" id="email" name="email" required placeholder="Your Email">
                </div>
                <div class="form-group">
                    <label for="message">Message<span>*</span></label><br><br>
                    <textarea id="message" name="message" rows="5" required placeholder="Your Message"></textarea>
                </div>
                <button type="submit" class="submit-btn">Send Message</button>
            </form>

            <script>
                const form = document.getElementById("contact-form");

                form.addEventListener("submit", function (e) {
                    e.preventDefault();

                    emailjs.sendForm("service_mhqufkc", "template_9dc938t", this)
                            .then(function () {
                                alert("Message sent successfully!");
                            }, function (error) {
                                alert("Failed to send message. Error: " + error);
                            });
                });
            </script>
        </section>


        <section class="map">
            <h2>Find Us Here</h2>
            <div class="map-container">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3806.927726648299!2d77.75638947485546!3d20.987772358106204!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bd6a2d15d81f4cd%3A0x703a9debc9500a6b!2sP.%20R.%20Pote%20Patil%20College%20of%20Engineering%20and%20Management!5e0!3m2!1sen!2sin!4v1690199124567!5m2!1sen!2sin"
                    width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade"></iframe>
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