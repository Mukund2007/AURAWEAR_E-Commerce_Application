package com.aurawear.controller;

import java.io.IOException;
import java.util.Set;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.aurawear.dao.ProductDAO;
import com.aurawear.dao.WishlistDAO;
import com.aurawear.model.Product;
import com.aurawear.model.User;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        int id = Integer.parseInt(idParam);
        Product product = productDAO.getProductById(id);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        request.setAttribute("product", product);

        // ✅ CHECK WISHLIST STATUS
     // ✅ CHECK WISHLIST STATUS BY PRODUCT ID
        boolean isWishlisted = false;
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            WishlistDAO wDao = new WishlistDAO();
            Set<Integer> wishlistIds = wDao.getWishlistProductIds(user.getEmail());
            isWishlisted = wishlistIds.contains(product.getId());
        }
        request.setAttribute("isWishlisted", isWishlisted);

        request.getRequestDispatcher("/WEB-INF/views/products/product-details.jsp")
               .forward(request, response);
    }
}