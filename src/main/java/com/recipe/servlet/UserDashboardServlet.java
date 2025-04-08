package com.recipe.servlet;

import com.recipe.dao.RecipeDAO;
import com.recipe.model.Recipe;
import com.recipe.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {
    private RecipeDAO recipeDAO;

    @Override
    public void init() {
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
        
        // Check if user is not admin
        User currentUser = (User) session.getAttribute("user");
        if ("admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        // Get user's recipes
        List<Recipe> userRecipes = recipeDAO.getRecipesByUserId(currentUser.getId());
        
        // Get counts for different statuses
        int pendingCount = 0;
        int approvedCount = 0;
        int rejectedCount = 0;
        
        for (Recipe recipe : userRecipes) {
            if ("pending".equals(recipe.getStatus())) {
                pendingCount++;
            } else if ("approved".equals(recipe.getStatus())) {
                approvedCount++;
            } else if ("rejected".equals(recipe.getStatus())) {
                rejectedCount++;
            }
        }
        
        // Set attributes for the dashboard
        request.setAttribute("totalRecipes", userRecipes.size());
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);
        
        // Forward to the dashboard page
        request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
    }
}