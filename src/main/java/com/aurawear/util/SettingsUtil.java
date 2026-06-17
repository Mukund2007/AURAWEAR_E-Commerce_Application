package com.aurawear.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SettingsUtil {
    private static int shippingCharge = 99;
    private static int freeShippingThreshold = 999;
    private static long lastLoadTime = 0;
    private static final long CACHE_DURATION = 10000; // 10 seconds cache

    public static synchronized void loadSettings() {
        long now = System.currentTimeMillis();
        if (now - lastLoadTime < CACHE_DURATION) {
            return;
        }
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM shop_settings");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String key = rs.getString("setting_key");
                String val = rs.getString("setting_value");
                if ("shipping_charge".equals(key)) {
                    shippingCharge = Integer.parseInt(val.trim());
                } else if ("free_shipping_threshold".equals(key)) {
                    freeShippingThreshold = Integer.parseInt(val.trim());
                }
            }
            lastLoadTime = now;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int getShippingCharge() {
        loadSettings();
        return shippingCharge;
    }

    public static int getFreeShippingThreshold() {
        loadSettings();
        return freeShippingThreshold;
    }

    public static synchronized void clearCache() {
        lastLoadTime = 0;
    }
}
