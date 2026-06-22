package com.aurawear.util;

import com.aurawear.config.AppConfig;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

/**
 * Email utility for sending OTP and order confirmation emails via Gmail SMTP.
 *
 * Credentials are loaded exclusively from environment variables via AppConfig:
 *   AURAWEAR_EMAIL          — sender Gmail address
 *   AURAWEAR_EMAIL_PASSWORD — Gmail App Password (16-char, no spaces)
 *
 * No hardcoded credentials. Local development values go in
 * src/main/resources/app-local.properties (git-ignored).
 */
public class EmailUtil {

    private static String getFromEmail() {
        String v = AppConfig.get("AURAWEAR_EMAIL");
        if (v == null) throw new RuntimeException(
            "[EmailUtil] AURAWEAR_EMAIL environment variable is not set");
        return v;
    }

    private static String getAppPassword() {
        String v = AppConfig.get("AURAWEAR_EMAIL_PASSWORD");
        if (v == null) throw new RuntimeException(
            "[EmailUtil] AURAWEAR_EMAIL_PASSWORD environment variable is not set");
        return v;
    }

    public static void sendOTP(String toEmail, String otp) throws MessagingException, java.io.UnsupportedEncodingException {

        System.out.println("[EmailUtil.sendOTP] Recipient parameter: '" + toEmail + "'");
        System.out.println("[EmailUtil.sendOTP] OTP parameter: '" + otp + "'");
        System.out.println("[EmailUtil.sendOTP] SMTP Sender Address: '" + getFromEmail() + "'");
        System.out.println("[EmailUtil.sendOTP] SMTP Recipient Address: '" + toEmail + "'");
        System.out.println("[EmailUtil.sendOTP] SMTP Authentication: Initializing Session authentication with Gmail...");

        Properties props = new Properties();
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout",           "10000");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(getFromEmail(), getAppPassword());
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(getFromEmail(), "AuraWear"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Your AuraWear Verification Code");
        message.setContent(buildEmailHTML(otp), "text/html; charset=utf-8");

        System.out.println("[EmailUtil.sendOTP] SMTP sending message via Transport.send()...");
        Transport.send(message);
        System.out.println("[EmailUtil.sendOTP] SMTP send succeeds. Gmail accepted the message for: " + toEmail);
    }

    private static String buildEmailHTML(String otp) {
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

    public static void sendOrderConfirmation(String toEmail, String orderId, java.util.List<com.aurawear.model.CartItem> items, double totalAmount) throws MessagingException, java.io.UnsupportedEncodingException {
        sendOrderConfirmation(toEmail, orderId, items, totalAmount, false, null, null, null, null, null, null);
    }

    public static void sendOrderConfirmation(String toEmail, String orderId, java.util.List<com.aurawear.model.CartItem> items, double totalAmount, boolean isCOD) throws MessagingException, java.io.UnsupportedEncodingException {
        sendOrderConfirmation(toEmail, orderId, items, totalAmount, isCOD, null, null, null, null, null, null);
    }

    public static void sendOrderConfirmation(String toEmail, String orderId, java.util.List<com.aurawear.model.CartItem> items, double totalAmount, boolean isCOD,
                                             String shippingName, String shippingPhone, String shippingAddress,
                                             String shippingCity, String shippingState, String shippingPincode) throws MessagingException, java.io.UnsupportedEncodingException {
        Properties props = new Properties();
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout",           "10000");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(getFromEmail(), getAppPassword());
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(getFromEmail(), "AuraWear"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(isCOD ? "Your AuraWear Order Confirmation (COD) - #" + orderId : "Your AuraWear Order Confirmation - #" + orderId);
        message.setContent(buildOrderEmailHTML(orderId, items, totalAmount, isCOD, shippingName, shippingPhone, shippingAddress, shippingCity, shippingState, shippingPincode), "text/html; charset=utf-8");

        Transport.send(message);
        System.out.println("Order confirmation email sent to: " + toEmail + " for order: " + orderId + " (COD=" + isCOD + ")");
    }

    private static String buildOrderEmailHTML(String orderId, java.util.List<com.aurawear.model.CartItem> items, double totalAmount, boolean isCOD,
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
          
        // DELIVERY ADDRESS BLOCK
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