package com.aurawear.model;

public class CartItem {

    private int productId;
    private String size;
    private int price;

    // ✅ NEW
    private String productName;
    private String image;
    private int quantity;

    // GETTERS
    public int getProductId() { return productId; }
    public String getSize() { return size; }
    public int getPrice() { return price; }
    public String getProductName() { return productName; }
    public String getImage() { return image; }
    public int getQuantity() { return quantity; }

    // SETTERS
    public void setProductId(int productId) { this.productId = productId; }
    public void setSize(String size) { this.size = size; }
    public void setPrice(int price) { this.price = price; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setImage(String image) { this.image = image; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}