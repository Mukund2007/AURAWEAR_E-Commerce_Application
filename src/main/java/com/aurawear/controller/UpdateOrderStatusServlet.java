package com.aurawear.controller;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.util.DBConnection;
import com.aurawear.model.User;

@WebServlet("/update-order-status")
public class UpdateOrderStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized access");
            return;
        }

        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        String orderIdStr = request.getParameter("orderId");
        String action = request.getParameter("action");

        if (orderIdStr == null || action == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing parameters");
            return;
        }

        int orderId;
        try {
            if (orderIdStr != null) {
                orderIdStr = orderIdStr.trim();
            }
            System.out.println("UpdateOrderStatusServlet: Received orderIdStr = '" + orderIdStr + "', action = '" + action + "'");
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            System.err.println("UpdateOrderStatusServlet: NumberFormatException parsing '" + orderIdStr + "': " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid order ID (" + orderIdStr + ")");
            return;
        }

        String targetStatus = "";

        if ("cancel".equalsIgnoreCase(action)) {
            targetStatus = "Cancelled";
        } else if ("return".equalsIgnoreCase(action)) {
            targetStatus = "Returned";
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid action");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            // Verify ownership and current status
            String verifySql = "SELECT status FROM orders WHERE id = ? AND user_email = ?";
            try (PreparedStatement psVerify = con.prepareStatement(verifySql)) {
                psVerify.setInt(1, orderId);
                psVerify.setString(2, email);
                try (ResultSet rs = psVerify.executeQuery()) {
                    if (!rs.next()) {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        response.getWriter().write("Order not found");
                        return;
                    }
                    String currentStatus = rs.getString("status");
                    boolean allowed = false;
                    if ("cancel".equalsIgnoreCase(action)) {
                        allowed = currentStatus.equalsIgnoreCase("Placed") 
                               || currentStatus.equalsIgnoreCase("COD_PENDING") 
                               || currentStatus.equalsIgnoreCase("COD_CONFIRMED");
                    } else if ("return".equalsIgnoreCase(action)) {
                        allowed = currentStatus.equalsIgnoreCase("Delivered");
                    }
                    
                    if (!allowed) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("Order is in status '" + currentStatus + "' and cannot be " + action + "ed.");
                        return;
                    }
                }
            }

            // Update order status
            String updateSql = "UPDATE orders SET status = ? WHERE id = ? AND user_email = ?";
            try (PreparedStatement psUpdate = con.prepareStatement(updateSql)) {
                psUpdate.setString(1, targetStatus);
                psUpdate.setInt(2, orderId);
                psUpdate.setString(3, email);
                int updated = psUpdate.executeUpdate();
                if (updated > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Success");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to update status");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
