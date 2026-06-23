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

        try {
            System.out.println("[OTP] STEP 1: Request received");

            System.out.println("[OTP] STEP 2: Read OTP parameter");
            String enteredOtp = request.getParameter("otp");
            System.out.println("[OTP] Entered OTP: '" + enteredOtp + "'");

            System.out.println("[OTP] STEP 3: Read session values");
            HttpSession session = request.getSession(true);
            
            // Read and log session attributes as required by task 5 & 6
            Object pendingUser = session.getAttribute("pendingUser");
            String pendingEmail = (String) session.getAttribute("pendingEmail");
            String pendingName = (String) session.getAttribute("pendingName");
            String pendingUsername = (String) session.getAttribute("pendingUsername");
            String pendingPassword = (String) session.getAttribute("pendingPassword");
            String pendingInterests = (String) session.getAttribute("pendingInterests");
            String realOtp = (String) session.getAttribute("otp");
            Long otpCreatedAt = (Long) session.getAttribute("otpCreatedAt");
            Object otpExpiry = session.getAttribute("otpExpiry");

            System.out.println("[OTP] Session attribute values:");
            System.out.println("  - pendingUser: " + pendingUser);
            System.out.println("  - pendingEmail: " + pendingEmail);
            System.out.println("  - pendingName: " + (pendingName != null ? "[PRESENT]" : "[NULL]"));
            System.out.println("  - pendingUsername: " + pendingUsername);
            System.out.println("  - pendingPassword: " + (pendingPassword != null ? "[PRESENT]" : "[NULL]"));
            System.out.println("  - pendingInterests: " + pendingInterests);
            System.out.println("  - otp: " + realOtp);
            System.out.println("  - otpCreatedAt: " + otpCreatedAt);
            System.out.println("  - otpExpiry: " + otpExpiry);

            // Null-safety check for session data
            if (realOtp == null || pendingEmail == null || pendingName == null || pendingPassword == null) {
                System.out.println("[OTP] Session data validation failed: Critical session attribute is null!");
                request.setAttribute("otpError", "Registration session expired or invalid. Please register again.");
                request.setAttribute("showOtp", false);
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }

            System.out.println("[OTP] STEP 4: Compare OTP");
            boolean otpMatches = enteredOtp != null && enteredOtp.equals(realOtp);
            System.out.println("[OTP] Comparison result: enteredOtpMatches=" + otpMatches);

            if (otpMatches) {
                // Check OTP expiry (10 minutes)
                if (otpCreatedAt != null && (System.currentTimeMillis() - otpCreatedAt) > 600_000) {
                    System.out.println("[OTP] OTP has expired");
                    session.removeAttribute("otp");
                    session.removeAttribute("otpCreatedAt");
                    request.setAttribute("showOtp", true);
                    request.setAttribute("otpError", "Verification code expired. Please request a new one.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                    return;
                }

                System.out.println("[OTP] STEP 5: Create user");
                User user = new User(pendingName, pendingEmail, pendingPassword);
                System.out.println("[OTP] User object created: email=" + user.getEmail());

                System.out.println("[OTP] STEP 6: Persist user");
                UserDAO dao = new UserDAO();
                boolean saved = dao.registerUser(user);
                System.out.println("[OTP] User registration saved=" + saved);

                if (saved) {
                    User createdUser = dao.getUserByEmail(pendingEmail);
                    if (createdUser == null) {
                        System.out.println("[OTP] FAILED: User was saved but could not be retrieved from DB by email: " + pendingEmail);
                        throw new RuntimeException("User successfully registered but unable to retrieve back from database.");
                    }

                    int userId = createdUser.getId();
                    System.out.println("[OTP] Retrieved registered user ID=" + userId);

                    // Create user profile in user_profiles
                    com.aurawear.model.UserProfile profile = new com.aurawear.model.UserProfile(
                        userId,
                        pendingUsername != null ? pendingUsername : "",
                        "",
                        "",
                        "",
                        pendingInterests != null ? pendingInterests : ""
                    );
                    boolean profileSaved = dao.saveProfile(profile);
                    System.out.println("[OTP] User profile saved=" + profileSaved);

                    // Clear session registration attributes
                    session.removeAttribute("otp");
                    session.removeAttribute("otpCreatedAt");
                    session.removeAttribute("otpAttempts");
                    session.removeAttribute("pendingName");
                    session.removeAttribute("pendingEmail");
                    session.removeAttribute("pendingPassword");
                    session.removeAttribute("pendingUsername");
                    session.removeAttribute("pendingInterests");
                    session.removeAttribute("pendingUser");

                    System.out.println("[OTP] STEP 7: Login user");
                    // Session fixation protection: invalidate old session, create new one
                    session.invalidate();
                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("userId", userId);
                    newSession.setAttribute("user", createdUser);
                    newSession.setAttribute("registrationSuccess", true); // GA4 Event Flag

                    System.out.println("[OTP] STEP 8: Redirect success");
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    System.out.println("[OTP] FAILED: DB persistence returned false");
                    request.setAttribute("otpError", "Registration database entry failed. Please try again.");
                    request.setAttribute("showOtp", true);
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                }
            } else {
                System.out.println("[OTP] Comparison failed: Invalid verification code");
                request.setAttribute("showOtp", true);
                request.setAttribute("otpError", "Invalid verification code");

                Integer attempts = (Integer) session.getAttribute("otpAttempts");
                attempts = (attempts == null) ? 1 : attempts + 1;
                session.setAttribute("otpAttempts", attempts);
                System.out.println("[OTP] Failed attempt count: " + attempts);
                if (attempts >= 3) {
                    session.removeAttribute("otp");
                    session.removeAttribute("otpCreatedAt");
                    session.removeAttribute("otpAttempts");
                    request.setAttribute("otpError", "Too many failed attempts. Please register again.");
                    request.setAttribute("showOtp", false);
                }

                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("[OTP] UNCAUGHT EXCEPTION IN doPost: " + e.getClass().getName() + " - " + e.getMessage());
            e.printStackTrace();
            
            // Format exception details to return on the error page
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            String stackTrace = sw.toString();

            // Try to find the exact line causing the crash from the stack trace
            String crashLocation = "Unknown Line";
            for (StackTraceElement element : e.getStackTrace()) {
                if (element.getClassName().contains("VerifyOTPServlet")) {
                    crashLocation = element.getFileName() + ":" + element.getLineNumber();
                    break;
                }
            }

            String errorMsg = "An unexpected error occurred during OTP verification.<br/>" +
                              "<b>Exception:</b> " + e.getClass().getName() + ": " + e.getMessage() + "<br/>" +
                              "<b>Location:</b> " + crashLocation;
            
            request.setAttribute("error", errorMsg);
            request.setAttribute("stackTrace", stackTrace);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}