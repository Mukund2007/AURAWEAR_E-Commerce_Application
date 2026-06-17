package com.aurawear.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.aurawear.dao.AdminDAO;
import com.aurawear.model.Order;
import com.aurawear.model.User;

public class AdminOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        AdminDAO adminDAO = new AdminDAO();
        List<Order> orders = adminDAO.getAllOrders();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/WEB-INF/views/admin/admin-orders.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            AdminDAO adminDAO = new AdminDAO();
            boolean success = adminDAO.updateOrderStatus(orderId, status);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalid");
        }
    }
}
