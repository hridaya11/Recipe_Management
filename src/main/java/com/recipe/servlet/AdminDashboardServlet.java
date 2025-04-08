package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.dao.UserDAO;
import com.recipe.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDAO;
    private RecipeDAO recipeDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        recipeDAO = new RecipeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Check if user is admin
        User currentUser = (User) session.getAttribute("user");
        if (!"admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }
        
        // Get dashboard statistics
        int totalUsers = userDAO.getAllUsers().size();
        int totalRecipes = recipeDAO.getAllRecipes().size();
        int pendingRecipes = recipeDAO.getPendingRecipes().size();
        
        // Set attributes for the dashboard
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalRecipes", totalRecipes);
        request.setAttribute("pendingRecipes", pendingRecipes);
        
        // Forward to the dashboard page
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}