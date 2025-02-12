<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="logo">
    <h1>Snacks Corner</h1>
</div>
<nav>
    <ul class="nav-left">
        <li><a href="<c:url value='/home'/>">Home</a></li>
        <li><a href="<c:url value='/menu'/>">Menu</a></li>
        
        <li><a href="<c:url value='/contact'/>">Contact</a></li>
    </ul>
    <div class="nav-right">
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="profile-dropdown">
                <img src="<c:url value='static/images/profile.png'/>" alt="Profile" class="profile-icon" onclick="toggleDropdown()" />
                <div id="profileMenu" class="dropdown-content">
                    <p>Welcome, ${sessionScope.loggedInUser.name}</p>
                    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userid}" />
                    <a href="<c:url value='/myprofile'/>?userId=${sessionScope.loggedInUser.userid}">Profile</a><br>
                    <a href="<c:url value='/myorder'/>?userId=${sessionScope.loggedInUser.userid}">My Order</a><br>

                    <form action="<c:url value='/logout'/>" method="post" style="margin: 0;">
                        <button type="submit" class="logout-btn">Logout</button>
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