<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recipe Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .hero {
            background-color: #4CAF50;
            color: white;
            padding: 60px 20px;
            text-align: center;
        }
        .hero h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 1.2em;
            max-width: 800px;
            margin: 0 auto 30px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        .feature-card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }
        .feature-card h3 {
            color: #4CAF50;
            margin-top: 0;
        }
        .feature-card p {
            color: #666;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-outline {
            background-color: transparent;
            border: 2px solid white;
        }
        .btn-outline:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
<div class="hero">
    <h1>Welcome to Recipe Management System</h1>
    <p>A platform for sharing and discovering delicious recipes. Users can submit their favorite recipes, and administrators manage the content to ensure quality.</p>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline">Login</a>
</div>

<div class="container">
    <h2 style="text-align: center; margin-bottom: 30px;">Features</h2>

    <div class="features">
        <div class="feature-card">
            <h3>Share Your Recipes</h3>
            <p>Submit your favorite recipes with detailed ingredients and cooking instructions for others to enjoy.</p>
        </div>

        <div class="feature-card">
            <h3>Discover New Dishes</h3>
            <p>Browse through a variety of recipes categorized as vegetarian and non-vegetarian to find your next meal inspiration.</p>
        </div>

        <div class="feature-card">
            <h3>Quality Content</h3>
            <p>All recipes are reviewed by administrators to ensure high-quality, accurate, and appropriate content.</p>
        </div>
    </div>

    <div style="text-align: center; margin-top: 40px;">
        <a href="${pageContext.request.contextPath}/login" class="btn">Get Started</a>
    </div>
</div>

<footer>
    <p>&copy; 2023 Recipe Management System. All rights reserved.</p>
</footer>
</body>
</html>