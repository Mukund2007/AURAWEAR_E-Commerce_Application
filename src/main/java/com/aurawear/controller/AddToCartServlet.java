package com.aurawear.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.User;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(401);
            return;
        }

        // ✅ FIXED: session stores a User object, not a plain String
        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        String idParam    = request.getParameter("id");
        String size       = request.getParameter("size");
        String priceParam = request.getParameter("price");

        if (idParam == null || priceParam == null || size == null) {
            response.setStatus(400);
            return;
        }

        int productId = Integer.parseInt(idParam);
        int price     = Integer.parseInt(priceParam);

        CartDAO dao = new CartDAO();
        dao.addToCart(email, productId, size, price);

        response.setStatus(200);
    }
}