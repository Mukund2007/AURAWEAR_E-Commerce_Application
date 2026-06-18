package com.aurawear.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.aurawear.dao.CartDAO;
import com.aurawear.model.CartItem;
import com.aurawear.model.User;

@WebServlet("/checkout/cod")
public class CheckoutCODServlet extends HttpServlet {

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

        if (email == null || email.trim().isEmpty()) {
            System.err.println("[CheckoutCODServlet] Error: user email in session is null or empty!");
            response.sendRedirect(request.getContextPath() + "/checkout?error=invalid_user");
            return;
        }

        CartDAO dao = new CartDAO();
        List<CartItem> cartItems = dao.getCartItems(email);
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate grand total for COD confirmation email
        int subtotal = 0;
        for (CartItem item : cartItems) {
            subtotal += item.getPrice() * item.getQuantity();
        }
        int threshold = com.aurawear.util.SettingsUtil.getFreeShippingThreshold();
        int shippingCharge = com.aurawear.util.SettingsUtil.getShippingCharge();
        int shipping = (subtotal > 0 && subtotal < threshold) ? shippingCharge : 0;
        double grandTotal = subtotal + shipping;

        String shippingName = request.getParameter("shipping_name");
        String shippingPhone = request.getParameter("shipping_phone");
        String shippingAddress = request.getParameter("shipping_address");
        String shippingCity = request.getParameter("shipping_city");
        String shippingState = request.getParameter("shipping_state");
        String shippingPincode = request.getParameter("shipping_pincode");

        if (shippingName == null || shippingName.trim().isEmpty() ||
            shippingPhone == null || shippingPhone.trim().isEmpty() ||
            shippingAddress == null || shippingAddress.trim().isEmpty() ||
            shippingCity == null || shippingCity.trim().isEmpty() ||
            shippingState == null || shippingState.trim().isEmpty() ||
            shippingPincode == null || shippingPincode.trim().isEmpty()) {
            
            request.setAttribute("errorMsg", "Please complete all shipping address fields.");
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shipping", shipping);
            request.setAttribute("grandTotal", (int) grandTotal);
            request.setAttribute("amountInPaise", (int) (grandTotal * 100));
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/WEB-INF/views/orders/checkout.jsp")
                   .forward(request, response);
            return;
        }

        int orderId = -1;
        try {
            // Place order with payment_id = null and status = "COD_PENDING"
            System.out.println("[CheckoutCODServlet] Calling moveCartToOrdersWithPayment for: " + email + " with COD_PENDING");
            orderId = dao.moveCartToOrdersWithPayment(email, null, "COD_PENDING", 
                                                     shippingName, shippingPhone, shippingAddress, 
                                                     shippingCity, shippingState, shippingPincode);
            System.out.println("[CheckoutCODServlet] moveCartToOrdersWithPayment: SUCCESS, Order ID: " + orderId);

            // Trigger order confirmation email asynchronously
            if (orderId != -1) {
                final int finalOrderId = orderId;
                final String finalEmail = email;
                final List<CartItem> finalCartItems = cartItems;
                final double finalGrandTotal = grandTotal;

                new Thread(() -> {
                    try {
                        System.out.println("[CheckoutCODServlet] Initiating asynchronous COD order confirmation email for order: " + finalOrderId);
                        com.aurawear.util.EmailUtil.sendOrderConfirmation(finalEmail, String.valueOf(finalOrderId), finalCartItems, finalGrandTotal, true);
                    } catch (Exception e) {
                        System.err.println("[CheckoutCODServlet] Error sending asynchronous COD order confirmation email: " + e.getMessage());
                        e.printStackTrace();
                    }
                }).start();
            }

            response.sendRedirect(request.getContextPath() + "/order-success");

        } catch (Exception e) {
            System.err.println("[CheckoutCODServlet] Exception occurred during COD checkout: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMsg", "Order placement failed: " + e.getMessage());
            
            // Forward back to checkout.jsp with variables
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shipping", shipping);
            request.setAttribute("grandTotal", (int) grandTotal);
            request.setAttribute("amountInPaise", (int) (grandTotal * 100));
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/WEB-INF/views/orders/checkout.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout");
    }
}
