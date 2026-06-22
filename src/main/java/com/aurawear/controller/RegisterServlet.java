package com.aurawear.controller;

import com.aurawear.dao.UserDAO;
import com.aurawear.util.EmailUtil;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // RESEND OTP
        if ("true".equals(request.getParameter("resend"))) {

            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("pendingEmail");
            String otp   = String.valueOf((int)(Math.random() * 900000) + 100000);

            session.setAttribute("otp", otp);
            session.setAttribute("otpCreatedAt", System.currentTimeMillis());
            session.removeAttribute("otpAttempts");

            System.out.println("[REGISTRATION] OTP resent to: " + email);

            try {
                EmailUtil.sendOTP(email, otp);
            } catch (Exception e) {
                e.printStackTrace();
            }

            request.setAttribute("showOtp", true);
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String name      = firstName + " " + lastName;
        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        String username  = request.getParameter("username");

        String[] interestsArr = request.getParameterValues("interests");
        String interests = (interestsArr != null) ? String.join(",", interestsArr) : "";

        // Check email already registered
        UserDAO dao = new UserDAO();
        if (dao.emailExists(email)) {
            request.setAttribute("emailError", "This email is already registered");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);
            return;
        }

        // Generate OTP
        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);

        // Save to session
        HttpSession session = request.getSession();
        session.setAttribute("pendingName",      name);
        session.setAttribute("pendingEmail",     email);
        session.setAttribute("pendingPassword",  password);
        session.setAttribute("pendingUsername",  username);
        session.setAttribute("pendingInterests", interests);
        session.setAttribute("otp",              otp);
        session.setAttribute("otpCreatedAt", System.currentTimeMillis());
        session.removeAttribute("otpAttempts");

        System.out.println("[REGISTRATION] OTP generated for: " + email);

        // Send real email
        try {
            EmailUtil.sendOTP(email, otp);
            System.out.println("[REGISTRATION] OTP email sent to: " + email);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("[REGISTRATION] Email send failed for: " + email);
        }

        request.setAttribute("showOtp", true);
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
               .forward(request, response);
    }
}