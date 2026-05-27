package com.aurawear.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.aurawear.model.CartItem;
import com.aurawear.util.DBConnection;

public class CartDAO {

    // ✅ ADD TO CART
    public void addToCart(String email, int productId, String size, int price) {

        try (Connection con = DBConnection.getConnection()) {

            // CHECK IF ITEM EXISTS
            String checkSql = "SELECT quantity FROM cart WHERE user_email=? AND product_id=? AND size=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);

            checkPs.setString(1, email);
            checkPs.setInt(2, productId);
            checkPs.setString(3, size);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // UPDATE QUANTITY
                String updateSql = "UPDATE cart SET quantity = quantity + 1 WHERE user_email=? AND product_id=? AND size=?";
                PreparedStatement updatePs = con.prepareStatement(updateSql);

                updatePs.setString(1, email);
                updatePs.setInt(2, productId);
                updatePs.setString(3, size);

                updatePs.executeUpdate();

            } else {
                // INSERT NEW
                String insertSql = "INSERT INTO cart (user_email, product_id, size, price, quantity) VALUES (?, ?, ?, ?, 1)";
                PreparedStatement insertPs = con.prepareStatement(insertSql);

                insertPs.setString(1, email);
                insertPs.setInt(2, productId);
                insertPs.setString(3, size);
                insertPs.setInt(4, price);

                insertPs.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ GET CART ITEMS
    public List<CartItem> getCartItems(String email) {

        List<CartItem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "SELECT c.product_id, c.size, c.price, c.quantity, p.name, p.image " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.id " +
                "WHERE c.user_email = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();

                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSize(rs.getString("size"));
                item.setPrice(rs.getInt("price"));
                item.setProductName(rs.getString("name"));
                item.setImage(rs.getString("image"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ GET ORDERS BY USER — returns [id, total, status, productName]
 // ✅ GET ORDERS BY USER — fixed to match actual orders table schema
    // orders table: id, user_email, total, status, created_at, product_name
    public static List<String[]> getOrdersByUser(int userId) {
        List<String[]> orders = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {

            System.out.println("LOOKING UP USER ID: " + userId);

            String emailSql = "SELECT email FROM users WHERE id = ?";
            PreparedStatement emailPs = con.prepareStatement(emailSql);
            emailPs.setInt(1, userId);
            ResultSet emailRs = emailPs.executeQuery();

            if (!emailRs.next()) {
                System.out.println("NO USER FOUND FOR ID: " + userId);
                return orders;
            }

            String email = emailRs.getString("email");
            System.out.println("FOUND EMAIL: " + email);

            String sql =
                "SELECT id, total, status, product_name, created_at, product_id " +
                "FROM orders WHERE user_email = ? ORDER BY id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] order = new String[6];
                order[0] = String.valueOf(rs.getInt("id"));
                order[1] = String.valueOf(rs.getDouble("total"));
                order[2] = rs.getString("status");
                order[3] = rs.getString("product_name");
                order[4] = rs.getString("created_at");
                order[5] = String.valueOf(rs.getInt("product_id"));
                orders.add(order);
            }

            System.out.println("ORDERS FOUND: " + orders.size());

        } catch (Exception e) {
            System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ MOVE CART TO ORDERS
    public void moveCartToOrders(String email) {
        List<CartItem> items = getCartItems(email);
        if (items.isEmpty()) {
            return;
        }

        int subtotal = 0;
        for (CartItem item : items) {
            subtotal += item.getPrice() * item.getQuantity();
        }

        int shipping = (subtotal > 0 && subtotal < 999) ? 99 : 0;

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO orders (user_email, product_id, product_name, total, status) VALUES (?, ?, ?, ?, 'Placed')";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                for (int i = 0; i < items.size(); i++) {
                    CartItem item = items.get(i);
                    int itemTotal = item.getPrice() * item.getQuantity();
                    
                    // Add the entire shipping fee to the first item so the order sum matches grand total
                    if (i == 0) {
                        itemTotal += shipping;
                    }

                    ps.setString(1, email);
                    ps.setInt(2, item.getProductId());
                    ps.setString(3, item.getProductName());
                    ps.setDouble(4, itemTotal);
                    ps.addBatch();
                }
                ps.executeBatch();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ CLEAR CART
    public void clearCart(String email) {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "DELETE FROM cart WHERE user_email=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ REMOVE SINGLE ITEM
    public void removeItem(String email, int productId, String size) {
        try (Connection con = DBConnection.getConnection()) {

            String sql = "DELETE FROM cart WHERE user_email=? AND product_id=? AND size=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setInt(2, productId);
            ps.setString(3, size);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ UPDATE QUANTITY
    public int updateQuantity(String email, int productId, String size, int change) {

        int newQty = 1;

        try (Connection con = DBConnection.getConnection()) {

            String getSql = "SELECT quantity FROM cart WHERE user_email=? AND product_id=? AND size=?";
            PreparedStatement ps1 = con.prepareStatement(getSql);
            ps1.setString(1, email);
            ps1.setInt(2, productId);
            ps1.setString(3, size);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                int currentQty = rs.getInt("quantity");
                newQty = Math.max(1, currentQty + change);

                String updateSql = "UPDATE cart SET quantity=? WHERE user_email=? AND product_id=? AND size=?";
                PreparedStatement ps2 = con.prepareStatement(updateSql);

                ps2.setInt(1, newQty);
                ps2.setString(2, email);
                ps2.setInt(3, productId);
                ps2.setString(4, size);

                ps2.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return newQty;
    }

    // ✅ GET CART COUNT
    public int getCartCount(String email) {

        int count = 0;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT SUM(quantity) FROM cart WHERE user_email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}