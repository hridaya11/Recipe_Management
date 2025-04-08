package com.recipe.model;

import java.sql.Timestamp;

public class Recipe {
    private int id;
    private int userId;
    private String name;
    private String category;
    private String ingredients;
    private String instructions;
    private String status;
    private Timestamp createdAt;
    private String username; // For joining with user table

    public Recipe() {
    }

    public Recipe(int id, int userId, String name, String category, String ingredients, 
                 String instructions, String status, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.category = category;
        this.ingredients = ingredients;
        this.instructions = instructions;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Constructor without id, status and createdAt for new recipe creation
    public Recipe(int userId, String name, String category, String ingredients, String instructions) {
        this.userId = userId;
        this.name = name;
        this.category = category;
        this.ingredients = ingredients;
        this.instructions = instructions;
        this.status = "pending";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}