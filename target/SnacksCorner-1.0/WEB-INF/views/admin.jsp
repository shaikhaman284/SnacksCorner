<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.snackcorner.app.model.Snack" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Snacks Corner</title>
        <link rel="stylesheet" href="<c:url value='/static/css/styles.css'/>">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MlJ2e5u42zFoCT8FFjR61F6S9FFb8PHi9EUzQwZxuJ77Gq8gVv8HZoG56CVXU6fK" crossorigin="anonymous">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }

            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ff6347;
                padding: 10px 20px;
                color: #ffffff;
            }

            .header-container h1 {
                font-size: 1.8rem;
                font-weight: 600;
            }

            .nav-right .auth-links {
                list-style-type: none;
                display: flex;
            }

            .auth-links li a {
                color: #ffffff;
                text-decoration: none;
                font-weight: 500;
                margin-left: 15px;
                transition: color 0.3s ease;
            }

            .auth-links li a:hover {
                color: #ff8a75;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                text-align: center;
                width: 90%;
                margin: 10px auto;
            }

            .success {
                background-color: #d4edda;
                color: #155724;
            }

            .error {
                background-color: #f8d7da;
                color: #721c24;
            }

            .dashboard-container {
                display: grid;
                gap: 2rem;
                padding: 2rem;
                grid-template-columns: 1fr 1fr;
            }

            .snacks-management h2,
            .snacks-list h2,
            .customers-list h2,
            .orders-billing h2 {
                color: #ff6347;
                margin-bottom: 1rem;
            }

            .add-snack-form,
            .edit-snack-form {
                background-color: rgba(255, 255, 255, 0.8);
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .add-snack-form .form-group,
            .edit-snack-form .form-group {
                margin-bottom: 1rem;
            }

            .add-snack-form label,
            .edit-snack-form label {
                display: block;
                font-weight: 600;
                color: #333;
                margin-bottom: 0.5rem;
            }

            .add-snack-form input[type="text"],
            .edit-snack-form input[type="text"],
            .add-snack-form textarea,
            .edit-snack-form textarea {
                width: 100%;
                padding: 0.6rem;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .add-snack-form textarea,
            .edit-snack-form textarea {
                resize: vertical;
            }

            .cta {
                display: inline-block;
                width: 100%;
                text-align: center;
                padding: 0.8rem;
                font-weight: 600;
                color: white;
                background-color: #ff6347;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .cta:hover {
                background-color: #e55342;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-top: 1rem;
                background-color: #fff;
            }

            table th, table td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            table th {
                background-color: #ff6347;
                color: white;
            }

            table tbody tr:hover {
                background-color: #f2f2f2;
            }

            .actions {
                display: flex;
                gap: 10px;
            }

            .edit, .delete {
                color: #ff6347;
                cursor: pointer;
                font-weight: bold;
            }

            .edit:hover, .delete:hover {
                color: #e55342;
            }

            .btn {

                margin-top: 10px;
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
                background-color: #ff6347;
            }

            .btn-primary:hover {
                background-color: #e55342;
            }

            .btn-secondary {
                background-color: #555; /* Secondary color */
            }

            .btn-secondary:hover {
                background-color: #333; /* Darker shade for secondary button hover */
            }
            /* Modal Styles */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1000; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
            }

            .modal-dialog {
                margin: 15% auto; /* Center modal vertically */
                max-width: 500px; /* Set a max width for modal */
            }

            .modal-content {
                background-color: #fefefe;
                border: 1px solid #888;
                border-radius: 5px;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <header class="header-container">
            <h1>Admin Dashboard</h1>
            <nav class="nav-right">
                <ul class="auth-links">

                    <form action="<c:url value='/logout'/>" method="post" style="margin: 0;">
                        <button type="submit" class="btn btn-secondary">Logout</button>
                    </form>
                </ul>
            </nav>
        </header>

        <% String message = (String) request.getAttribute("message"); %>
        <% String error = (String) request.getAttribute("error"); %>

        <% if (message != null) { %>
        <div class="alert success"><%= message %></div>
        <% } %>

        <% if (error != null) { %>
        <div class="alert error"><%= error %></div>
        <% } %>

        <div class="dashboard-container">
            <section class="snacks-management">
                <h2>Add New Snack</h2>

                <form id="addSnackForm" class="add-snack-form" action="admin/addSnack" method="post" enctype="multipart/form-data">
                    <label for="name">Snack Name:</label>
                    <input type="text" id="name" name="name" required>

                    <label for="price">Snack Price:</label>
                    <input type="text" id="price" name="price" required>

                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required></textarea>

                    <label for="category">Category:</label>
                    <input type="text" id="category" name="category" required>

                    <label for="image">Upload Image:</label>
                    <input type="file" id="image" name="imageFile" accept="image/*" required>

                    <button class="btn btn-primary" type="submit">Add Snack</button>
                </form>


            </section>

            <section class="snacks-list">
                <h2>Snacks List</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Description</th>
                            <th>Category</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="snack" items="${snacks}">
                            <tr>
                                <td>${snack.name}</td>
                                <td>${snack.price}</td>
                                <td>${snack.description}</td>
                                <td>${snack.category}</td>
                                <td class="actions">
                                    <span class="edit" data-id="${snack.snackid}" data-name="${snack.name}" data-price="${snack.price}" data-description="${snack.description}" data-category="${snack.category}">Edit</span>
                                    <span class="delete" onclick="deleteSnack(${snack.snackid})">Delete</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>

            <section class="customers-list">
                <h2>Registered Customers</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Number</th>
                            <th>Email</th>
                            <th>City</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="customer" items="${customers}">
                            <tr>
                                <td>${customer.name}</td>
                                <td>${customer.number}</td>
                                <td>${customer.email}</td>
                                <td>${customer.city}</td>
                                <td>
                                    <button class="btn btn-primary view-orders-btn" data-userid="${customer.userid}">View Orders</button>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>


            <section class="orders-billing">
                <h2>All Orders</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Snack</th>
                            <th>Price</th>
                            <th>Order Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.user.name}</td>
                                <td>${order.snack.name}</td>
                                <td>${order.snack.price}</td>
                                <td>${order.orderDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>


            <!-- Edit Snack Modal -->
            <div id="editSnackModal" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <div class="edit-snack-form">
                            <h2>Edit Snack</h2>
                            <form id="editSnackForm" action="admin/updateSnack" method="post">
                                <input type="hidden" id="editSnackId" name="snackid">
                                <label for="editSnackName">Snack Name:</label>
                                <input type="text" id="editSnackName" name="name" required>

                                <label for="editSnackPrice">Snack Price:</label>
                                <input type="text" id="editSnackPrice" name="price" required>

                                <label for="editSnackDescription">Description:</label>
                                <textarea id="editSnackDescription" name="description" required></textarea>

                                <label for="editSnackCategory">Category:</label>
                                <input type="text" id="editSnackCategory" name="category" required>

                                <button class="btn btn-primary" type="submit">Update Snack</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Edit Snack Modal -->

            <!-- Orders Modal -->
            <div id="ordersModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Orders for <span id="customerName">${customerName}</span></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Snack Name</th>
                                        <th>Price</th>
                                        <th>Order Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>${order.orderId}</td>
                                            <td>${order.snack.name}</td>
                                            <td>${order.snack.price}</td>
                                            <td>${order.orderDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Automatically Show Modal if Orders Exist -->
            <c:if test="${not empty orders}">
                <script>
                    $(document).ready(function () {
                        $("#ordersModal").modal("show");
                    });
                </script>
            </c:if>


        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-3yR1c3V1XERXkNUV4R+K6iO+IDbN4C5Q7C6WVY7dU9DHS2w7K2DZo6/qCpH8z9Jo" crossorigin="anonymous"></script>
        <script>
                    $(document).ready(function () {
                        $('.edit').on('click', function () {
                            const snackId = $(this).data('id');
                            const snackName = $(this).data('name');
                            const snackPrice = $(this).data('price');
                            const snackDescription = $(this).data('description');
                            const snackCategory = $(this).data('category');

                            $('#editSnackId').val(snackId);
                            $('#editSnackName').val(snackName);
                            $('#editSnackPrice').val(snackPrice);
                            $('#editSnackDescription').val(snackDescription);
                            $('#editSnackCategory').val(snackCategory);

                            $('#editSnackModal').css('display', 'block');
                        });

                        $('.close').on('click', function () {
                            $('#editSnackModal').css('display', 'none');
                        });

                        $(window).on('click', function (event) {
                            if ($(event.target).is('#editSnackModal')) {
                                $('#editSnackModal').css('display', 'none');
                            }
                        });

                        $('#editSnackForm').on('submit', function (event) {
                            event.preventDefault();
                            // Perform AJAX form submission here if needed
                            this.submit();
                        });
                    });

                    function deleteSnack(snackId) {
                        if (confirm('Are you sure you want to delete this snack?')) {
                            window.location.href = 'admin/deleteSnack?id=' + snackId;
                        }
                    }

                    $(document).ready(function () {
                        $('#addSnackForm').on('submit', function (event) {
                            event.preventDefault(); // Prevent normal form submission

                            let formData = new FormData(this); // Automatically captures all form fields

                            // Debug: Print form data to check values
                            for (let pair of formData.entries()) {
                                console.log(pair[0] + ', ' + pair[1]);
                            }

                            $.ajax({
                                url: "http://localhost:8080/SnacksCorner/admin/addSnack",
                                type: "POST",
                                data: formData,
                                processData: false, // Prevents jQuery from converting the data into a query string
                                contentType: false, // Prevents jQuery from setting content type (it must be multipart/form-data)
                                success: function (response) {
                                    alert("Snack added successfully!");
                                    location.reload(); // Reload page after success
                                },
                                error: function (xhr, status, error) {
                                    console.error("Error:", xhr.responseText);
                                    alert("Failed to add snack: " + xhr.responseText);
                                }
                            });
                        });
                    });



        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                            $(document).ready(function () {
                                $(".view-orders-btn").click(function (e) {
                                    e.preventDefault(); // Prevent form submission
                                    var userId = $(this).data("userid");

                                    $.ajax({
                                        type: "POST",
                                        url: "http://localhost:8080/SnacksCorner/admin/customerOrders",
                                        data: {id: userId},
                                        dataType: "json",
                                        contentType: "application/x-www-form-urlencoded", // Important for form data
                                        headers: {
                                            "Accept": "application/json"  // Ensures server returns JSON
                                        },
                                        success: function (response) {
                                            console.log(response); // Debugging

                                            // Update modal content
                                            $("#customerName").text(response.customerName);
                                            var ordersTableBody = $("#ordersModal tbody");
                                            ordersTableBody.empty();

                                            if (response.orders.length > 0) {
                                                $.each(response.orders, function (index, order) {
                                                    ordersTableBody.append(
                                                            "<tr>" +
                                                            "<td>" + order.orderId + "</td>" +
                                                            "<td>" + order.snack.name + "</td>" +
                                                            "<td>" + order.snack.price + "</td>" +
                                                            "<td>" + order.orderDate + "</td>" +
                                                            "</tr>"
                                                            );
                                                });
                                            } else {
                                                ordersTableBody.append("<tr><td colspan='4'>No orders found</td></tr>");
                                            }

                                            $("#ordersModal").modal("show");
                                        },
                                        error: function (xhr, status, error) {
                                            console.error("Error fetching orders:", xhr.responseText);
                                            alert("Failed to fetch orders. Check console for details.");
                                        }
                                    });
                                });
                            });
        </script>


    </body>
</html>
