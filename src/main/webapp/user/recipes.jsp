<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Recipes - Recipe Management System</title>
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
        .add-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .add-button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .status-pending {
            color: #ff9800;
            font-weight: bold;
        }
        .status-approved {
            color: #4CAF50;
            font-weight: bold;
        }
        .status-rejected {
            color: #f44336;
            font-weight: bold;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .btn-view {
            background-color: #2196F3;
        }
        .btn-edit {
            background-color: #ff9800;
        }
        .btn-delete {
            background-color: #f44336;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
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
        <h2>My Recipes</h2>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/recipes/add" class="add-button">Add New Recipe</a>
        
        <c:choose>
            <c:when test="${empty recipes}">
                <p>You haven't added any recipes yet.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="recipe" items="${recipes}">
                            <tr>
                                <td>${recipe.id}</td>
                                <td>${recipe.name}</td>
                                <td>${recipe.category == 'veg' ? 'Vegetarian' : 'Non-Vegetarian'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${recipe.status == 'pending'}">
                                            <span class="status-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${recipe.status == 'approved'}">
                                            <span class="status-approved">Approved</span>
                                        </c:when>
                                        <c:when test="${recipe.status == 'rejected'}">
                                            <span class="status-rejected">Rejected</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${recipe.createdAt}</td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/recipes/view/${recipe.id}" class="btn btn-view">View</a>
                                    <a href="${pageContext.request.contextPath}/recipes/edit/${recipe.id}" class="btn btn-edit">Edit</a>
                                    <form action="${pageContext.request.contextPath}/recipes/delete/${recipe.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this recipe?');">
                                        <button type="submit" class="btn btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>