package com.aurawear.controller;

import java.io.IOException;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/cart-count")
public class CartCountServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ SAFE CHECK
        if (session == null || session.getAttribute("user") == null) {
            response.getWriter().print(0);
            return;
        }

        // ✅ GET USER
        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        // ✅ GET COUNT FROM DB
        CartDAO dao = new CartDAO();
        int count = dao.getCartCount(email);   // 🔥 THIS WAS MISSING

        // ✅ SEND RESPONSE
        response.setContentType("text/plain");
        response.getWriter().print(count);
    }
}