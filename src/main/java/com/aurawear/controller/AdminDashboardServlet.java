package com.aurawear.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.aurawear.dao.AdminDAO;
import com.aurawear.model.Order;
import com.aurawear.model.User;

public class AdminDashboardServlet extends HttpServlet {

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
        double revenue = adminDAO.getTotalRevenue();
        int ordersCount = adminDAO.getTotalOrdersCount();
        int productsCount = adminDAO.getTotalProductsCount();
        List<Order> recentOrders = adminDAO.getRecentOrders(10);

        request.setAttribute("revenue", revenue);
        request.setAttribute("ordersCount", ordersCount);
        request.setAttribute("productsCount", productsCount);
        request.setAttribute("recentOrders", recentOrders);

        request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp")
               .forward(request, response);
    }
}
