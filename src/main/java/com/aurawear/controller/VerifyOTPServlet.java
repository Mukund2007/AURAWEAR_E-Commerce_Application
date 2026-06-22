package com.aurawear.controller;

import com.aurawear.dao.UserDAO;
import com.aurawear.model.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/otp-verify")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

        response.sendRedirect("register");
    }


    @Override
    protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

        String enteredOtp =
            request.getParameter("otp");

        HttpSession session =
            request.getSession();

        String realOtp =
            (String) session.getAttribute("otp");


        /* verify otp */
        if(
           enteredOtp != null &&
           realOtp != null &&
           enteredOtp.equals(realOtp)
        ){

            // Check OTP expiry (10 minutes)
            Long otpCreatedAt = (Long) session.getAttribute("otpCreatedAt");
            if (otpCreatedAt != null && (System.currentTimeMillis() - otpCreatedAt) > 600_000) {
                session.removeAttribute("otp");
                session.removeAttribute("otpCreatedAt");
                request.setAttribute("showOtp", true);
                request.setAttribute("otpError", "Verification code expired. Please request a new one.");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }

            // pull pending registration data
            String name =
                (String) session.getAttribute("pendingName");

            String email =
                (String) session.getAttribute("pendingEmail");

            String password =
                (String) session.getAttribute("pendingPassword");

            String username =
                (String) session.getAttribute("pendingUsername");

            String interests =
                (String) session.getAttribute("pendingInterests");


            /* save user AFTER verification */
            User user =
                new User(name,email,password);

            UserDAO dao =
                new UserDAO();

            boolean saved =
            		dao.registerUser(user);

            		if(saved){

            		User createdUser =
            		dao.getUserByEmail(email);

                    // Create user profile in user_profiles
                    com.aurawear.model.UserProfile profile =
                        new com.aurawear.model.UserProfile(
                            createdUser.getId(),
                            username,
                            "",
                            "",
                            "",
                            interests
                        );
                    dao.saveProfile(profile);

            		System.out.println(
            		"User saved successfully"
            		);

            		session.removeAttribute("otp");
            		session.removeAttribute("otpCreatedAt");
            		session.removeAttribute("otpAttempts");
            		session.removeAttribute("pendingName");
            		session.removeAttribute("pendingEmail");
            		session.removeAttribute("pendingPassword");
            		session.removeAttribute("pendingUsername");
            		session.removeAttribute("pendingInterests");

            		// Session fixation protection after registration
            		int userId = createdUser.getId();
            		User freshUser = createdUser;
            		session.invalidate();
            		HttpSession newSession = request.getSession(true);
            		newSession.setAttribute("userId", userId);
            		newSession.setAttribute("user", freshUser);

            		response.sendRedirect(
            		request.getContextPath() + "/home"
            		);

            		}else{

            		response.getWriter().println(
            		"Registration failed."
            		);

            		}

        } else {

            // wrong otp -> stay on verify screen
            request.setAttribute("showOtp", true);

            request.setAttribute(
                "otpError",
                "Invalid verification code"
            );

            Integer attempts = (Integer) session.getAttribute("otpAttempts");
            attempts = (attempts == null) ? 1 : attempts + 1;
            session.setAttribute("otpAttempts", attempts);
            if (attempts >= 3) {
                session.removeAttribute("otp");
                session.removeAttribute("otpCreatedAt");
                session.removeAttribute("otpAttempts");
                request.setAttribute("otpError", "Too many failed attempts. Please register again.");
                request.setAttribute("showOtp", false);
            }

            request.getRequestDispatcher(
                "/WEB-INF/views/auth/register.jsp"
            ).forward(request,response);
        }
    }
}