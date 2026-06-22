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

        System.out.println("[REGISTRATION] Email entered in registration form: '" + email + "'");
        String normalizedEmail = (email != null) ? email.trim().toLowerCase() : "";
        System.out.println("[REGISTRATION] Email after normalization/trim: '" + normalizedEmail + "'");

        String[] interestsArr = request.getParameterValues("interests");
        String interests = (interestsArr != null) ? String.join(",", interestsArr) : "";

        // Check email already registered
        UserDAO dao = new UserDAO();
        boolean exists = dao.emailExists(normalizedEmail);
        System.out.println("[REGISTRATION] Show whether the email already exists in the database: " + exists);
        if (exists) {
            System.out.println("[REGISTRATION] Show whether registration is blocked because of duplicate account detection: TRUE (email: '" + normalizedEmail + "')");
            System.out.println("[REGISTRATION] Show whether OTP generation is skipped for any reason: TRUE (Duplicate email exists)");
            request.setAttribute("emailError", "This email is already registered");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);
            return;
        }

        System.out.println("[REGISTRATION] Show whether registration is blocked because of duplicate account detection: FALSE");
        System.out.println("[REGISTRATION] Show whether OTP generation is skipped for any reason: FALSE");

        // Generate OTP
        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);
        System.out.println("[REGISTRATION] Generated OTP: '" + otp + "'");
        System.out.println("[REGISTRATION] Email passed into EmailUtil.sendOTP(): '" + normalizedEmail + "'");

        // Save to session
        HttpSession session = request.getSession();
        session.setAttribute("pendingName",      name);
        session.setAttribute("pendingEmail",     normalizedEmail);
        session.setAttribute("pendingPassword",  password);
        session.setAttribute("pendingUsername",  username);
        session.setAttribute("pendingInterests", interests);
        session.setAttribute("otp",              otp);
        session.setAttribute("otpCreatedAt", System.currentTimeMillis());
        session.removeAttribute("otpAttempts");
        System.out.println("[REGISTRATION] OTP storage: OTP '" + otp + "' successfully stored in session under 'otp' for pending email '" + normalizedEmail + "'");

        // Send real email
        try {
            System.out.println("[REGISTRATION] Attempting to send OTP email to '" + normalizedEmail + "' via EmailUtil.sendOTP()");
            EmailUtil.sendOTP(normalizedEmail, otp);
            System.out.println("[REGISTRATION] SMTP send succeeds. [REGISTRATION] OTP email sent to: " + normalizedEmail);
        } catch (Exception e) {
            System.err.println("[REGISTRATION] FATAL Exception occurred during OTP email sending to '" + normalizedEmail + "':");
            e.printStackTrace();
            throw new RuntimeException("OTP delivery failed: " + e.getMessage(), e);
        }

        request.setAttribute("showOtp", true);
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
               .forward(request, response);
    }
}