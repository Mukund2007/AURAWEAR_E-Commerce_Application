package com.aurawear.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    private static HikariDataSource dataSource;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            HikariConfig config = new HikariConfig();
            
            String url = System.getenv("AURAWEAR_DB_URL") != null 
                ? System.getenv("AURAWEAR_DB_URL") 
                : "jdbc:mysql://localhost:3306/aurawear";
            String user = System.getenv("AURAWEAR_DB_USER") != null 
                ? System.getenv("AURAWEAR_DB_USER") 
                : "root";
            String password = System.getenv("AURAWEAR_DB_PASSWORD") != null 
                ? System.getenv("AURAWEAR_DB_PASSWORD") 
                : "Root1234";

            config.setJdbcUrl(url);
            config.setUsername(user);
            config.setPassword(password);
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            
            // Fail fast if database is unreachable
            config.addDataSourceProperty("connectTimeout", "5000");
            config.addDataSourceProperty("socketTimeout", "5000");
            
            // Pool configuration for optimized database scaling
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(30000);
            config.setMaxLifetime(1800000);
            config.setConnectionTimeout(10000);

            dataSource = new HikariDataSource(config);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            if (dataSource != null) {
                return dataSource.getConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}