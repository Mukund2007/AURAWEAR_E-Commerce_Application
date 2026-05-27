package com.aurawear.controller;

import java.io.IOException;
import com.aurawear.dao.UserDAO;
import com.aurawear.model.UserProfile;
import com.aurawear.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/complete-profile")
public class CompleteProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Session check first
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/complete-profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = request.getParameter("username");
        String style    = request.getParameter("style");
        String size     = request.getParameter("size");
        String fit      = request.getParameter("fit");

        // ✅ Null-safe — interestsArr can be null if no checkboxes selected
        String[] interestsArr = request.getParameterValues("interests");
        String interests = (interestsArr != null)
                ? String.join(",", interestsArr)
                : "";

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        UserProfile profile = new UserProfile(userId, username, style, size, fit, interests);

        UserDAO dao = new UserDAO();
        boolean saved = dao.saveProfile(profile);

        if (saved) {
            System.out.println("Profile saved for userId: " + userId);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("profileError", "Profile save failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/complete-profile.jsp")
                   .forward(request, response);
        }
    }
}