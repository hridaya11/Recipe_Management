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

@WebServlet("/recipes/*")
public class RecipeServlet extends HttpServlet {
    private RecipeDAO recipeDAO;

    @Override
    public void init() {
        recipeDAO = new RecipeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all recipes based on user role
            if ("admin".equals(currentUser.getRole())) {
                List<Recipe> recipes = recipeDAO.getAllRecipes();
                request.setAttribute("recipes", recipes);
                request.getRequestDispatcher("/admin/recipes.jsp").forward(request, response);
            } else {
                List<Recipe> recipes = recipeDAO.getRecipesByUserId(currentUser.getId());
                request.setAttribute("recipes", recipes);
                request.getRequestDispatcher("/user/recipes.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/add")) {
            // Add recipe form
            request.getRequestDispatcher("/user/add-recipe.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Edit recipe form
            int recipeId = Integer.parseInt(pathInfo.substring(6));
            Recipe recipe = recipeDAO.getRecipeById(recipeId);
            
            if (recipe != null) {
                // Check if user is admin or the owner of the recipe
                if ("admin".equals(currentUser.getRole()) || recipe.getUserId() == currentUser.getId()) {
                    request.setAttribute("recipe", recipe);
                    request.getRequestDispatcher("/user/edit-recipe.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Recipe not found");
            }
        } else if (pathInfo.equals("/pending") && "admin".equals(currentUser.getRole())) {
            // List pending recipes for admin approval
            List<Recipe> pendingRecipes = recipeDAO.getPendingRecipes();
            request.setAttribute("recipes", pendingRecipes);
            request.getRequestDispatcher("/admin/pending-recipes.jsp").forward(request, response);
        } else if (pathInfo.equals("/category/veg")) {
            // List vegetarian recipes
            List<Recipe> vegRecipes = recipeDAO.getRecipesByCategory("veg");
            request.setAttribute("recipes", vegRecipes);
            request.setAttribute("category", "Vegetarian");
            request.getRequestDispatcher("/user/category-recipes.jsp").forward(request, response);
        } else if (pathInfo.equals("/category/non-veg")) {
            // List non-vegetarian recipes
            List<Recipe> nonVegRecipes = recipeDAO.getRecipesByCategory("non-veg");
            request.setAttribute("recipes", nonVegRecipes);
            request.setAttribute("category", "Non-Vegetarian");
            request.getRequestDispatcher("/user/category-recipes.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/view/")) {
            // View recipe details
            int recipeId = Integer.parseInt(pathInfo.substring(6));
            Recipe recipe = recipeDAO.getRecipeById(recipeId);
            
            if (recipe != null) {
                request.setAttribute("recipe", recipe);
                request.getRequestDispatcher("/user/view-recipe.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Recipe not found");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/add")) {
            // Add new recipe
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String ingredients = request.getParameter("ingredients");
            String instructions = request.getParameter("instructions");
            
            Recipe newRecipe = new Recipe(currentUser.getId(), name, category, ingredients, instructions);
            boolean success = recipeDAO.createRecipe(newRecipe);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/recipes");
            } else {
                request.setAttribute("errorMessage", "Failed to create recipe");
                request.getRequestDispatcher("/user/add-recipe.jsp").forward(request, response);
            }
        } else if (pathInfo.startsWith("/edit/")) {
            // Update existing recipe
            int recipeId = Integer.parseInt(pathInfo.substring(6));
            Recipe existingRecipe = recipeDAO.getRecipeById(recipeId);
            
            if (existingRecipe != null) {
                // Check if user is admin or the owner of the recipe
                if ("admin".equals(currentUser.getRole()) || existingRecipe.getUserId() == currentUser.getId()) {
                    String name = request.getParameter("name");
                    String category = request.getParameter("category");
                    String ingredients = request.getParameter("ingredients");
                    String instructions = request.getParameter("instructions");
                    
                    existingRecipe.setName(name);
                    existingRecipe.setCategory(category);
                    existingRecipe.setIngredients(ingredients);
                    existingRecipe.setInstructions(instructions);
                    
                    boolean success = recipeDAO.updateRecipe(existingRecipe);
                    
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/recipes");
                    } else {
                        request.setAttribute("errorMessage", "Failed to update recipe");
                        request.setAttribute("recipe", existingRecipe);
                        request.getRequestDispatcher("/user/edit-recipe.jsp").forward(request, response);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Recipe not found");
            }
        } else if (pathInfo.startsWith("/delete/")) {
            // Delete recipe
            int recipeId = Integer.parseInt(pathInfo.substring(8));
            Recipe existingRecipe = recipeDAO.getRecipeById(recipeId);
            
            if (existingRecipe != null) {
                // Check if user is admin or the owner of the recipe
                if ("admin".equals(currentUser.getRole()) || existingRecipe.getUserId() == currentUser.getId()) {
                    boolean success = recipeDAO.deleteRecipe(recipeId);
                    
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/recipes");
                    } else {
                        request.setAttribute("errorMessage", "Failed to delete recipe");
                        response.sendRedirect(request.getContextPath() + "/recipes");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Recipe not found");
            }
        } else if (pathInfo.startsWith("/approve/") && "admin".equals(currentUser.getRole())) {
            // Approve recipe
            int recipeId = Integer.parseInt(pathInfo.substring(9));
            boolean success = recipeDAO.updateRecipeStatus(recipeId, "approved");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/recipes/pending");
            } else {
                request.setAttribute("errorMessage", "Failed to approve recipe");
                response.sendRedirect(request.getContextPath() + "/recipes/pending");
            }
        } else if (pathInfo.startsWith("/reject/") && "admin".equals(currentUser.getRole())) {
            // Reject recipe
            int recipeId = Integer.parseInt(pathInfo.substring(8));
            boolean success = recipeDAO.updateRecipeStatus(recipeId, "rejected");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/recipes/pending");
            } else {
                request.setAttribute("errorMessage", "Failed to reject recipe");
                response.sendRedirect(request.getContextPath() + "/recipes/pending");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}