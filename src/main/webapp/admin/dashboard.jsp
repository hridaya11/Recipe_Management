<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Recipe Management System</title>
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
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
        }
        .card a {
            display: inline-block;
            margin-top: 10px;
            background-color: #4CAF50;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
        }
        .card a:hover {
            background-color: #45a049;
        }
        .recent-activity {
            margin-top: 30px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .recent-activity h3 {
            margin-top: 0;
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
<header>
    <div class="logo">Recipe Management System</div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
            <li><a href="${pageContext.request.contextPath}/recipes">All Recipes</a></li>
            <li><a href="${pageContext.request.contextPath}/recipes/pending">Pending Recipes</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </nav>
</header>

<div class="container">
    <h2>Admin Dashboard</h2>
    <p>Welcome, ${user.username}!</p>

    <div class="dashboard-cards">
        <div class="card">
            <h3>Users</h3>
            <p>${totalUsers}</p>
            <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
        </div>
        <div class="card">
            <h3>Total Recipes</h3>
            <p>${totalRecipes}</p>
            <a href="${pageContext.request.contextPath}/recipes">View All</a>
        </div>
        <div class="card">
            <h3>Pending Recipes</h3>
            <p>${pendingRecipes}</p>
            <a href="${pageContext.request.contextPath}/recipes/pending">Review</a>
        </div>
    </div>

    <div class="recent-activity">
        <h3>System Overview</h3>
        <p>Welcome to the Recipe Management System admin dashboard. From here, you can manage users, review recipes, and monitor system activity.</p>
        <p>Key responsibilities:</p>
        <ul>
            <li>Approve or reject submitted recipes</li>
            <li>Manage user accounts</li>
            <li>Ensure content quality and appropriateness</li>
        </ul>
    </div>
</div>
</body>
</html>