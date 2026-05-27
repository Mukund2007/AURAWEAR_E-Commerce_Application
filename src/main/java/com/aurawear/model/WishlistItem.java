package com.aurawear.model;

public class WishlistItem {

    private String productName;
    private double price;
    private int    productId;
    private String size;
    private String image;

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}