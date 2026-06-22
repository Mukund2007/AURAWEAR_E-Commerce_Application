package com.aurawear.controller;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.User;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(401);
            return;
        }

        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        int productId = Integer.parseInt(request.getParameter("id"));
        String size = request.getParameter("size");
        int change = Integer.parseInt(request.getParameter("change"));

        CartDAO dao = new CartDAO();
        int newQty = dao.updateQuantity(email, productId, size, change);

        // 🔥 return JSON
        response.setContentType("application/json");
        response.getWriter().write("{\"quantity\":" + newQty + "}");
    }
}