package com.aurawear.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.aurawear.model.User;
import com.aurawear.util.DBConnection;
import com.aurawear.util.SettingsUtil;

public class AdminSettingsServlet extends HttpServlet {

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

        request.setAttribute("shippingCharge", SettingsUtil.getShippingCharge());
        request.setAttribute("freeShippingThreshold", SettingsUtil.getFreeShippingThreshold());

        request.getRequestDispatcher("/WEB-INF/views/admin/admin-settings.jsp")
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

        String shippingCharge = request.getParameter("shippingCharge");
        String freeShippingThreshold = request.getParameter("freeShippingThreshold");

        String sqlUpdateCharge = "UPDATE shop_settings SET setting_value = ? WHERE setting_key = 'shipping_charge'";
        String sqlUpdateThreshold = "UPDATE shop_settings SET setting_value = ? WHERE setting_key = 'free_shipping_threshold'";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new Exception("Null database connection!");
            }
            con.setAutoCommit(false);
            try {
                try (PreparedStatement ps = con.prepareStatement(sqlUpdateCharge)) {
                    ps.setString(1, shippingCharge);
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = con.prepareStatement(sqlUpdateThreshold)) {
                    ps.setString(1, freeShippingThreshold);
                    ps.executeUpdate();
                }
                con.commit();
                SettingsUtil.clearCache();
                response.sendRedirect(request.getContextPath() + "/admin/settings?success=true");
            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/settings?error=true");
        }
    }
}
