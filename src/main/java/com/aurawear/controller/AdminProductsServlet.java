package com.aurawear.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.aurawear.dao.AdminDAO;
import com.aurawear.dao.ProductDAO;
import com.aurawear.model.Product;
import com.aurawear.model.User;

public class AdminProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getAllProducts(null);

        request.setAttribute("products", products);

        request.getRequestDispatcher("/WEB-INF/views/admin/admin-products.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        AdminDAO adminDAO = new AdminDAO();

        try {
            if ("add".equals(action)) {
                Product p = new Product();
                p.setName(request.getParameter("name"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                
                String origPriceStr = request.getParameter("originalPrice");
                double origPrice = (origPriceStr != null && !origPriceStr.isEmpty()) 
                    ? Double.parseDouble(origPriceStr) 
                    : p.getPrice();
                p.setOriginalPrice(origPrice);
                
                String discountStr = request.getParameter("discount");
                int discount = (discountStr != null && !discountStr.isEmpty()) 
                    ? Integer.parseInt(discountStr) 
                    : 0;
                p.setDiscount(discount);
                
                p.setCategory(request.getParameter("category"));
                p.setType(request.getParameter("type"));
                p.setSize(request.getParameter("size"));
                p.setColor(request.getParameter("color"));
                p.setGender(request.getParameter("gender"));
                p.setBrand(request.getParameter("brand"));
                p.setImage(request.getParameter("image"));
                
                // New products start with no ratings yet
                p.setRating(0.0);
                p.setReviews(0);

                String stockStr = request.getParameter("stockQuantity");
                int stock = (stockStr != null && !stockStr.isEmpty()) ? Integer.parseInt(stockStr) : 100;
                p.setStockQuantity(stock);

                boolean success = adminDAO.addProduct(p);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?msg=Product+added+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/products?error=failed_to_add");
                }

            } else if ("edit".equals(action)) {
                Product p = new Product();
                p.setId(Integer.parseInt(request.getParameter("productId")));
                p.setName(request.getParameter("name"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                
                String origPriceStr = request.getParameter("originalPrice");
                double origPrice = (origPriceStr != null && !origPriceStr.isEmpty()) 
                    ? Double.parseDouble(origPriceStr) 
                    : p.getPrice();
                p.setOriginalPrice(origPrice);
                
                String discountStr = request.getParameter("discount");
                int discount = (discountStr != null && !discountStr.isEmpty()) 
                    ? Integer.parseInt(discountStr) 
                    : 0;
                p.setDiscount(discount);
                
                p.setCategory(request.getParameter("category"));
                p.setType(request.getParameter("type"));
                p.setSize(request.getParameter("size"));
                p.setColor(request.getParameter("color"));
                p.setGender(request.getParameter("gender"));
                p.setBrand(request.getParameter("brand"));
                p.setImage(request.getParameter("image"));

                String editStockStr = request.getParameter("stockQuantity");
                int editStock = (editStockStr != null && !editStockStr.isEmpty()) ? Integer.parseInt(editStockStr) : 100;
                p.setStockQuantity(editStock);

                boolean success = adminDAO.updateProduct(p);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?msg=Product+updated+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/products?error=failed_to_update");
                }

            } else if ("delete".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                boolean success = adminDAO.deleteProduct(productId);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?msg=Product+deleted+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/products?error=failed_to_delete");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=unknown_action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?error=invalid_data");
        }
    }
}
