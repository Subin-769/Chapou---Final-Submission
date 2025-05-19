package com.chapou.model;

public class ProductModel {
    private int Product_Id;
    private String Name;
    private int Quantity;
    private String Description;
    private double Price;
    private String Product_Image; 

    // Constructors
    public ProductModel() {}

    public ProductModel(int productId, String name, int quantity, String description, double price, String productImage) {
        this.Product_Id = productId;
        this.Name = name;
        this.Quantity = quantity;
        this.Description = description;
        this.Price = price;
        this.Product_Image = productImage;
    }

    // Getters and Setters
    public int getProductId() {
        return Product_Id;
    }

    public void setProductId(int productId) {
        this.Product_Id = productId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int quantity) {
        this.Quantity = quantity;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        this.Description = description;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double price) {
        this.Price = price;
    }

    public String getProduct_Image() {
        return Product_Image;
    }

    public void setProduct_Image(String productImage) {
        this.Product_Image = productImage;
    }
}
