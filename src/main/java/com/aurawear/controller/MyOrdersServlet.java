package com.aurawear.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.User;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Redirect to login if not logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        System.out.println("USER ID: " + user.getId());
        System.out.println("USER EMAIL: " + user.getEmail());

        // Fetch orders for this user from DB
        List<String[]> orders = CartDAO.getOrdersByUser(user.getId());

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/views/orders/my-orders.jsp")
               .forward(request, response);
    }
}