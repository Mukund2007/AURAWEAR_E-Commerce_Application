package com.aurawear.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.dao.ProductDAO;
import com.aurawear.model.CartItem;
import com.aurawear.model.Product;
import com.aurawear.model.User;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        CartDAO dao = new CartDAO();
        List<CartItem> cartItems = dao.getCartItems(email);

        request.setAttribute("cartItems", cartItems);

        RequestDispatcher dispatcher =
                request.getRequestDispatcher("/WEB-INF/views/cart/cart.jsp");
        dispatcher.forward(request, response);
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

        String idParam = request.getParameter("productId");
        if (idParam == null) {
            idParam = request.getParameter("id");
        }
        String size = request.getParameter("size");
        String priceParam = request.getParameter("price");

        if (idParam != null && size != null && priceParam != null) {
            try {
                int productId = Integer.parseInt(idParam);
                int price = (int) Double.parseDouble(priceParam);

                // ── Out-of-Stock guard ──
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(productId);
                if (product == null || !product.isInStock()) {
                    response.sendRedirect(request.getContextPath() + "/cart?error=out_of_stock");
                    return;
                }

                CartDAO dao = new CartDAO();
                dao.addToCart(email, productId, size, price);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}