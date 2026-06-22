package com.aurawear.config;

/**
 * Razorpay Configuration
 *
 * All credentials are loaded exclusively via AppConfig (env → JVM property → app-local.properties).
 * No hardcoded fallback values. The application fails fast if a required key is absent.
 *
 * Required environment variables:
 *   RAZORPAY_LIVE_MODE       — "true" for live payments, "false" for test mode
 *   RAZORPAY_LIVE_KEY_ID     — live key ID  (required when LIVE_MODE=true)
 *   RAZORPAY_LIVE_KEY_SECRET — live secret  (required when LIVE_MODE=true)
 *   RAZORPAY_TEST_KEY_ID     — test key ID  (required when LIVE_MODE=false)
 *   RAZORPAY_TEST_KEY_SECRET — test secret  (required when LIVE_MODE=false)
 */
public class RazorpayConfig {

    private static final boolean LIVE_MODE = AppConfig.getBoolean("RAZORPAY_LIVE_MODE");

    public static boolean isLiveMode() {
        return LIVE_MODE;
    }

    public static String getKeyId() {
        String envKey = LIVE_MODE ? "RAZORPAY_LIVE_KEY_ID" : "RAZORPAY_TEST_KEY_ID";
        String key = AppConfig.get(envKey);
        if (key == null) throw new RuntimeException(
            "[RazorpayConfig] " + envKey + " is not set. " +
            "Configure it as an environment variable or in app-local.properties.");
        return key;
    }

    public static String getKeySecret() {
        String envKey = LIVE_MODE ? "RAZORPAY_LIVE_KEY_SECRET" : "RAZORPAY_TEST_KEY_SECRET";
        String secret = AppConfig.get(envKey);
        if (secret == null) throw new RuntimeException(
            "[RazorpayConfig] " + envKey + " is not set. " +
            "Configure it as an environment variable or in app-local.properties.");
        return secret;
    }
}
