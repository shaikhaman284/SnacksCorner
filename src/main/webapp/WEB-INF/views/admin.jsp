<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.snackcorner.app.model.Snack" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Admin Dashboard | Snacks Corner</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="icon" href="data:," />

        <style>
            /* Reset and Base Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                color: #333;
                line-height: 1.6;
                overflow-x: hidden;
            }

            /* Header Styles */
            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: linear-gradient(135deg, #ff6347 0%, #ff8a75 100%);
                padding: 20px 30px;
                color: #ffffff;
                box-shadow: 0 4px 20px rgba(255, 99, 71, 0.3);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .header-container h1 {
                font-size: 2.2rem;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .header-container h1::before {
                content: '👨‍💼';
                font-size: 2rem;
                animation: bounce 2s infinite;
            }

            @keyframes bounce {
                0%, 20%, 50%, 80%, 100% {
                    transform: translateY(0);
                }
                40% {
                    transform: translateY(-5px);
                }
                60% {
                    transform: translateY(-3px);
                }
            }

            .auth-links {
                list-style: none;
                display: flex;
                align-items: center;
            }

            .btn-secondary {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: 2px solid rgba(255, 255, 255, 0.5);
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .btn-secondary::before {
                content: '🚪';
            }

            .btn-secondary:hover {
                background: white;
                color: #ff6347;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255,255,255,0.3);
            }

            /* Alert Messages */
            .alert {
                padding: 20px;
                margin: 20px auto;
                border-radius: 15px;
                text-align: center;
                width: 90%;
                max-width: 600px;
                font-weight: 600;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                animation: slideInDown 0.5s ease;
            }

            @keyframes slideInDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .success {
                background: rgba(40, 167, 69, 0.1);
                color: #155724;
                border-left: 5px solid #28a745;
            }

            .error {
                background: rgba(220, 53, 69, 0.1);
                color: #721c24;
                border-left: 5px solid #dc3545;
            }

            /* Dashboard Grid */
            .dashboard-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
                gap: 30px;
                padding: 30px;
                max-width: 1400px;
                margin: 0 auto;
            }

            /* Section Cards */
            section {
                background: white;
                border-radius: 20px;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                border: 2px solid transparent;
                transition: all 0.4s ease;
                position: relative;
            }

            section::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #ff6347, #ff8a75);
                transition: left 0.4s ease;
            }

            section:hover::before {
                left: 0;
            }

            section:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 50px rgba(255, 99, 71, 0.15);
                border-color: #ff6347;
            }

            section h2 {
                color: #ff6347;
                font-size: 1.8rem;
                font-weight: 700;
                margin-bottom: 25px;
                padding: 25px 30px 0;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .snacks-management h2::before {
                content: '➕';
                font-size: 1.5rem;
            }

            .snacks-list h2::before {
                content: '🍿';
                font-size: 1.5rem;
            }

            .customers-list h2::before {
                content: '👥';
                font-size: 1.5rem;
            }

            .orders-billing h2::before {
                content: '📦';
                font-size: 1.5rem;
            }

            /* Scrollable Sections */
            .snacks-list,
            .customers-list,
            .orders-billing {
                height: 600px;
                overflow-y: auto;
            }

            /* Form Styles */
            .add-snack-form,
            .edit-snack-form {
                padding: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
                font-size: 1rem;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .form-group input[type="text"],
            .form-group input[type="file"],
            .form-group textarea {
                width: 100%;
                padding: 14px 18px;
                border: 2px solid #e0e0e0;
                border-radius: 12px;
                font-size: 1rem;
                font-family: 'Poppins', sans-serif;
                background: rgba(255, 255, 255, 0.9);
                transition: all 0.3s ease;
            }

            .form-group input:focus,
            .form-group textarea:focus {
                border-color: #ff6347;
                outline: none;
                background: rgba(255, 99, 71, 0.05);
                box-shadow: 0 0 0 3px rgba(255, 99, 71, 0.1);
                transform: translateY(-2px);
            }

            .form-group textarea {
                resize: vertical;
                min-height: 100px;
            }

            /* File Upload Styling */
            .file-upload-wrapper {
                position: relative;
                overflow: hidden;
                display: inline-block;
                width: 100%;
            }

            .file-upload-wrapper input[type=file] {
                position: absolute;
                left: -9999px;
            }

            .file-upload-label {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                padding: 14px 18px;
                border: 2px dashed #ff6347;
                border-radius: 12px;
                background: rgba(255, 99, 71, 0.05);
                color: #ff6347;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 600;
            }

            .file-upload-label::before {
                content: '📁';
                font-size: 1.2rem;
            }

            .file-upload-label:hover {
                background: rgba(255, 99, 71, 0.1);
                border-color: #e55342;
            }

            .file-upload-preview {
                margin-top: 10px;
                text-align: center;
            }

            .file-upload-preview img {
                max-width: 150px;
                max-height: 150px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            }

            /* Button Styles */
            .btn {
                padding: 12px 25px;
                font-size: 1rem;
                font-weight: 600;
                color: white;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                position: relative;
                overflow: hidden;
            }

            .btn::after {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
                transition: left 0.6s ease;
            }

            .btn:hover::after {
                left: 100%;
            }

            .btn-primary {
                background: linear-gradient(135deg, #ff6347, #ff8a75);
                box-shadow: 0 5px 15px rgba(255, 99, 71, 0.3);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #e55342, #ff6347);
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(255, 99, 71, 0.4);
            }

            .cta {
                width: 100%;
                justify-content: center;
                padding: 15px;
                font-size: 1.1rem;
            }

            .cta::before {
                content: '✅';
            }

            /* Table Styles */
            .table-responsive {
                overflow-x: auto;
                margin: 0 20px 20px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 12px;
                overflow: hidden;
            }

            table th {
                background: linear-gradient(135deg, #ff6347, #ff8a75);
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-weight: 600;
                font-size: 0.95rem;
            }

            table td {
                padding: 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 0.9rem;
            }

            table tbody tr {
                transition: background-color 0.3s ease;
            }

            table tbody tr:hover {
                background-color: rgba(255, 99, 71, 0.05);
            }

            table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Action Buttons */
            .actions {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .edit,
            .delete {
                color: #ff6347;
                cursor: pointer;
                font-weight: 600;
                padding: 5px 10px;
                border-radius: 15px;
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }

            .edit:hover {
                background: rgba(255, 99, 71, 0.1);
                color: #e55342;
            }

            .delete:hover {
                background: rgba(220, 53, 69, 0.1);
                color: #dc3545;
            }

            .view-orders-btn {
                font-size: 0.8rem;
                padding: 6px 12px;
            }

            .view-orders-btn::before {
                content: '👁️';
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(5px);
            }

            .modal-dialog {
                margin: 3% auto;
                max-width: 600px;
                animation: modalSlideIn 0.3s ease;
            }

            @keyframes modalSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(-30px) scale(0.95);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            .modal-content {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                overflow: hidden;
                position: relative;
            }

            .modal-content::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #ff6347, #ff8a75);
            }

            .modal-header {
                padding: 25px 30px 15px;
                border-bottom: 1px solid #f0f0f0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #ff6347;
            }

            .close {
                color: #aaa;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
                transition: color 0.3s ease;
            }

            .close:hover {
                color: #ff6347;
            }

            .modal-body {
                padding: 20px 30px 30px;
            }

            .edit-snack-form h2 {
                padding: 0;
                margin-bottom: 20px;
            }

            /* Mobile Responsive */
            @media (max-width: 768px) {
                .header-container {
                    flex-direction: column;
                    gap: 15px;
                    padding: 20px 15px;
                    text-align: center;
                }

                .header-container h1 {
                    font-size: 1.8rem;
                }

                .dashboard-container {
                    grid-template-columns: 1fr;
                    padding: 20px 15px;
                    gap: 20px;
                }

                section {
                    margin: 0;
                }

                section h2 {
                    font-size: 1.5rem;
                    padding: 20px 20px 0;
                }

                .add-snack-form,
                .edit-snack-form {
                    padding: 20px;
                }

                .snacks-list,
                .customers-list,
                .orders-billing {
                    height: auto;
                    max-height: 400px;
                }

                .table-responsive {
                    margin: 0 10px 10px;
                }

                table {
                    font-size: 0.85rem;
                }

                table th,
                table td {
                    padding: 8px 6px;
                }

                .mobile-hide {
                    display: none;
                }

                .actions {
                    flex-direction: column;
                    gap: 5px;
                }

                .btn {
                    font-size: 0.9rem;
                    padding: 10px 15px;
                }

                .view-orders-btn {
                    font-size: 0.75rem;
                    padding: 5px 10px;
                }

                .modal-dialog {
                    margin: 5% 10px;
                    max-width: none;
                }

                .modal-header,
                .modal-body {
                    padding: 20px;
                }

                .alert {
                    width: 95%;
                    padding: 15px;
                }
            }

            @media (max-width: 480px) {
                .header-container h1 {
                    font-size: 1.5rem;
                }

                .dashboard-container {
                    padding: 15px 10px;
                }

                section h2 {
                    font-size: 1.3rem;
                    padding: 15px 15px 0;
                }

                .add-snack-form,
                .edit-snack-form {
                    padding: 15px;
                }

                .form-group input,
                .form-group textarea {
                    padding: 12px 15px;
                    font-size: 0.9rem;
                }

                .snacks-list,
                .customers-list,
                .orders-billing {
                    max-height: 300px;
                }

                table {
                    font-size: 0.8rem;
                }

                table th,
                table td {
                    padding: 6px 4px;
                }

                .btn {
                    font-size: 0.85rem;
                    padding: 8px 12px;
                }

                .modal-dialog {
                    margin: 5% 5px;
                }
            }

            /* Loading States */
            .loading {
                opacity: 0.7;
                pointer-events: none;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 20px;
                height: 20px;
                border: 2px solid #f3f3f3;
                border-top: 2px solid #ff6347;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: translate(-50%, -50%) rotate(0deg);
                }
                100% {
                    transform: translate(-50%, -50%) rotate(360deg);
                }
            }

            /* Custom Scrollbar */
            section::-webkit-scrollbar {
                width: 6px;
            }

            section::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 10px;
            }

            section::-webkit-scrollbar-thumb {
                background: #ff6347;
                border-radius: 10px;
            }

            section::-webkit-scrollbar-thumb:hover {
                background: #e55342;
            }
        </style>
    </head>

    <body>
        <header class="header-container">
            <h1>Admin Dashboard</h1>
            <nav class="nav-right">
                <ul class="auth-links">
                    <form action="<c:url value='/logout'/>" method="post" style="margin: 0;">
                        <button type="submit" class="btn-secondary">Logout</button>
                    </form>
                </ul>
            </nav>
        </header>

        <% String message = (String) request.getAttribute("message"); %>
        <% String error = (String) request.getAttribute("error"); %>

        <% if (message != null) { %>
        <div class="alert success">✅ <%= message %></div>
        <% } %>

        <% if (error != null) { %>
        <div class="alert error">❌ <%= error %></div>
        <% } %>

        <div class="dashboard-container">
            <section class="snacks-management">
                <h2>Add New Snack</h2>
                <form id="addSnackForm" class="add-snack-form" action="admin/addSnack" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="name">🏷️ Snack Name:</label>
                        <input type="text" id="name" name="name" required placeholder="Enter snack name">
                    </div>

                    <div class="form-group">
                        <label for="price">💰 Snack Price:</label>
                        <input type="text" id="price" name="price" required placeholder="Enter price (e.g., 25.99)">
                    </div>

                    <div class="form-group">
                        <label for="description">📝 Description:</label>
                        <textarea id="description" name="description" required placeholder="Enter snack description"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="category">📂 Category:</label>
                        <input type="text" id="category" name="category" required placeholder="Enter category">
                    </div>

                    <div class="form-group">
                        <label for="image">📸 Upload Image:</label>
                        <div class="file-upload-wrapper">
                            <input type="file" id="image" name="imageFile" accept="image/*" required onchange="previewImage(this, 'imagePreview')">
                            <label for="image" class="file-upload-label">
                                Choose Image File
                            </label>
                        </div>
                        <div id="imagePreview" class="file-upload-preview"></div>
                    </div>

                    <button class="btn btn-primary cta" type="submit">Add Snack</button>
                </form>
            </section>

            <section class="snacks-list">
                <h2>Snacks List</h2>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Price</th>
                                <th class="mobile-hide">Description</th>
                                <th class="mobile-hide">Category</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="snack" items="${snacks}">
                                <tr>
                                    <td>${snack.name}</td>
                                    <td>₹${snack.price}</td>
                                    <td class="mobile-hide">${snack.description}</td>
                                    <td class="mobile-hide">${snack.category}</td>
                                    <td class="actions">
                                        <span class="edit" 
                                              data-id="${snack.snackid}" 
                                              data-name="${snack.name}" 
                                              data-price="${snack.price}" 
                                              data-description="${snack.description}" 
                                              data-category="${snack.category}"
                                              data-image="${snack.imagePath}">✏️ Edit</span>
                                        <span class="delete" onclick="deleteSnack(${snack.snackid})">🗑️ Delete</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>

            <section class="customers-list">
                <h2>Registered Customers</h2>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th class="mobile-hide">Number</th>
                                <th>Email</th>
                                <th class="mobile-hide">City</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${customers}">
                                <tr>
                                    <td>${customer.name}</td>
                                    <td class="mobile-hide">${customer.number}</td>
                                    <td>${customer.email}</td>
                                    <td class="mobile-hide">${customer.city}</td>
                                    <td>
                                        <button class="btn btn-primary view-orders-btn" data-userid="${customer.userid}">
                                            View Orders
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>

            <section class="orders-billing">
                <h2>All Orders</h2>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Snack</th>
                                <th>Price</th>
                                <th class="mobile-hide">Order Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>#${order.orderId}</td>
                                    <td>${order.user.name}</td>
                                    <td>${order.snack.name}</td>
                                    <td>₹${order.snack.price}</td>
                                    <td class="mobile-hide">${order.orderDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Edit Snack Modal -->
        <div id="editSnackModal" class="modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">✏️ Edit Snack</h5>
                        <span class="close">&times;</span>
                    </div>
                    <div class="modal-body">
                        <form id="editSnackForm" class="edit-snack-form" action="admin/updateSnack" method="post" enctype="multipart/form-data">
                            <input type="hidden" id="editSnackId" name="snackid">

                            <div class="form-group">
                                <label for="editSnackName">🏷️ Snack Name:</label>
                                <input type="text" id="editSnackName" name="name" required>
                            </div>

                            <div class="form-group">
                                <label for="editSnackPrice">💰 Snack Price:</label>
                                <input type="text" id="editSnackPrice" name="price" required>
                            </div>

                            <div class="form-group">
                                <label for="editSnackDescription">📝 Description:</label>
                                <textarea id="editSnackDescription" name="description" required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="editSnackCategory">📂 Category:</label>
                                <input type="text" id="editSnackCategory" name="category" required>
                            </div>

                            <div class="form-group">
                                <label for="editImage">📸 Update Image (Optional):</label>
                                <div class="file-upload-wrapper">
                                    <input type="file" id="editImage" name="imageFile" accept="image/*" onchange="previewImage(this, 'editImagePreview')">
                                    <label for="editImage" class="file-upload-label">
                                        Choose New Image (Optional)
                                    </label>
                                </div>
                                <div id="editImagePreview" class="file-upload-preview"></div>
                            </div>

                            <button class="btn btn-primary cta" type="submit">💾 Update Snack</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders Modal -->
        <div id="ordersModal" class="modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">📦 Orders for <span id="customerName"></span></h5>
                        <span class="close" onclick="closeOrdersModal()">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div id="ordersContent">
                            <!-- Orders will be dynamically loaded here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
// Image preview function
            function previewImage(input, previewId) {
                const preview = document.getElementById(previewId);
                const file = input.files[0];

                // Clear existing content and revoke any existing object URLs
                const existingImg = preview.querySelector('img');
                if (existingImg && existingImg.src.startsWith('blob:')) {
                    URL.revokeObjectURL(existingImg.src);
                }
                preview.innerHTML = '';

                if (file && file.type.startsWith('image/')) {
                    try {
                        // Use createObjectURL instead of FileReader
                        const objectURL = URL.createObjectURL(file);

                        const img = document.createElement('img');
                        img.onload = function () {
                            console.log('IMAGE LOADED SUCCESSFULLY with ObjectURL');
                            // Revoke the object URL after image loads to free memory
                            URL.revokeObjectURL(objectURL);
                        };

                        img.onerror = function () {
                            console.error('IMAGE FAILED TO LOAD with ObjectURL');
                            URL.revokeObjectURL(objectURL);
                            preview.innerHTML = '<p>Failed to display image.</p>';
                        };

                        img.src = objectURL;
                        img.alt = 'Preview';

                        preview.appendChild(img);

                    } catch (error) {
                        console.error('Error creating object URL:', error);
                        preview.innerHTML = '<p>Error loading image preview.</p>';
                    }

                    // Update label
                    const label = input.nextElementSibling;
                    if (label) {
                        label.textContent = file.name;
                    }
                } else {
                    preview.innerHTML = '';
                    const label = input.nextElementSibling;
                    if (label) {
                        label.textContent = 'Choose Image File';
                    }
                }
            }



            $(document).ready(function () {
                // Edit snack modal
                $('.edit').on('click', function () {
                    const snackId = $(this).data('id');
                    const snackName = $(this).data('name');
                    const snackPrice = $(this).data('price');
                    const snackDescription = $(this).data('description');
                    const snackCategory = $(this).data('category');
                    const snackImage = $(this).data('image');
                    $('#editSnackId').val(snackId);
                    $('#editSnackName').val(snackName);
                    $('#editSnackPrice').val(snackPrice);
                    $('#editSnackDescription').val(snackDescription);
                    $('#editSnackCategory').val(snackCategory);

                    if (snackImage) {
                        const contextPath = '${pageContext.request.contextPath}';
                        const fullImagePath = contextPath + snackImage;
                        console.log('Full image path:', fullImagePath);
                        // Method 1: Create image element properly
                        const imgElement = $('<img>').attr({
                            'src': fullImagePath,
                            'alt': 'Current Image',
                            'style': 'max-width: 200px; height: auto;'
                        });
                        $('#editImagePreview').empty().append(imgElement);
                    }
                    // Show modal first
                    $('#editSnackModal').css('display', 'block');
                });
                // Close modal handlers
                $('.close').on('click', function () {
                    $(this).closest('.modal').css('display', 'none');
                    // Clear image previews
                    $('.file-upload-preview').html('');
                    // Reset file input labels
                    $('.file-upload-label').text('Choose Image File');
                });
                $(window).on('click', function (event) {
                    if ($(event.target).hasClass('modal')) {
                        $(event.target).css('display', 'none');
                        // Clear image previews
                        $('.file-upload-preview').html('');
                        // Reset file input labels
                        $('.file-upload-label').text('Choose Image File');
                    }
                });
                // Add snack form submission
                $('#addSnackForm').on('submit', function (event) {
                    event.preventDefault();
                    const submitBtn = $(this).find('button[type="submit"]');
                    const originalText = submitBtn.html();
                    submitBtn.html('⏳ Adding...').addClass('loading');
                    let formData = new FormData(this);
                    $.ajax({
                        url: "admin/addSnack",
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            alert("✅ Snack added successfully!");
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            console.error("Error:", xhr.responseText);
                            alert("❌ Failed to add snack: " + xhr.responseText);
                            submitBtn.html(originalText).removeClass('loading');
                        }
                    });
                });
                // Edit snack form submission
                $('#editSnackForm').on('submit', function (event) {
                    event.preventDefault();
                    const submitBtn = $(this).find('button[type="submit"]');
                    const originalText = submitBtn.html();
                    submitBtn.html('⏳ Updating...').addClass('loading');
                    let formData = new FormData(this);
                    $.ajax({
                        url: "admin/updateSnack",
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            alert("✅ Snack updated successfully!");
                            location.reload();
                        },
                        error: function (xhr, status, error) {
                            console.error("Error:", xhr.responseText);
                            alert("❌ Failed to update snack: " + xhr.responseText);
                            submitBtn.html(originalText).removeClass('loading');
                        }
                    });
                });
                // View orders functionality
                $(".view-orders-btn").click(function (e) {
                    e.preventDefault();
                    const userId = $(this).data("userid");
                    const btn = $(this);
                    const originalText = btn.html();
                    btn.html('⏳ Loading...').addClass('loading');
                    $.ajax({
                        type: "POST",
                        url: "customerOrders?userId=" + userId,
                        success: function (response) {
                            $("#ordersContent").html(response);
                            $("#ordersModal").css('display', 'block');
                            btn.html(originalText).removeClass('loading');
                        },
                        error: function (xhr, status, error) {
                            console.error("Error fetching orders:", xhr.responseText);
                            alert("❌ Failed to fetch orders. Please try again.");
                            btn.html(originalText).removeClass('loading');
                        }
                    });
                });
            });
            function deleteSnack(snackId) {
                if (confirm('⚠️ Are you sure you want to delete this snack?')) {
                    window.location.href = 'admin/deleteSnack?id=' + snackId;
                }
            }

            function closeOrdersModal() {
                $('#ordersModal').css('display', 'none');
            }

            // Auto-hide alerts
            setTimeout(() => {
                $('.alert').fadeOut('slow');
            }, 5000);
        </script>
    </body>

</html>
