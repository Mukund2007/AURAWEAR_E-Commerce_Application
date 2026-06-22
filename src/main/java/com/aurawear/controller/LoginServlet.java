package com.aurawear.controller;
import com.aurawear.dao.UserDAO;
import com.aurawear.model.User;
import com.aurawear.dao.LoginDAO;
import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    
	    response.sendRedirect(request.getContextPath() + "/home?login=true");
	}

	
	@Override
	protected void doPost(
			HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {

		String email =
				request.getParameter("email");

		String password =
				request.getParameter("password");

		

		LoginDAO dao = new LoginDAO();

		if (dao.validateUser(email, password)) {

		    // Session fixation protection: invalidate old session
		    HttpSession oldSession = request.getSession(false);
		    if (oldSession != null) {
		        oldSession.invalidate();
		    }
		    HttpSession session = request.getSession(true);

		    UserDAO userDAO = new UserDAO();          // ✅ ADD THIS
		    User user = userDAO.getUserByEmail(email); // ✅ FETCH USER

		    session.setAttribute("user", user);        // ✅ STORE OBJECT

		    response.sendRedirect(request.getContextPath() + "/home");
		}
		else{

			response.sendRedirect(request.getContextPath() + "/home?loginError=true");

		}

	}
}