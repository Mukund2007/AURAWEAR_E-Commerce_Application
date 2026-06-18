package com.aurawear.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.ReviewDAO;
import com.aurawear.model.User;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        String productIdStr = request.getParameter("productId");
        String ratingStr = request.getParameter("rating");
        String reviewText = request.getParameter("reviewText");

        if (productIdStr == null || ratingStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
            return;
        }

        int productId;
        int rating;
        try {
            productId = Integer.parseInt(productIdStr.trim());
            rating = Integer.parseInt(ratingStr.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or rating");
            return;
        }

        if (rating < 1 || rating > 5) {
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&reviewError=Rating must be between 1 and 5");
            return;
        }

        // 1. Verify purchase
        if (!reviewDAO.hasUserPurchasedProduct(email, productId)) {
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&reviewError=Only verified purchasers can review this product.");
            return;
        }

        // 2. Verify duplicate review
        if (reviewDAO.hasUserAlreadyReviewed(email, productId)) {
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&reviewError=You have already reviewed this product.");
            return;
        }

        // 3. Add review
        boolean success = reviewDAO.addReview(productId, email, rating, reviewText);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&reviewSuccess=Review submitted successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&reviewError=Failed to submit review. Please try again.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/products");
    }
}
