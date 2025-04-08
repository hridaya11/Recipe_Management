<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Recipes - Recipe Management System</title>
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
        .filter-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            align-items: center;
        }
        .filter-form select {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .filter-form button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
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
        <h2>All Recipes</h2>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        
        <div class="filter-form">
            <form action="${pageContext.request.contextPath}/recipes" method="get">
                <select name="status">
                    <option value="">All Statuses</option>
                    <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="approved" ${param.status == 'approved' ? 'selected' : ''}>Approved</option>
                    <option value="rejected" ${param.status == 'rejected' ? 'selected' : ''}>Rejected</option>
                </select>
                <select name="category">
                    <option value="">All Categories</option>
                    <option value="veg" ${param.category == 'veg' ? 'selected' : ''}>Vegetarian</option>
                    <option value="non-veg" ${param.category == 'non-veg' ? 'selected' : ''}>Non-Vegetarian</option>
                </select>
                <button type="submit">Filter</button>
            </form>
        </div>
        
        <c:choose>
            <c:when test="${empty recipes}">
                <p>No recipes found.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Submitted By</th>
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
                                <td>${recipe.username}</td>
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
                                    <c:if test="${recipe.status == 'pending'}">
                                        <form action="${pageContext.request.contextPath}/recipes/approve/${recipe.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-edit">Approve</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/recipes/reject/${recipe.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-delete">Reject</button>
                                        </form>
                                    </c:if>
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