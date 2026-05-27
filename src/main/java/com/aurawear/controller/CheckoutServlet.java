package com.aurawear.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.CartItem;
import com.aurawear.model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user  = (User) session.getAttribute("user");
        CartDAO dao = new CartDAO();

        // Pass cart items so JSP can show order summary
        List<CartItem> cartItems = dao.getCartItems(user.getEmail());
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher("/WEB-INF/views/orders/checkout.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user   = (User) session.getAttribute("user");
        CartDAO dao = new CartDAO();

        List<CartItem> cartItems = dao.getCartItems(user.getEmail());
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        dao.moveCartToOrders(user.getEmail());
        dao.clearCart(user.getEmail());

        response.sendRedirect(request.getContextPath() + "/order-success");
    }
}