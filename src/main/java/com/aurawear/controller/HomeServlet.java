package com.aurawear.controller;

import java.io.IOException;
import java.util.*;

import com.aurawear.dao.ProductDAO;
import com.aurawear.dao.WishlistDAO;
import com.aurawear.model.Product;
import com.aurawear.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[HOME] Request received");

        try {
            System.out.println("[HOME] Loading products from DB");
            ProductDAO dao = new ProductDAO();
            List<Product> products = dao.getTrendingProducts();
            System.out.println("[HOME] Products loaded: " + products.size());

            System.out.println("[HOME] Loading wishlist");
            WishlistDAO wishlistDAO = new WishlistDAO();
            Set<Integer> wishlistNames = new HashSet<>();
            HttpSession session = request.getSession(false);
            System.out.println("[HOME] Session present: " + (session != null));

            if (session != null) {
                Object userObj = session.getAttribute("user");
                System.out.println("[HOME] Session user attribute present: " + (userObj != null));
                if (userObj != null) {
                    User user = (User) userObj;
                    System.out.println("[HOME] User email: " + user.getEmail());
                    wishlistNames = wishlistDAO.getWishlistProductIds(user.getEmail());
                    System.out.println("[HOME] Wishlist IDs loaded: " + wishlistNames.size());
                }
            }

            request.setAttribute("products", products);
            request.setAttribute("wishlistNames", wishlistNames);

            // Disable browser caching
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            System.out.println("[HOME] Forwarding to home.jsp");
            request.getRequestDispatcher("/WEB-INF/views/home/home.jsp")
                   .forward(request, response);
            System.out.println("[HOME] Forward complete");

        } catch (Exception e) {
            System.err.println("[HOME] UNCAUGHT EXCEPTION");
            System.err.println("[HOME] Exception Type: " + e.getClass().getName());
            System.err.println("[HOME] Exception Message: " + e.getMessage());
            e.printStackTrace();
            // Rethrow so the container can return a 500 instead of silently dropping the connection
            throw new ServletException("[HOME] Fatal error loading home page", e);
        }
    }
}