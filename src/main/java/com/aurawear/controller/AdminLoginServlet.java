package com.aurawear.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.aurawear.dao.LoginDAO;
import com.aurawear.dao.UserDAO;
import com.aurawear.model.User;

public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginDAO loginDAO = new LoginDAO();
        UserDAO userDAO = new UserDAO();

        if (loginDAO.validateUser(email, password)) {
            User user = userDAO.getUserByEmail(email);
            if (user != null && "admin".equals(user.getRole())) {
                // Session fixation protection: invalidate old session
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                request.setAttribute("error", "Access denied. Admin role required.");
                request.getRequestDispatcher("/WEB-INF/views/admin/admin-login.jsp")
                       .forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-login.jsp")
                   .forward(request, response);
        }
    }
}
