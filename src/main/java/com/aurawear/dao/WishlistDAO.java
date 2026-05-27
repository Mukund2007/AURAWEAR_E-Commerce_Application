package com.aurawear.dao;

import java.sql.*;
import java.util.*;
import com.aurawear.model.WishlistItem;
import com.aurawear.util.DBConnection;

public class WishlistDAO {

    /* ADD */
    public void addToWishlist(String email, String productName, double price) {
        try (Connection conn = DBConnection.getConnection()) {
            String checkSql = "SELECT * FROM wishlist WHERE user_email=? AND product_name=?";
            PreparedStatement check = conn.prepareStatement(checkSql);
            check.setString(1, email);
            check.setString(2, productName);
            ResultSet rs = check.executeQuery();
            if (rs.next()) return; // already exists

            String sql = "INSERT INTO wishlist(user_email, product_name, price) VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, productName);
            ps.setDouble(3, price);
            ps.executeUpdate();
            System.out.println("Wishlist added: " + productName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* REMOVE BY NAME */
    public void removeFromWishlist(String email, String productName) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM wishlist WHERE user_email=? AND product_name=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, productName);
            ps.executeUpdate();
            System.out.println("Wishlist removed: " + productName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* WISHLIST PAGE — JOIN with products to get id, size, image */
    public List<WishlistItem> getWishlistByEmail(String email) {
        List<WishlistItem> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql =
                "SELECT w.product_name, w.price, p.id, p.size, p.image " +
                "FROM wishlist w " +
                "LEFT JOIN products p ON p.name = w.product_name " +
                "WHERE w.user_email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WishlistItem item = new WishlistItem();
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getDouble("price"));
                item.setProductId(rs.getInt("id"));
                item.setSize(rs.getString("size"));
                item.setImage(rs.getString("image"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /* HEART PERSISTENCE — for products page active state */
    /* GET WISHLIST PRODUCT IDs */
    public Set<Integer> getWishlistProductIds(String email) {
        Set<Integer> ids = new HashSet<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = 
                "SELECT p.id FROM wishlist w " +
                "JOIN products p ON p.name = w.product_name " +
                "WHERE w.user_email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }
}