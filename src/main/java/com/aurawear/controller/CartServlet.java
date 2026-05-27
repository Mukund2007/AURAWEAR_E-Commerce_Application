package com.aurawear.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.CartItem;
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
}