package com.aurawear.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.aurawear.dao.WishlistDAO;
import com.aurawear.model.User;

@WebServlet("/wishlist-remove")
public class WishlistRemoveServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user  = (User) session.getAttribute("user");
        String email = user.getEmail();
        String name  = request.getParameter("name");

        if (name == null || name.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        WishlistDAO dao = new WishlistDAO();
        dao.removeFromWishlist(email, name);

        response.setStatus(HttpServletResponse.SC_OK);
    }
}