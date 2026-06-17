package com.aurawear.config;

/**
 * Razorpay Configuration
 * 
 * Domestic Test Card:
 * Card Number: 5267 3181 8797 5449 (Mastercard, India-issued)
 * Expiry: Any future date (e.g., 12/30)
 * CVV: 123
 */
public class RazorpayConfig {
    private static final boolean LIVE_MODE = 
        Boolean.parseBoolean(System.getenv("RAZORPAY_LIVE_MODE") != null ? System.getenv("RAZORPAY_LIVE_MODE") : "false");
    
    public static String getKeyId() {
        String key = LIVE_MODE 
            ? System.getenv("RAZORPAY_LIVE_KEY_ID") 
            : System.getenv("RAZORPAY_TEST_KEY_ID");
        if (key == null) throw new RuntimeException("Razorpay Key ID environment variable not set");
        return key;
    }
    
    public static String getKeySecret() {
        String secret = LIVE_MODE 
            ? System.getenv("RAZORPAY_LIVE_KEY_SECRET") 
            : System.getenv("RAZORPAY_TEST_KEY_SECRET");
        if (secret == null) throw new RuntimeException("Razorpay Key Secret environment variable not set");
        return secret;
    }
}
