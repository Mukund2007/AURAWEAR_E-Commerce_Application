package com.aurawear.controller;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.aurawear.dao.ProductDAO;
import com.aurawear.dao.WishlistDAO;
import com.aurawear.dao.ReviewDAO;
import com.aurawear.model.Product;
import com.aurawear.model.User;
import com.aurawear.model.Review;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    private ProductDAO productDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            Product product = productDAO.getProductById(id);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            request.setAttribute("product", product);

            // Fetch related products (same category, excluding this product)
            List<Product> relatedProducts = productDAO.getRelatedProducts(product.getCategory(), product.getId());
            request.setAttribute("relatedProducts", relatedProducts);

            // Check if the product is wishlisted by the user
            boolean isWishlisted = false;
            boolean hasPurchased = false;
            boolean hasAlreadyReviewed = false;
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                WishlistDAO wDao = new WishlistDAO();
                Set<Integer> wishlistIds = wDao.getWishlistProductIds(user.getEmail());
                isWishlisted = wishlistIds.contains(product.getId());

                // Check reviews eligibility
                hasPurchased = reviewDAO.hasUserPurchasedProduct(user.getEmail(), product.getId());
                hasAlreadyReviewed = reviewDAO.hasUserAlreadyReviewed(user.getEmail(), product.getId());
            }
            request.setAttribute("isWishlisted", isWishlisted);
            request.setAttribute("hasPurchased", hasPurchased);
            request.setAttribute("hasAlreadyReviewed", hasAlreadyReviewed);

            // Fetch reviews and average ratings
            List<Review> reviews = reviewDAO.getReviewsByProduct(product.getId());
            double averageRating = reviewDAO.getAverageRating(product.getId());
            int reviewsCount = reviews.size();

            int averageFullStars = (int) averageRating;
            boolean averageHalfStar = (averageRating - averageFullStars) >= 0.5;

            request.setAttribute("reviews", reviews);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("reviewsCount", reviewsCount);
            request.setAttribute("averageFullStars", averageFullStars);
            request.setAttribute("averageHalfStar", averageHalfStar);

            request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}
