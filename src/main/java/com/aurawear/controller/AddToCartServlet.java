package com.aurawear.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.aurawear.dao.CartDAO;
import com.aurawear.dao.ProductDAO;
import com.aurawear.model.Product;
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

        // ── Out-of-Stock guard ──
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);
        if (product == null || !product.isInStock()) {
            response.setContentType("application/json");
            response.setStatus(200);
            PrintWriter out = response.getWriter();
            out.print("{\"success\":false,\"message\":\"This item is out of stock\"}");
            return;
        }

        CartDAO dao = new CartDAO();
        dao.addToCart(email, productId, size, price);

        response.setContentType("application/json");
        response.setStatus(200);
        PrintWriter out = response.getWriter();
        out.print("{\"success\":true}");
    }
}