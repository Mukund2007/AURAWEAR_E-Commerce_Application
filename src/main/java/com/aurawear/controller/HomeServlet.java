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

        // 🔥 GET PRODUCTS FROM DB
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getTrendingProducts();

        // 🔥 GET WISHLIST
        WishlistDAO wishlistDAO = new WishlistDAO();
        Set<Integer> wishlistNames = new HashSet<>();
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            wishlistNames = wishlistDAO.getWishlistProductIds(user.getEmail());
        }

        // 🔥 SEND TO JSP
        request.setAttribute("products", products);
        request.setAttribute("wishlistNames", wishlistNames);

        // 🔥 DISABLE BROWSER CACHING
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0); // Proxies

        // 🔥 FORWARD
        request.getRequestDispatcher("/WEB-INF/views/home/home.jsp")
               .forward(request, response);
    }
}