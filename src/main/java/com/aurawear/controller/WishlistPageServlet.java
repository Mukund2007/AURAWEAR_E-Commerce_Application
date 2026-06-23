package com.aurawear.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.WishlistDAO;
import com.aurawear.model.User;
import com.aurawear.model.WishlistItem;

@WebServlet("/wishlist")
public class WishlistPageServlet
extends HttpServlet{

	protected void doGet(
			HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException,IOException{

		HttpSession session =
				request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		User user = (User) session.getAttribute("user");
		String email = user.getEmail();

		WishlistDAO dao=
				new WishlistDAO();

		List<WishlistItem> items=
				dao.getWishlistByEmail(email);

		request.setAttribute(
				"wishlist",
				items
				);

		request.getRequestDispatcher(
				"/WEB-INF/views/wishlist/wishlist.jsp"
				).forward(request,response);

	}
}