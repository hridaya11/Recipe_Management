<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${category} Recipes - Recipe Management System</title>
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
        .recipe-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .recipe-card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        .recipe-card:hover {
            transform: translateY(-5px);
        }
        .recipe-content {
            padding: 15px;
        }
        .recipe-title {
            margin-top: 0;
            margin-bottom: 10px;
            color: #333;
        }
        .recipe-meta {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .recipe-description {
            color: #555;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .recipe-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn:hover {
            background-color: #45a049;
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
        <h2>${category} Recipes</h2>
        
        <c:choose>
            <c:when test="${empty recipes}">
                <p>No ${category.toLowerCase()} recipes found.</p>
            </c:when>
            <c:otherwise>
                <div class="recipe-grid">
                    <c:forEach var="recipe" items="${recipes}">
                        <div class="recipe-card">
                            <div class="recipe-content">
                                <h3 class="recipe-title">${recipe.name}</h3>
                                <div class="recipe-meta">By: ${recipe.username} | Added on: ${recipe.createdAt}</div>
                                <div class="recipe-description">
                                    <c:set var="ingredientsList" value="${recipe.ingredients.split('\n')}" />
                                    <c:if test="${ingredientsList.length > 0}">
                                        <p>Ingredients include: ${ingredientsList[0]}
                                        <c:if test="${ingredientsList.length > 1}">
                                            and more...
                                        </c:if>
                                        </p>
                                    </c:if>
                                </div>
                                <div class="recipe-footer">
                                    <a href="${pageContext.request.contextPath}/recipes/view/${recipe.id}" class="btn">View Recipe</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>