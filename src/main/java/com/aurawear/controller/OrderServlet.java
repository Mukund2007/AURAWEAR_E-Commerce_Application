package com.aurawear.controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.util.DBConnection;
import com.aurawear.model.User;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet{

protected void doGet(
HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException{

	HttpSession session =
			request.getSession(false);

			if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
			}

User user = (User) session.getAttribute("user");
String email = user.getEmail();

List<String[]> orders=
new ArrayList<>();

try (Connection con = DBConnection.getConnection();
     PreparedStatement ps = con.prepareStatement(
         "SELECT o.id, oi.price, oi.quantity, o.status, oi.product_name, o.created_at, oi.product_id, oi.size " +
         "FROM orders o " +
         "JOIN order_items oi ON oi.order_id = o.id " +
         "WHERE o.user_email = ? ORDER BY o.id DESC, oi.id ASC"
     )) {

    ps.setString(1, email);
    try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            double price = rs.getDouble("price");
            int qty = rs.getInt("quantity");
            orders.add(new String[]{
                String.valueOf(rs.getInt("id")),
                String.valueOf(price * qty),
                rs.getString("status"),
                rs.getString("product_name"),
                rs.getString("created_at"),
                String.valueOf(rs.getInt("product_id")),
                rs.getString("size"),
                String.valueOf(qty)
            });
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}

request.setAttribute("orders",orders);

request.getRequestDispatcher(
"/WEB-INF/views/orders/my-orders.jsp"
).forward(request,response);

}
}