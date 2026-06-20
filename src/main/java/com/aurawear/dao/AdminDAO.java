package com.aurawear.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.aurawear.model.Order;
import com.aurawear.model.OrderItem;
import com.aurawear.model.Product;
import com.aurawear.util.DBConnection;

public class AdminDAO {

    public double getTotalRevenue() {
        double revenue = 0.0;
        String sql = "SELECT SUM(total) FROM orders WHERE status IN ('PAID', 'DELIVERED')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenue;
    }

    public int getTotalOrdersCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getTotalProductsCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY id DESC LIMIT ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapOrder(rs);
                    order.setItems(getOrderItems(order.getId()));
                    orders.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = mapOrder(rs);
                order.setItems(getOrderItems(order.getId()));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    item.setSize(rs.getString("size"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Get previous status
            String prevStatusSql = "SELECT status FROM orders WHERE id = ?";
            String prevStatus = "";
            try (PreparedStatement psPrev = con.prepareStatement(prevStatusSql)) {
                psPrev.setInt(1, orderId);
                try (ResultSet rs = psPrev.executeQuery()) {
                    if (rs.next()) {
                        prevStatus = rs.getString("status");
                    }
                }
            }

            // Update order status
            String sql = "UPDATE orders SET status = ? WHERE id = ?";
            boolean updated;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, orderId);
                updated = ps.executeUpdate() > 0;
            }

            if (updated) {
                boolean wasActive = !("Cancelled".equalsIgnoreCase(prevStatus) || "Returned".equalsIgnoreCase(prevStatus));
                boolean isInactive = "Cancelled".equalsIgnoreCase(status) || "Returned".equalsIgnoreCase(status);

                if (wasActive && isInactive) {
                    // Restore stock
                    String getItemsSql = "SELECT product_id, quantity FROM order_items WHERE order_id = ?";
                    try (PreparedStatement psGetItems = con.prepareStatement(getItemsSql)) {
                        psGetItems.setInt(1, orderId);
                        try (ResultSet rsItems = psGetItems.executeQuery()) {
                            String restoreStockSql = "UPDATE products SET stock_quantity = stock_quantity + ? WHERE id = ?";
                            try (PreparedStatement psRestore = con.prepareStatement(restoreStockSql)) {
                                while (rsItems.next()) {
                                    int productId = rsItems.getInt("product_id");
                                    int quantity = rsItems.getInt("quantity");
                                    psRestore.setInt(1, quantity);
                                    psRestore.setInt(2, productId);
                                    psRestore.executeUpdate();
                                }
                            }
                        }
                    }
                } else if (!wasActive && !isInactive) {
                    // If moving from Cancelled/Returned back to active, decrement stock
                    String getItemsSql = "SELECT product_id, quantity FROM order_items WHERE order_id = ?";
                    try (PreparedStatement psGetItems = con.prepareStatement(getItemsSql)) {
                        psGetItems.setInt(1, orderId);
                        try (ResultSet rsItems = psGetItems.executeQuery()) {
                            String deductStockSql = "UPDATE products SET stock_quantity = GREATEST(stock_quantity - ?, 0) WHERE id = ?";
                            try (PreparedStatement psDeduct = con.prepareStatement(deductStockSql)) {
                                while (rsItems.next()) {
                                    int productId = rsItems.getInt("product_id");
                                    int quantity = rsItems.getInt("quantity");
                                    psDeduct.setInt(1, quantity);
                                    psDeduct.setInt(2, productId);
                                    psDeduct.executeUpdate();
                                }
                            }
                        }
                    }
                }
                con.commit();
                return true;
            } else {
                con.rollback();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
        return false;
    }

    public boolean addProduct(Product p) {
        String sql = "INSERT INTO products (name, price, category, image, original_price, discount, rating, reviews, brand, type, size, color, gender, stock_quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, (int) p.getPrice());
            ps.setString(3, p.getCategory());
            ps.setString(4, p.getImage());
            ps.setInt(5, (int) p.getOriginalPrice());
            ps.setInt(6, p.getDiscount());
            ps.setDouble(7, p.getRating());
            ps.setInt(8, p.getReviews());
            ps.setString(9, p.getBrand());
            ps.setString(10, p.getType());
            ps.setString(11, p.getSize());
            ps.setString(12, p.getColor());
            ps.setString(13, p.getGender());
            ps.setInt(14, p.getStockQuantity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product p) {
        String sql = "UPDATE products SET name=?, price=?, category=?, image=?, original_price=?, discount=?, brand=?, type=?, size=?, color=?, gender=?, stock_quantity=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, (int) p.getPrice());
            ps.setString(3, p.getCategory());
            ps.setString(4, p.getImage());
            ps.setInt(5, (int) p.getOriginalPrice());
            ps.setInt(6, p.getDiscount());
            ps.setString(7, p.getBrand());
            ps.setString(8, p.getType());
            ps.setString(9, p.getSize());
            ps.setString(10, p.getColor());
            ps.setString(11, p.getGender());
            ps.setInt(12, p.getStockQuantity());
            ps.setInt(13, p.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserEmail(rs.getString("user_email"));
        order.setTotal(rs.getDouble("total"));
        order.setStatus(rs.getString("status"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setPaymentId(rs.getString("payment_id"));
        order.setShippingName(rs.getString("shipping_name"));
        order.setShippingPhone(rs.getString("shipping_phone"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setShippingCity(rs.getString("shipping_city"));
        order.setShippingState(rs.getString("shipping_state"));
        order.setShippingPincode(rs.getString("shipping_pincode"));
        return order;
    }
}
