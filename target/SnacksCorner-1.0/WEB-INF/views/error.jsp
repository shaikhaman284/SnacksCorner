<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - Snack Corner</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-container {
            text-align: center;
            padding: 30px;
            max-width: 600px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        .error-container h1 {
            font-size: 3em;
            color: #dc3545;
        }

        .error-container p {
            font-size: 1.2em;
            margin: 10px 0;
        }

        .error-container .error-message {
            margin: 20px 0;
            font-size: 1em;
            color: #6c757d;
            word-wrap: break-word;
        }

        .error-container a {
            display: inline-block;
            margin: 10px 10px 0;
            padding: 10px 20px;
            font-size: 1em;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .error-container a:hover {
            background-color: #0056b3;
        }

        .error-container .secondary-btn {
            background-color: #6c757d;
        }

        .error-container .secondary-btn:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Error!</h1>
        <p>Something went wrong while processing your request.</p>
        <div class="error-message">
            <strong>Error Details:</strong> ${error} <!-- Displays the error passed from the controller -->
        </div>
        <a href="home">Go to Home Page</a>
        <a href="contact" class="secondary-btn">Contact Support</a>
    </div>
</body>
</html>
