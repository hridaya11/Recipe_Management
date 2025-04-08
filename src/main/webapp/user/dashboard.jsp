<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Recipe Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        nav ul {
            list-style-type: none;
            display: flex;
            margin: 0;
            padding: 0;
        }
        nav ul li {
            margin-left: 20px;
        }
        nav ul li a {
            color: white;
            text-decoration: none;
        }
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        .card h3 {
            margin-top: 0;
            color: #333;
        }
        .card p {
            font-size: 18px;
            color: #666;
            margin-bottom: 20px;
        }
        .card .stat {
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 15px;
        }
        .card a {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
        }
        .card a:hover {
            background-color: #45a049;
        }
        .status-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 30px;
        }
        .status-card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
        }
        .status-card h4 {
            margin-top: 0;
            color: #333;
        }
        .status-card .count {
            font-size: 20px;
            font-weight: bold;
        }
        .pending {
            color: #ff9800;
        }
        .approved {
            color: #4CAF50;
        }
        .rejected {
            color: #f44336;
        }
    </style>
</head>
<body>
<header>
    <div class="logo">Recipe Management System</div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/recipes">My Recipes</a></li>
            <li><a href="${pageContext.request.contextPath}/recipes/add">Add Recipe</a></li>
            <li><a href="${pageContext.request.contextPath}/recipes/category/veg">Vegetarian</a></li>
            <li><a href="${pageContext.request.contextPath}/recipes/category/non-veg">Non-Vegetarian</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </nav>
</header>

<div class="container">
    <h2>User Dashboard</h2>
    <p>Welcome, ${user.username}!</p>

    <div class="dashboard-cards">
        <div class="card">
            <h3>My Recipes</h3>
            <div class="stat">${totalRecipes}</div>
            <p>View all your submitted recipes</p>
            <a href="${pageContext.request.contextPath}/recipes">View Recipes</a>
        </div>
        <div class="card">
            <h3>Add New Recipe</h3>
            <p>Share your culinary creations with the community</p>
            <a href="${pageContext.request.contextPath}/recipes/add">Add Recipe</a>
        </div>
        <div class="card">
            <h3>Browse Recipes</h3>
            <p>Explore recipes by category</p>
            <div style="display: flex; gap: 10px; justify-content: center;">
                <a href="${pageContext.request.contextPath}/recipes/category/veg">Vegetarian</a>
                <a href="${pageContext.request.contextPath}/recipes/category/non-veg">Non-Vegetarian</a>
            </div>
        </div>
    </div>

    <h3 style="margin-top: 30px;">Recipe Status</h3>
    <div class="status-cards">
        <div class="status-card">
            <h4>Pending</h4>
            <div class="count pending">${pendingCount}</div>
        </div>
        <div class="status-card">
            <h4>Approved</h4>
            <div class="count approved">${approvedCount}</div>
        </div>
        <div class="status-card">
            <h4>Rejected</h4>
            <div class="count rejected">${rejectedCount}</div>
        </div>
    </div>
</div>
</body>
</html>