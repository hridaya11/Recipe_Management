<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Recipe - Recipe Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
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
        .form-container {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], select, textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        textarea {
            height: 150px;
            resize: vertical;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-cancel {
            background-color: #f44336;
        }
        .btn-cancel:hover {
            background-color: #d32f2f;
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
                <c:choose>
                    <c:when test="${user.role == 'admin'}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
                        <li><a href="${pageContext.request.contextPath}/recipes">All Recipes</a></li>
                        <li><a href="${pageContext.request.contextPath}/recipes/pending">Pending Recipes</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/recipes">My Recipes</a></li>
                        <li><a href="${pageContext.request.contextPath}/recipes/add">Add Recipe</a></li>
                        <li><a href="${pageContext.request.contextPath}/recipes/category/veg">Vegetarian</a></li>
                        <li><a href="${pageContext.request.contextPath}/recipes/category/non-veg">Non-Vegetarian</a></li>
                    </c:otherwise>
                </c:choose>
                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </nav>
    </header>
    
    <div class="container">
        <h2>Edit Recipe</h2>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/recipes/edit/${recipe.id}" method="post">
                <div class="form-group">
                    <label for="name">Recipe Name:</label>
                    <input type="text" id="name" name="name" value="${recipe.name}" required>
                </div>
                <div class="form-group">
                    <label for="category">Category:</label>
                    <select id="category" name="category" required>
                        <option value="">Select Category</option>
                        <option value="veg" ${recipe.category == 'veg' ? 'selected' : ''}>Vegetarian</option>
                        <option value="non-veg" ${recipe.category == 'non-veg' ? 'selected' : ''}>Non-Vegetarian</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="ingredients">Ingredients:</label>
                    <textarea id="ingredients" name="ingredients" placeholder="Enter ingredients, one per line" required>${recipe.ingredients}</textarea>
                </div>
                <div class="form-group">
                    <label for="instructions">Cooking Instructions:</label>
                    <textarea id="instructions" name="instructions" placeholder="Describe the cooking process step by step" required>${recipe.instructions}</textarea>
                </div>
                <button type="submit" class="btn">Update Recipe</button>
                <a href="${pageContext.request.contextPath}/recipes" class="btn btn-cancel">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>