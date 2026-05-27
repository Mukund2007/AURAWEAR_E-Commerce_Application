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

	HttpSession session=
			request.getSession();

			if(session.getAttribute("user")==null){
			response.sendRedirect("login");
			return;
			}

User user = (User) session.getAttribute("user");
String email = user.getEmail();

List<String[]> orders=
new ArrayList<>();

try{

Connection con=
DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement(
"SELECT * FROM orders WHERE user_email=?"
);

ps.setString(1,email);

ResultSet rs=
ps.executeQuery();

while(rs.next()){

	orders.add(
			new String[]{
			String.valueOf(rs.getInt("id")),
			String.valueOf(rs.getDouble("total")),
			rs.getString("status"),
			rs.getString("product_name"),
			rs.getString("created_at"),
			String.valueOf(rs.getInt("product_id"))
			}
			);

}

}catch(Exception e){
e.printStackTrace();
}

request.setAttribute("orders",orders);

request.getRequestDispatcher(
"/WEB-INF/views/orders/my-orders.jsp"
).forward(request,response);

}
}