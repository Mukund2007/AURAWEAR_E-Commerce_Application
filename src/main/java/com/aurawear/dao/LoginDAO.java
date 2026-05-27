package com.aurawear.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aurawear.util.DBConnection;

public class LoginDAO {

    public boolean validateUser(
            String email,
            String password) {
        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT password FROM users WHERE email=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                return com.aurawear.util.PasswordUtil.verifyPassword(password, storedHash);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;

    }

}