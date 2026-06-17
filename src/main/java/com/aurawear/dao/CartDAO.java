package com.aurawear.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

    // ✅ GET ORDERS BY USER — returns [id, item_total, status, productName, created_at, productId, size, quantity]
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
                "SELECT o.id, oi.price, oi.quantity, o.status, oi.product_name, o.created_at, oi.product_id, oi.size " +
                "FROM orders o " +
                "JOIN order_items oi ON oi.order_id = o.id " +
                "WHERE o.user_email = ? ORDER BY o.id DESC, oi.id ASC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] order = new String[8];
                order[0] = String.valueOf(rs.getInt("id"));
                double price = rs.getDouble("price");
                int qty = rs.getInt("quantity");
                order[1] = String.valueOf(price * qty);
                order[2] = rs.getString("status");
                order[3] = rs.getString("product_name");
                order[4] = rs.getString("created_at");
                order[5] = String.valueOf(rs.getInt("product_id"));
                order[6] = rs.getString("size");
                order[7] = String.valueOf(qty);
                orders.add(order);
            }

            System.out.println("ORDERS FOUND: " + orders.size());

        } catch (Exception e) {
            System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    // ✅ MOVE CART TO ORDERS — Transactional (orders + order_items)
    public void moveCartToOrders(String email) {
        List<CartItem> items = getCartItems(email);
        if (items.isEmpty()) {
            return;
        }

        int subtotal = 0;
        for (CartItem item : items) {
            subtotal += item.getPrice() * item.getQuantity();
        }

        int threshold = com.aurawear.util.SettingsUtil.getFreeShippingThreshold();
        int shippingCharge = com.aurawear.util.SettingsUtil.getShippingCharge();
        int shipping = (subtotal > 0 && subtotal < threshold) ? shippingCharge : 0;
        int grandTotal = subtotal + shipping;
        String paymentId = "PAY-" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) return;
            con.setAutoCommit(false);

            // 1. Insert into orders
            String orderSql = "INSERT INTO orders (user_email, total, status, payment_id) VALUES (?, ?, 'Placed', ?)";
            int orderId = -1;
            try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, email);
                ps.setDouble(2, grandTotal);
                ps.setString(3, paymentId);
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            if (orderId == -1) {
                throw new SQLException("Failed to retrieve generated order ID.");
            }

            // 2. Insert into order_items
            String itemSql = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price, size) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                for (CartItem item : items) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getProductId());
                    ps.setString(3, item.getProductName());
                    ps.setInt(4, item.getQuantity());
                    ps.setDouble(5, item.getPrice());
                    ps.setString(6, item.getSize());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
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

    // ✅ MOVE CART TO ORDERS WITH PAYMENT — Transactional (orders + order_items + delete cart)
    public int moveCartToOrdersWithPayment(String email, String paymentId, String status) throws Exception {
        System.out.println("[CartDAO] Starting moveCartToOrdersWithPayment...");
        System.out.println("[CartDAO] Parameters - email: " + email + ", paymentId: " + paymentId + ", status: " + status);

        int orderId = -1;
        try {
            List<CartItem> items = getCartItems(email);
            System.out.println("[CartDAO] Retrieved " + items.size() + " items from cart.");

            if (items.isEmpty()) {
                System.err.println("[CartDAO] Warning: Cart is empty. Aborting order placement.");
                return -1;
            }

            int subtotal = 0;
            for (CartItem item : items) {
                subtotal += item.getPrice() * item.getQuantity();
            }

            int threshold = com.aurawear.util.SettingsUtil.getFreeShippingThreshold();
            int shippingCharge = com.aurawear.util.SettingsUtil.getShippingCharge();
            int shipping = (subtotal > 0 && subtotal < threshold) ? shippingCharge : 0;
            int grandTotal = subtotal + shipping;
            System.out.println("[CartDAO] Order totals - Subtotal: " + subtotal + ", Shipping: " + shipping + ", Grand Total: " + grandTotal);

            Connection con = null;
            try {
                con = DBConnection.getConnection();
                if (con == null) {
                    throw new SQLException("Database connection is null!");
                }
                con.setAutoCommit(false);
                System.out.println("[CartDAO] autoCommit set to false.");

                // 1. Insert into orders
                // SQL schema verified: (user_email, total, status, payment_id)
                String orderSql = "INSERT INTO orders (user_email, total, status, payment_id) VALUES (?, ?, ?, ?)";
                System.out.println("[CartDAO] Inserting order record into orders table...");
                try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, email);
                    ps.setDouble(2, grandTotal);
                    ps.setString(3, status);
                    ps.setString(4, paymentId);
                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            orderId = rs.getInt(1);
                        }
                    }
                }

                System.out.println("[CartDAO] Successfully inserted order record. Generated ID: " + orderId);

                if (orderId == -1) {
                    throw new SQLException("Failed to retrieve generated order ID.");
                }

                // 2. Insert into order_items
                // SQL schema verified: order_id, product_id, product_name, quantity, price, size
                String itemSql = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price, size) VALUES (?, ?, ?, ?, ?, ?)";
                System.out.println("[CartDAO] Inserting order items into order_items table...");
                try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                    for (CartItem item : items) {
                        System.out.println("[CartDAO] Batching item - ID: " + item.getProductId() + ", Name: " + item.getProductName() + ", Qty: " + item.getQuantity() + ", Price: " + item.getPrice() + ", Size: " + item.getSize());
                        ps.setInt(1, orderId);
                        ps.setInt(2, item.getProductId());
                        ps.setString(3, item.getProductName());
                        ps.setInt(4, item.getQuantity());
                        ps.setDouble(5, item.getPrice());
                        ps.setString(6, item.getSize());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
                System.out.println("[CartDAO] Successfully batch-inserted all order items.");

                // 3. Clear cart
                String clearCartSql = "DELETE FROM cart WHERE user_email=?";
                System.out.println("[CartDAO] Clearing cart for: " + email);
                try (PreparedStatement ps = con.prepareStatement(clearCartSql)) {
                    ps.setString(1, email);
                    ps.executeUpdate();
                }
                System.out.println("[CartDAO] Cart cleared successfully.");

                con.commit();
                System.out.println("[CartDAO] Transaction committed successfully!");
            } catch (Exception e) {
                System.err.println("[CartDAO] Exception occurred during transaction: " + e.getMessage());
                e.printStackTrace();
                if (con != null) {
                    try {
                        System.out.println("[CartDAO] Rolling back transaction...");
                        con.rollback();
                        System.out.println("[CartDAO] Rollback complete.");
                    } catch (SQLException ex) {
                        System.err.println("[CartDAO] Rollback failed!");
                        ex.printStackTrace();
                    }
                }
                throw e; // Rethrow to propagate to the caller
            } finally {
                if (con != null) {
                    try {
                        con.setAutoCommit(true);
                        con.close();
                        System.out.println("[CartDAO] Connection returned to pool.");
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("[CartDAO] Outer exception in moveCartToOrdersWithPayment: " + e.getMessage());
            e.printStackTrace();
            throw e; // Propagate exception to the servlet
        }
        return orderId;
    }
}