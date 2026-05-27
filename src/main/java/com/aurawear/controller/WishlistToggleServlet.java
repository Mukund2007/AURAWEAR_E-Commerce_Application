package com.aurawear.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.aurawear.dao.WishlistDAO;
import com.aurawear.dao.ProductDAO;
import com.aurawear.model.Product;
import com.aurawear.model.User;

@WebServlet("/wishlist-toggle")
public class WishlistToggleServlet extends HttpServlet {

    private WishlistDAO wishlistDAO;
    private ProductDAO productDAO;

    public void init() {
        wishlistDAO = new WishlistDAO();
        productDAO  = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user  = (User) session.getAttribute("user");
        String email = user.getEmail();

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int productId = Integer.parseInt(idParam.trim());

        Product p = productDAO.getProductById(productId);

        if (p == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // FIX: getWishlistProductIds returns Set<Integer> — compare against int productId, NOT p.getName()
        boolean exists = wishlistDAO
                .getWishlistProductIds(email)
                .contains(productId);

        PrintWriter out = response.getWriter();

        if (exists) {
            wishlistDAO.removeFromWishlist(email, p.getName());
            out.print("removed");
        } else {
            wishlistDAO.addToWishlist(email, p.getName(), p.getPrice());
            out.print("added");
        }
        out.flush();
    }
}