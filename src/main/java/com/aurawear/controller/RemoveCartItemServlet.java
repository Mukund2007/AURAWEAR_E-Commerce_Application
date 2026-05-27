package com.aurawear.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.User;

@WebServlet("/remove-from-cart")
public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        int productId = Integer.parseInt(request.getParameter("id"));
        String size = request.getParameter("size");

        CartDAO dao = new CartDAO();
        dao.removeItem(email, productId, size);

        response.sendRedirect("cart");
    }
}