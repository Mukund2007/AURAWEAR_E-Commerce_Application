package com.aurawear.controller;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.User;
import com.aurawear.config.RazorpayConfig;

public class PaymentSuccessServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        String razorpayPaymentId = request.getParameter("razorpay_payment_id");
        String razorpayOrderId = request.getParameter("razorpay_order_id");
        String razorpaySignature = request.getParameter("razorpay_signature");

        System.out.println("[PaymentSuccessServlet] Read razorpay_payment_id: " + razorpayPaymentId);
        System.out.println("[PaymentSuccessServlet] Read razorpay_order_id: " + razorpayOrderId);
        System.out.println("[PaymentSuccessServlet] Read razorpay_signature: " + razorpaySignature);

        if (email == null || email.trim().isEmpty()) {
            System.err.println("[PaymentSuccessServlet] Error: user_email read from session is null or empty!");
            throw new IllegalArgumentException("User email in session is null or empty.");
        }
        System.out.println("[PaymentSuccessServlet] Verified user_email from session: " + email);

        if (razorpayPaymentId == null || razorpayOrderId == null || razorpaySignature == null) {
            System.err.println("[PaymentSuccessServlet] Error: Missing parameters!");
            response.sendRedirect(request.getContextPath() + "/checkout?error=missing_parameters");
            return;
        }

        try {
            // Verify signature: HmacSHA256(order_id + "|" + payment_id, secret)
            String signatureData = razorpayOrderId + "|" + razorpayPaymentId;
            String generatedSignature = calculateHmacSHA256(signatureData, RazorpayConfig.getKeySecret());

            if (!generatedSignature.equals(razorpaySignature)) {
                System.out.println("[PaymentSuccessServlet] Signature verification: FAILED");
                throw new SecurityException("Cryptographic signature mismatch! Invalid payment.");
            }
            System.out.println("[PaymentSuccessServlet] Signature verification: PASSED");

            // Fetch cart items and calculate grand total before the transaction clears them
            CartDAO dao = new CartDAO();
            java.util.List<com.aurawear.model.CartItem> cartItems = dao.getCartItems(email);
            int subtotal = 0;
            if (cartItems != null) {
                for (com.aurawear.model.CartItem item : cartItems) {
                    subtotal += item.getPrice() * item.getQuantity();
                }
            }
            int threshold = com.aurawear.util.SettingsUtil.getFreeShippingThreshold();
            int shippingCharge = com.aurawear.util.SettingsUtil.getShippingCharge();
            int shipping = (subtotal > 0 && subtotal < threshold) ? shippingCharge : 0;
            final double grandTotal = subtotal + shipping;

            String shippingName = request.getParameter("shipping_name");
            String shippingPhone = request.getParameter("shipping_phone");
            String shippingAddress = request.getParameter("shipping_address");
            String shippingCity = request.getParameter("shipping_city");
            String shippingState = request.getParameter("shipping_state");
            String shippingPincode = request.getParameter("shipping_pincode");

            // Save order and clear cart in a single transaction
            System.out.println("[PaymentSuccessServlet] Calling moveCartToOrdersWithPayment for: " + email);
            int orderId = -1;
            try {
                orderId = dao.moveCartToOrdersWithPayment(email, razorpayPaymentId, "PAID",
                                                         shippingName, shippingPhone, shippingAddress,
                                                         shippingCity, shippingState, shippingPincode);
                System.out.println("[PaymentSuccessServlet] moveCartToOrdersWithPayment: SUCCESS, Order ID: " + orderId);
            } catch (Exception e) {
                System.out.println("[PaymentSuccessServlet] moveCartToOrdersWithPayment: FAILURE");
                e.printStackTrace();
                throw e; // Rethrow to propagate to the outer catch block
            }

            // Trigger order confirmation email asynchronously
            if (orderId != -1 && cartItems != null && !cartItems.isEmpty()) {
                final int finalOrderId = orderId;
                final String finalEmail = email;
                new Thread(() -> {
                    try {
                        System.out.println("[PaymentSuccessServlet] Initiating asynchronous order confirmation email for order: " + finalOrderId);
                        com.aurawear.util.EmailUtil.sendOrderConfirmation(finalEmail, String.valueOf(finalOrderId), cartItems, grandTotal, false,
                                                                         shippingName, shippingPhone, shippingAddress, shippingCity, shippingState, shippingPincode);
                    } catch (Exception e) {
                        System.err.println("[PaymentSuccessServlet] Error sending asynchronous order confirmation email: " + e.getMessage());
                        e.printStackTrace();
                    }
                }).start();
            }

            response.sendRedirect(request.getContextPath() + "/order-success");

        } catch (Exception e) {
            System.err.println("[PaymentSuccessServlet] Exception occurred: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMsg", "Order placement failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/orders/checkout.jsp")
                   .forward(request, response);
        }
    }

    private String calculateHmacSHA256(String data, String keySecret) throws Exception {
        javax.crypto.Mac sha256_HMAC = javax.crypto.Mac.getInstance("HmacSHA256");
        javax.crypto.spec.SecretKeySpec secret_key = new javax.crypto.spec.SecretKeySpec(keySecret.getBytes("UTF-8"), "HmacSHA256");
        sha256_HMAC.init(secret_key);
        byte[] raw = sha256_HMAC.doFinal(data.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : raw) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
