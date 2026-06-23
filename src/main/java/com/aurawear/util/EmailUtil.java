package com.aurawear.util;

import com.aurawear.config.AppConfig;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Email utility for sending OTP and order confirmation emails via Resend HTTP API.
 *
 * Credentials are loaded exclusively from environment variables via AppConfig:
 *   RESEND_API_KEY — API key from resend.com
 *
 * No SMTP ports, sessions, or JavaMail dependencies required.
 * From address: AuraWear <onboarding@resend.dev>
 */
public class EmailUtil {

    private static final String RESEND_API_URL = "https://api.resend.com/emails";
    private static final String FROM_ADDRESS   = "AuraWear <onboarding@resend.dev>";

    private static final HttpClient HTTP_CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    private static String getApiKey() {
        String v = AppConfig.get("RESEND_API_KEY");
        if (v == null) throw new RuntimeException(
            "[EmailUtil] RESEND_API_KEY environment variable is not set");
        return v;
    }

    // ─── sendOTP ────────────────────────────────────────────────────────────────

    public static void sendOTP(String toEmail, String otp) throws Exception {

        System.out.println("[EmailUtil.sendOTP] Recipient parameter : '" + toEmail + "'");
        System.out.println("[EmailUtil.sendOTP] OTP parameter       : '" + otp + "'");
        System.out.println("[EmailUtil.sendOTP] Sending via Resend HTTP API...");

        String json = buildJson(
            FROM_ADDRESS,
            toEmail,
            "Your AuraWear Verification Code",
            buildOtpEmailHTML(otp)
        );

        HttpResponse<String> response = postToResend(json);

        System.out.println("[EmailUtil.sendOTP] Resend HTTP status : " + response.statusCode());
        System.out.println("[EmailUtil.sendOTP] Resend response    : " + response.body());

        if (response.statusCode() < 200 || response.statusCode() >= 300) {
            throw new RuntimeException(
                "[EmailUtil.sendOTP] Resend rejected the request (HTTP " +
                response.statusCode() + "): " + response.body());
        }

        System.out.println("[EmailUtil.sendOTP] Email accepted by Resend for: " + toEmail);
    }

    // ─── sendOrderConfirmation overloads ────────────────────────────────────────

    public static void sendOrderConfirmation(
            String toEmail, String orderId,
            java.util.List<com.aurawear.model.CartItem> items,
            double totalAmount) throws Exception {
        sendOrderConfirmation(toEmail, orderId, items, totalAmount, false,
                null, null, null, null, null, null);
    }

    public static void sendOrderConfirmation(
            String toEmail, String orderId,
            java.util.List<com.aurawear.model.CartItem> items,
            double totalAmount, boolean isCOD) throws Exception {
        sendOrderConfirmation(toEmail, orderId, items, totalAmount, isCOD,
                null, null, null, null, null, null);
    }

    public static void sendOrderConfirmation(
            String toEmail, String orderId,
            java.util.List<com.aurawear.model.CartItem> items,
            double totalAmount, boolean isCOD,
            String shippingName, String shippingPhone, String shippingAddress,
            String shippingCity, String shippingState, String shippingPincode) throws Exception {

        String subject = isCOD
                ? "Your AuraWear Order Confirmation (COD) - #" + orderId
                : "Your AuraWear Order Confirmation - #" + orderId;

        String html = buildOrderEmailHTML(orderId, items, totalAmount, isCOD,
                shippingName, shippingPhone, shippingAddress,
                shippingCity, shippingState, shippingPincode);

        String json = buildJson(FROM_ADDRESS, toEmail, subject, html);

        HttpResponse<String> response = postToResend(json);

        System.out.println("[EmailUtil.sendOrderConfirmation] Resend HTTP status : " + response.statusCode());
        System.out.println("[EmailUtil.sendOrderConfirmation] Resend response    : " + response.body());

        if (response.statusCode() < 200 || response.statusCode() >= 300) {
            throw new RuntimeException(
                "[EmailUtil.sendOrderConfirmation] Resend rejected the request (HTTP " +
                response.statusCode() + "): " + response.body());
        }

        System.out.println("Order confirmation email sent to: " + toEmail +
                " for order: " + orderId + " (COD=" + isCOD + ")");
    }

    // ─── Internal helpers ────────────────────────────────────────────────────────

    private static HttpResponse<String> postToResend(String json) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(RESEND_API_URL))
                .header("Authorization", "Bearer " + getApiKey())
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .timeout(Duration.ofSeconds(15))
                .build();

        return HTTP_CLIENT.send(request, HttpResponse.BodyHandlers.ofString());
    }

    /** Builds a minimal Resend-compatible JSON payload (no third-party JSON library required). */
    private static String buildJson(String from, String to, String subject, String html) {
        return "{"
            + "\"from\":"    + jsonString(from)    + ","
            + "\"to\":"      + "[" + jsonString(to) + "]" + ","
            + "\"subject\":" + jsonString(subject)  + ","
            + "\"html\":"    + jsonString(html)
            + "}";
    }

    /** Escapes a Java string for safe embedding in a JSON value. */
    private static String jsonString(String value) {
        if (value == null) return "\"\"";
        String escaped = value
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r")
            .replace("\t", "\\t");
        return "\"" + escaped + "\"";
    }

    // ─── Email HTML builders ─────────────────────────────────────────────────────

    private static String buildOtpEmailHTML(String otp) {
        return "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head><body style='" +
            "margin:0;padding:0;background:#f5f2ee;font-family:Arial,sans-serif;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr><td align='center' style='padding:40px 20px;'>" +
            "<table width='520' cellpadding='0' cellspacing='0' style='" +
            "background:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(0,0,0,0.08);'>" +

            // HEADER
            "<tr><td style='background:#111111;padding:36px 40px;text-align:center;'>" +
            "<span style='color:#fff;font-size:22px;font-weight:700;letter-spacing:4px;'>AURAWEAR</span><br>" +
            "<span style='color:rgba(255,255,255,0.5);font-size:11px;letter-spacing:3px;'>WEAR YOUR AURA</span>" +
            "</td></tr>" +

            // BODY
            "<tr><td style='padding:44px 40px;text-align:center;'>" +
            "<p style='font-size:16px;color:#444;margin:0 0 8px;'>Your verification code is</p>" +
            "<div style='font-size:48px;font-weight:700;letter-spacing:12px;color:#111;margin:24px 0;'>" +
            otp +
            "</div>" +
            "<p style='font-size:13px;color:#999;margin:0 0 32px;'>This code expires in <strong>10 minutes</strong>. Do not share it with anyone.</p>" +
            "<hr style='border:none;border-top:1px solid #f0ede8;margin:0 0 28px;'>" +
            "<p style='font-size:12px;color:#bbb;margin:0;'>If you didn't create an AuraWear account, ignore this email.</p>" +
            "</td></tr>" +

            // FOOTER
            "<tr><td style='background:#faf9f6;padding:24px 40px;text-align:center;'>" +
            "<p style='font-size:11px;color:#ccc;margin:0;letter-spacing:0.5px;'>" +
            "&copy; 2026 AuraWear. All Rights Reserved.</p>" +
            "</td></tr>" +

            "</table></td></tr></table></body></html>";
    }

    private static String buildOrderEmailHTML(
            String orderId,
            java.util.List<com.aurawear.model.CartItem> items,
            double totalAmount, boolean isCOD,
            String shippingName, String shippingPhone, String shippingAddress,
            String shippingCity, String shippingState, String shippingPincode) {

        StringBuilder sb = new StringBuilder();
        sb.append("<!DOCTYPE html>")
          .append("<html><head><meta charset='UTF-8'></head><body style='margin:0;padding:0;background:#f5f2ee;font-family:Arial,sans-serif;'>")
          .append("<table width='100%' cellpadding='0' cellspacing='0'><tr><td align='center' style='padding:40px 20px;'>")
          .append("<table width='560' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 24px rgba(0,0,0,0.08);'>")

          // HEADER
          .append("<tr><td style='background:#111111;padding:36px 40px;text-align:center;'>")
          .append("<span style='color:#fff;font-size:22px;font-weight:700;letter-spacing:4px;'>AURAWEAR</span><br>")
          .append("<span style='color:rgba(255,255,255,0.5);font-size:11px;letter-spacing:3px;'>WEAR YOUR AURA</span>")
          .append("</td></tr>")

          // BODY
          .append("<tr><td style='padding:40px;color:#111111;'>");

        if (isCOD) {
            sb.append("<h2 style='font-size:20px;font-weight:800;text-transform:uppercase;margin:0 0 8px;letter-spacing:0.5px;'>Order Placed (COD)</h2>")
              .append("<p style='font-size:14px;color:#666666;margin:0 0 24px;line-height:1.5;'>")
              .append("Thank you for shopping with AuraWear. Your curation choice has been secured. Your order will be delivered to your address, and payment of the total amount should be made in cash upon delivery. Your order details are outlined below:")
              .append("</p>");
        } else {
            sb.append("<h2 style='font-size:20px;font-weight:800;text-transform:uppercase;margin:0 0 8px;letter-spacing:0.5px;'>Order Confirmed</h2>")
              .append("<p style='font-size:14px;color:#666666;margin:0 0 24px;line-height:1.5;'>")
              .append("Thank you for shopping with AuraWear. Your curation choice has been secured. Your order details are outlined below:")
              .append("</p>");
        }

        sb.append("<div style='background:#faf9f6;padding:16px 20px;margin-bottom:24px;border-left:4px solid #ff0001;'>")
          .append("<span style='font-size:12px;font-weight:700;text-transform:uppercase;color:#888888;'>Order Number</span><br>")
          .append("<span style='font-size:16px;font-weight:800;color:#111111;'>#").append(orderId).append("</span>")
          .append("</div>");

        // DELIVERY ADDRESS
        if (shippingName != null && !shippingName.trim().isEmpty()) {
            sb.append("<div style='background:#f8f6f3;padding:16px 20px;margin-bottom:24px;border-left:4px solid #111111;'>")
              .append("<span style='font-size:12px;font-weight:700;text-transform:uppercase;color:#888888;'>Delivery Address</span><br>")
              .append("<span style='font-size:14px;font-weight:700;color:#111111;'>").append(shippingName).append("</span><br>")
              .append("<span style='font-size:13px;color:#555555;'>").append(shippingPhone != null ? shippingPhone : "").append("</span><br>")
              .append("<span style='font-size:13px;color:#555555;'>").append(shippingAddress != null ? shippingAddress : "").append("</span><br>")
              .append("<span style='font-size:13px;color:#555555;'>")
              .append(shippingCity != null ? shippingCity : "").append(", ")
              .append(shippingState != null ? shippingState : "").append(" - ")
              .append(shippingPincode != null ? shippingPincode : "")
              .append("</span>")
              .append("</div>");
        }

        // ITEMS TABLE
        sb.append("<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse;'>")
          .append("<thead><tr style='border-bottom:2px solid #111111;text-align:left;'>")
          .append("<th style='padding:8px 0;font-size:11px;font-weight:700;text-transform:uppercase;color:#111111;'>Item</th>")
          .append("<th style='padding:8px 0;font-size:11px;font-weight:700;text-transform:uppercase;color:#111111;text-align:center;'>Qty</th>")
          .append("<th style='padding:8px 0;font-size:11px;font-weight:700;text-transform:uppercase;color:#111111;text-align:right;'>Price</th>")
          .append("</tr></thead><tbody>");

        for (com.aurawear.model.CartItem item : items) {
            sb.append("<tr style='border-bottom:1px solid #f0ede8;'>")
              .append("<td style='padding:12px 0;'>")
              .append("<span style='font-size:14px;font-weight:600;color:#111111;'>").append(item.getProductName()).append("</span><br>")
              .append("<span style='font-size:11px;color:#888888;'>Size: ").append(item.getSize()).append("</span>")
              .append("</td>")
              .append("<td style='padding:12px 0;font-size:14px;color:#111111;text-align:center;'>").append(item.getQuantity()).append("</td>")
              .append("<td style='padding:12px 0;font-size:14px;font-weight:600;color:#111111;text-align:right;'>₹").append(item.getPrice() * item.getQuantity()).append("</td>")
              .append("</tr>");
        }

        sb.append("</tbody></table>")

          // TOTAL
          .append("<table width='100%' cellpadding='0' cellspacing='0' style='margin-top:20px;'>")
          .append("<tr>");

        if (isCOD) {
            sb.append("<td style='font-size:14px;font-weight:700;color:#666666;'>Total to Pay (COD)</td>");
        } else {
            sb.append("<td style='font-size:14px;font-weight:700;color:#666666;'>Total Paid</td>");
        }

        sb.append("<td style='font-size:20px;font-weight:800;color:#ff0001;text-align:right;'>₹").append(String.format("%.0f", totalAmount)).append("</td>")
          .append("</tr>")
          .append("</table>")
          .append("<hr style='border:none;border-top:1px solid #f0ede8;margin:32px 0 24px;'>")
          .append("<p style='font-size:12px;color:#888888;line-height:1.5;margin:0;text-align:center;'>")
          .append("Our logistics team is already sorting and finalizing your choices. We'll update you as soon as it is shipped.")
          .append("</p>")
          .append("</td></tr>")

          // FOOTER
          .append("<tr><td style='background:#faf9f6;padding:24px 40px;text-align:center;'>")
          .append("<p style='font-size:11px;color:#bbb;margin:0;letter-spacing:0.5px;'>")
          .append("&copy; 2026 AuraWear. All Rights Reserved.</p>")
          .append("</td></tr>")
          .append("</table></td></tr></table></body></html>");

        return sb.toString();
    }
}