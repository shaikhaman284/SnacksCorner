<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="logo">
    <h1>Snacks Corner</h1>
    <button class="mobile-menu-toggle" onclick="toggleMobileMenu()">
        ☰
    </button>
</div>
<nav>
    <div class="nav-right">
        <ul class="nav-links">
            <li><a href="<c:url value='/home'/>">Home</a></li>
            <li><a href="<c:url value='/menu'/>">Menu</a></li>
            <li><a href="<c:url value='/contact'/>">Contact</a></li>
        </ul>

        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="profile-dropdown">
                <img src="<c:url value='/static/images/profile.png'/>" alt="Profile" class="profile-icon" onclick="toggleDropdown()" />
                <div id="profileMenu" class="dropdown-content">
                    <p>Welcome, ${sessionScope.loggedInUser.name}!</p>
                    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
                    <a href="<c:url value='/myprofile'/>?userId=${sessionScope.loggedInUser.userid}">👤 My Profile</a>
                    <a href="<c:url value='/myorder'/>?userId=${sessionScope.loggedInUser.userid}">🛒 My Orders</a>
                    <form action="<c:url value='/logout'/>" method="post" style="margin: 0;">
                        <button type="submit" class="logout-btn">🚪 Logout</button>
                    </form>
                </div>
            </div>
        </c:if>
        <c:if test="${empty sessionScope.loggedInUser}">
            <ul class="auth-links">
                <li><a href="<c:url value='/register'/>">Register</a></li>
                <li><a href="<c:url value='/login'/>">Login</a></li>
            </ul>
        </c:if>
    </div>
</nav>

<script>
    function toggleMobileMenu() {
        const nav = document.querySelector('nav');
        nav.classList.toggle('show');
    }

    function toggleDropdown() {
        const dropdown = document.getElementById('profileMenu');
        dropdown.classList.toggle('show');
    }

    // Close mobile menu when clicking outside
    document.addEventListener('click', function (event) {
        const nav = document.querySelector('nav');
        const mobileToggle = document.querySelector('.mobile-menu-toggle');

        if (!nav.contains(event.target) && !mobileToggle.contains(event.target)) {
            nav.classList.remove('show');
        }
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function (event) {
        const dropdown = document.getElementById('profileMenu');
        const profileIcon = document.querySelector('.profile-icon');

        if (dropdown && profileIcon && !dropdown.contains(event.target) && !profileIcon.contains(event.target)) {
            dropdown.classList.remove('show');
        }
    });

    // Enhanced mobile menu functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Add smooth transitions
        const nav = document.querySelector('nav');
        nav.style.transition = 'all 0.3s ease';
        
        // Add keyboard support
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                nav.classList.remove('show');
                const dropdown = document.getElementById('profileMenu');
                if (dropdown) {
                    dropdown.classList.remove('show');
                }
            }
        });

        // Add touch support for mobile
        let touchStartY = 0;
        document.addEventListener('touchstart', function(e) {
            touchStartY = e.touches[0].clientY;
        });

        document.addEventListener('touchend', function(e) {
            const touchEndY = e.changedTouches.clientY;
            const deltaY = touchStartY - touchEndY;
            
            // If swiping up and menu is open, close it
            if (deltaY > 50 && nav.classList.contains('show')) {
                nav.classList.remove('show');
            }
        });
    });
</script>
