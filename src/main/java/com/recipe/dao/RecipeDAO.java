package com.recipe.dao;

import com.recipe.model.Recipe;
import com.recipe.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecipeDAO {
    
    // Create a new recipe
    public boolean createRecipe(Recipe recipe) {
        String sql = "INSERT INTO recipes (user_id, name, category, ingredients, instructions, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, recipe.getUserId());
            pstmt.setString(2, recipe.getName());
            pstmt.setString(3, recipe.getCategory());
            pstmt.setString(4, recipe.getIngredients());
            pstmt.setString(5, recipe.getInstructions());
            pstmt.setString(6, recipe.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get recipe by ID
    public Recipe getRecipeById(int id) {
        String sql = "SELECT r.*, u.username FROM recipes r JOIN users u ON r.user_id = u.id WHERE r.id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Recipe recipe = extractRecipeFromResultSet(rs);
                recipe.setUsername(rs.getString("username"));
                return recipe;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get all recipes
    public List<Recipe> getAllRecipes() {
        List<Recipe> recipes = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM recipes r JOIN users u ON r.user_id = u.id";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Recipe recipe = extractRecipeFromResultSet(rs);
                recipe.setUsername(rs.getString("username"));
                recipes.add(recipe);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return recipes;
    }
    
    // Get recipes by user ID
    public List<Recipe> getRecipesByUserId(int userId) {
        List<Recipe> recipes = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM recipes r JOIN users u ON r.user_id = u.id WHERE r.user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Recipe recipe = extractRecipeFromResultSet(rs);
                recipe.setUsername(rs.getString("username"));
                recipes.add(recipe);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return recipes;
    }
    
    // Get recipes by category
    public List<Recipe> getRecipesByCategory(String category) {
        List<Recipe> recipes = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM recipes r JOIN users u ON r.user_id = u.id WHERE r.category = ? AND r.status = 'approved'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Recipe recipe = extractRecipeFromResultSet(rs);
                recipe.setUsername(rs.getString("username"));
                recipes.add(recipe);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return recipes;
    }
    
    // Get pending recipes for admin approval
    public List<Recipe> getPendingRecipes() {
        List<Recipe> recipes = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM recipes r JOIN users u ON r.user_id = u.id WHERE r.status = 'pending'";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Recipe recipe = extractRecipeFromResultSet(rs);
                recipe.setUsername(rs.getString("username"));
                recipes.add(recipe);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return recipes;
    }
    
    // Update recipe
    public boolean updateRecipe(Recipe recipe) {
        String sql = "UPDATE recipes SET name = ?, category = ?, ingredients = ?, instructions = ?, status = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, recipe.getName());
            pstmt.setString(2, recipe.getCategory());
            pstmt.setString(3, recipe.getIngredients());
            pstmt.setString(4, recipe.getInstructions());
            pstmt.setString(5, recipe.getStatus());
            pstmt.setInt(6, recipe.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update recipe status (for admin approval)
    public boolean updateRecipeStatus(int id, String status) {
        String sql = "UPDATE recipes SET status = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete recipe
    public boolean deleteRecipe(int id) {
        String sql = "DELETE FROM recipes WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to extract recipe from ResultSet
    private Recipe extractRecipeFromResultSet(ResultSet rs) throws SQLException {
        return new Recipe(
            rs.getInt("id"),
            rs.getInt("user_id"),
            rs.getString("name"),
            rs.getString("category"),
            rs.getString("ingredients"),
            rs.getString("instructions"),
            rs.getString("status"),
            rs.getTimestamp("created_at")
        );
    }
}