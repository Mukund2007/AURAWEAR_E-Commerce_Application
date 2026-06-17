package com.aurawear.dao;

import java.sql.*;
import java.util.*;

import com.aurawear.model.Product;
import com.aurawear.util.DBConnection;

public class ProductDAO {

    // ================= GET ALL =================
    public List<Product> getAllProducts(String sort) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        if      ("priceLow".equals(sort))  sql += " ORDER BY price ASC";
        else if ("priceHigh".equals(sort)) sql += " ORDER BY price DESC";
        else if ("rating".equals(sort))    sql += " ORDER BY rating DESC";
        else if ("newest".equals(sort))    sql += " ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ================= SEARCH =================
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        List<String> searchTerms = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String lowerKeyword = keyword.trim().toLowerCase();
            searchTerms.add(keyword);
            
            // Footwear synonyms
            if (lowerKeyword.contains("shoe") || lowerKeyword.contains("sneaker") || lowerKeyword.contains("boot") || lowerKeyword.contains("footwear")) {
                searchTerms.add("Footwear");
            }
            // Tops synonyms
            if (lowerKeyword.contains("top") || lowerKeyword.contains("shirt") || lowerKeyword.contains("tee") || lowerKeyword.contains("hoodie") || lowerKeyword.contains("t-shirt") || lowerKeyword.contains("tshirt")) {
                searchTerms.add("Tops");
                searchTerms.add("Streetwear");
            }
            // Bottoms/Pants synonyms
            if (lowerKeyword.contains("bottom") || lowerKeyword.contains("pant") || lowerKeyword.contains("short") || lowerKeyword.contains("cargo") || lowerKeyword.contains("jean") || lowerKeyword.contains("jogger")) {
                searchTerms.add("Bottoms");
                searchTerms.add("Pants");
            }
            // Accessories synonyms
            if (lowerKeyword.contains("accessory") || lowerKeyword.contains("accessories") || lowerKeyword.contains("cap") || lowerKeyword.contains("hat") || lowerKeyword.contains("bag")) {
                searchTerms.add("Accessories");
            }
        }

        if (searchTerms.isEmpty()) {
            return list;
        }

        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE ");
        for (int i = 0; i < searchTerms.size(); i++) {
            if (i > 0) sql.append(" OR ");
            sql.append("(name LIKE ? OR category LIKE ? OR gender LIKE ? OR color LIKE ?)");
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            for (String term : searchTerms) {
                String wildcard = "%" + term + "%";
                ps.setString(idx++, wildcard);
                ps.setString(idx++, wildcard);
                ps.setString(idx++, wildcard);
                ps.setString(idx++, wildcard);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ================= FILTER =================
    public List<Product> filterProducts(
            String gender, String keyword,
            String[] categories, String[] sizes, String[] colors,
            double minPrice, double maxPrice, String sort) {

        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");

        List<String> searchTerms = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            String lowerKeyword = keyword.trim().toLowerCase();
            searchTerms.add(keyword);
            if (lowerKeyword.contains("shoe") || lowerKeyword.contains("sneaker") || lowerKeyword.contains("boot") || lowerKeyword.contains("footwear")) {
                searchTerms.add("Footwear");
            }
            if (lowerKeyword.contains("top") || lowerKeyword.contains("shirt") || lowerKeyword.contains("tee") || lowerKeyword.contains("hoodie") || lowerKeyword.contains("t-shirt") || lowerKeyword.contains("tshirt")) {
                searchTerms.add("Tops");
                searchTerms.add("Streetwear");
            }
            if (lowerKeyword.contains("bottom") || lowerKeyword.contains("pant") || lowerKeyword.contains("short") || lowerKeyword.contains("cargo") || lowerKeyword.contains("jean") || lowerKeyword.contains("jogger")) {
                searchTerms.add("Bottoms");
                searchTerms.add("Pants");
            }
            if (lowerKeyword.contains("accessory") || lowerKeyword.contains("accessories") || lowerKeyword.contains("cap") || lowerKeyword.contains("hat") || lowerKeyword.contains("bag")) {
                searchTerms.add("Accessories");
            }
        }

        if (gender != null && !gender.trim().isEmpty())
            sql.append(" AND gender = ?");

        if (!searchTerms.isEmpty()) {
            sql.append(" AND (");
            for (int i = 0; i < searchTerms.size(); i++) {
                if (i > 0) sql.append(" OR ");
                sql.append("(name LIKE ? OR category LIKE ? OR gender LIKE ? OR color LIKE ?)");
            }
            sql.append(")");
        }

        if (categories != null && categories.length > 0) {
            sql.append(" AND category IN ("); appendPlaceholders(sql, categories.length); sql.append(")");
        }
        if (sizes != null && sizes.length > 0) {
            sql.append(" AND size IN ("); appendPlaceholders(sql, sizes.length); sql.append(")");
        }
        if (colors != null && colors.length > 0) {
            sql.append(" AND color IN ("); appendPlaceholders(sql, colors.length); sql.append(")");
        }
        if (minPrice > 0 || maxPrice < Double.MAX_VALUE)
            sql.append(" AND price BETWEEN ? AND ?");

        if      ("priceLow".equals(sort))  sql.append(" ORDER BY price ASC");
        else if ("priceHigh".equals(sort)) sql.append(" ORDER BY price DESC");
        else if ("rating".equals(sort))    sql.append(" ORDER BY rating DESC");
        else if ("newest".equals(sort))    sql.append(" ORDER BY id DESC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (gender != null && !gender.trim().isEmpty())         ps.setString(idx++, gender);
            if (!searchTerms.isEmpty()) {
                for (String term : searchTerms) {
                    String wildcard = "%" + term + "%";
                    ps.setString(idx++, wildcard);
                    ps.setString(idx++, wildcard);
                    ps.setString(idx++, wildcard);
                    ps.setString(idx++, wildcard);
                }
            }
            if (categories != null) for (String c : categories)    ps.setString(idx++, c);
            if (sizes != null)      for (String s : sizes)         ps.setString(idx++, s);
            if (colors != null)     for (String c : colors)        ps.setString(idx++, c);
            if (minPrice > 0 || maxPrice < Double.MAX_VALUE) {
                ps.setDouble(idx++, minPrice);
                ps.setDouble(idx++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ================= GET BY ID =================
    public Product getProductById(int id) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ================= TRENDING =================
    public List<Product> getTrendingProducts() {
        List<Product> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM products ORDER BY rating DESC LIMIT 10");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ================= RELATED PRODUCTS =================
    public List<Product> getRelatedProducts(String category, int excludeId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ? AND id != ? LIMIT 4";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, category);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================= HELPERS =================
    private void appendPlaceholders(StringBuilder sql, int count) {
        for (int i = 0; i < count; i++) {
            sql.append(i < count - 1 ? "?," : "?");
        }
    }

    private Product map(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setPrice(rs.getDouble("price"));
        p.setCategory(rs.getString("category"));
        
        p.setSize(rs.getString("size"));
        p.setColor(rs.getString("color"));
        p.setGender(rs.getString("gender"));   // ✅ was missing — breaks gender filter
        p.setRating(rs.getDouble("rating"));
        p.setReviews(rs.getInt("reviews"));
        p.setImage(rs.getString("image"));
        
        p.setOriginalPrice(rs.getDouble("original_price"));
        p.setDiscount(rs.getInt("discount"));
        p.setBrand(rs.getString("brand"));
        p.setType(rs.getString("type"));
        return p;
    }
}