package com.aurawear.controller;

import java.io.IOException;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.aurawear.dao.ProductDAO;
import com.aurawear.dao.WishlistDAO;
import com.aurawear.model.Product;
import com.aurawear.model.User;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private WishlistDAO wishlistDAO;

    public void init() {
        productDAO = new ProductDAO();
        wishlistDAO = new WishlistDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String keyword = request.getParameter("keyword");
            String sort = request.getParameter("sort");
            String gender = request.getParameter("gender");

            String[] categories = request.getParameterValues("category");
            String[] sizes = request.getParameterValues("size");
            String[] colors = request.getParameterValues("color");

            // ================= PRICE =================
            double minPrice = 0;
            double maxPrice = Double.MAX_VALUE;

            String minParam = request.getParameter("minPrice");
            String maxParam = request.getParameter("maxPrice");

            if (minParam != null && !minParam.isEmpty()) {
                minPrice = Double.parseDouble(minParam);
            }

            if (maxParam != null && !maxParam.isEmpty()) {
                maxPrice = Double.parseDouble(maxParam);
            }

            // ================= FILTER CHECK =================
            boolean hasFilters =
                    (categories != null && categories.length > 0) ||
                    (sizes != null && sizes.length > 0) ||
                    (colors != null && colors.length > 0) ||
                    (minParam != null && !minParam.isEmpty()) ||
                    (maxParam != null && !maxParam.isEmpty()) ||
                    (gender != null && !gender.isEmpty()) ||
                    (sort != null && !sort.isEmpty());

            // ================= DATA FETCH =================
            List<Product> products;

            if (hasFilters) {
                products = productDAO.filterProducts(
                        gender, keyword,
                        categories, sizes, colors,
                        minPrice, maxPrice,
                        sort
                );
            } else if (keyword != null && !keyword.trim().isEmpty()) {
                products = productDAO.searchProducts(keyword);
            } else {
                products = productDAO.getAllProducts(sort);
            }

            // ================= WISHLIST =================
            Set<Integer> wishlistNames = new HashSet<>();

            HttpSession session = request.getSession(false);

            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                wishlistNames = wishlistDAO.getWishlistProductIds(user.getEmail());
            }

            request.setAttribute("wishlistNames", wishlistNames);

            // ================= ATTRIBUTES =================
            request.setAttribute("products", products);
            request.setAttribute("selectedCategories", categories);
            request.setAttribute("selectedSizes", sizes);
            request.setAttribute("selectedColors", colors);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("keyword", keyword);
            request.setAttribute("sort", sort);

            // ================= AJAX =================
            String ajax = request.getHeader("X-Requested-With");

            if ("XMLHttpRequest".equals(ajax)) {
                request.getRequestDispatcher("/WEB-INF/views/products/grid.jsp")
                        .forward(request, response);
                return;
            }

            request.getRequestDispatcher("/WEB-INF/views/products/products.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("SERVER ERROR: " + e.getMessage());
        }
    }
}