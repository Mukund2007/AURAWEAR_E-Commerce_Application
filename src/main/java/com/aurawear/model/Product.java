package com.aurawear.model;

public class Product {

    private int    id;
    private String name;
    private double price;
    private String category;
    private String size;
    private String color;
    private String gender;   // ✅ added
    private double rating;
    private int    reviews;
    private String image;

    public Product() {}

    // ===== GETTERS & SETTERS =====

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public int getReviews() { return reviews; }
    public void setReviews(int reviews) { this.reviews = reviews; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    // ===== STAR HELPERS =====
    public int getFullStars() { return (int) rating; }
    public boolean isHalfStar() { return (rating - (int) rating) >= 0.5; }
}