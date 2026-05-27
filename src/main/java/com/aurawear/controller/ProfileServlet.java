package com.aurawear.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import com.aurawear.model.User;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Session check FIRST — before any forward
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Pass user to JSP
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);

        request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp")
               .forward(request, response);
    }
}