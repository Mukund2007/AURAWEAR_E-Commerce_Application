package com.aurawear.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    // ✅ Loaded from Environment Variables (with fallback values for local development)
    private static final String FROM_EMAIL = System.getenv("AURAWEAR_EMAIL") != null 
        ? System.getenv("AURAWEAR_EMAIL") 
        : "aurawear1976@gmail.com";
    private static final String APP_PASSWORD = System.getenv("AURAWEAR_EMAIL_PASSWORD") != null 
        ? System.getenv("AURAWEAR_EMAIL_PASSWORD") 
        : "ankj vguy cxiy jolz";

    public static void sendOTP(String toEmail, String otp) throws MessagingException, java.io.UnsupportedEncodingException {

        Properties props = new Properties();
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL, "AuraWear"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Your AuraWear Verification Code");
        message.setContent(buildEmailHTML(otp), "text/html; charset=utf-8");

        Transport.send(message);
        System.out.println("OTP email sent to: " + toEmail);
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
}