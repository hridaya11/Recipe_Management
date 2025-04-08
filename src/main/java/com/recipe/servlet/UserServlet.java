package com.recipe.servlet;

import com.recipe.dao.UserDAO;
import com.recipe.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users/*")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        if (!"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all users
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Edit user form
            int userId = Integer.parseInt(pathInfo.substring(6));
            User user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/admin/edit-user.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            }
        } else if (pathInfo.equals("/add")) {
            // Add user form
            request.getRequestDispatcher("/admin/add-user.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        if (!"admin".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/add")) {
            // Add new user
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            
            User newUser = new User(username, password, email, role);
            boolean success = userDAO.createUser(newUser);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("errorMessage", "Failed to create user");
                request.getRequestDispatcher("/admin/add-user.jsp").forward(request, response);
            }
        } else if (pathInfo.startsWith("/edit/")) {
            // Update existing user
            int userId = Integer.parseInt(pathInfo.substring(6));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            
            User user = new User(userId, username, password, email, role, null);
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("errorMessage", "Failed to update user");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/admin/edit-user.jsp").forward(request, response);
            }
        } else if (pathInfo.startsWith("/delete/")) {
            // Delete user
            int userId = Integer.parseInt(pathInfo.substring(8));
            boolean success = userDAO.deleteUser(userId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("errorMessage", "Failed to delete user");
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}