package com.aurawear.controller;

import java.io.*;
import java.sql.*;
import com.aurawear.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/db-init")
public class DbInitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Database Initializer</title></head><body style='font-family:sans-serif; padding:20px; max-width:800px; margin:0 auto;'>");
        out.println("<h2>Database Initialization Status</h2>");
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                out.println("<p style='color:red;'>Failed to connect to the database. Connection is null.</p>");
                out.println("</body></html>");
                return;
            }
            
            out.println("<p style='color:green;'>Connected to database successfully.</p>");
            
            // Read schema.sql from classpath
            InputStream is = getClass().getClassLoader().getResourceAsStream("schema.sql");
            if (is == null) {
                out.println("<p style='color:red;'>Could not find schema.sql in classpath.</p>");
                out.println("</body></html>");
                return;
            }
            
            BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            
            Statement stmt = conn.createStatement();
            stmt.execute("SET FOREIGN_KEY_CHECKS = 0;");
            int executedCount = 0;
            int failedCount = 0;
            
            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                // Skip comments and empty lines
                if (trimmed.isEmpty() || trimmed.startsWith("--") || trimmed.startsWith("/*") || trimmed.startsWith("#")) {
                    continue;
                }
                
                sb.append(line).append("\n");
                
                if (trimmed.endsWith(";")) {
                    String sql = sb.toString().trim();
                    // Remove trailing semicolon for execute
                    if (sql.endsWith(";")) {
                        sql = sql.substring(0, sql.length() - 1).trim();
                    }
                    
                    try {
                        if (!sql.isEmpty()) {
                            stmt.execute(sql);
                            executedCount++;
                        }
                    } catch (SQLException ex) {
                        failedCount++;
                        out.println("<p style='color:orange;'>Failed statement: <code>" + sql.substring(0, Math.min(100, sql.length())) + "...</code><br>Error: " + ex.getMessage() + "</p>");
                    }
                    
                    sb.setLength(0); // clear buffer
                }
            }
            stmt.execute("SET FOREIGN_KEY_CHECKS = 1;");
            
            out.println("<p><b>Initialization complete.</b></p>");
            out.println("<p>Successfully executed: " + executedCount + " statements.</p>");
            if (failedCount > 0) {
                out.println("<p style='color:red;'>Failed statements: " + failedCount + "</p>");
            } else {
                out.println("<p style='color:green;'>All statements executed successfully without errors!</p>");
            }
            
        } catch (Exception e) {
            out.println("<p style='color:red;'>An error occurred: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        out.println("<p><a href='" + request.getContextPath() + "/home'>Go to Homepage</a></p>");
        out.println("</body></html>");
    }
}
