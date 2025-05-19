package com.chapou.service;

import com.chapou.config.DbConfig;
import com.chapou.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    // Get all products from the database
    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();

        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT * FROM products";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setProductId(rs.getInt("Product_Id"));
                product.setName(rs.getString("Name"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setProduct_Image(rs.getString("Product_Image"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    // Get a single product by its ID
    public ProductModel getProductById(int id) {
        ProductModel product = null;
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE Product_Id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                product = new ProductModel(
                    rs.getInt("Product_Id"),
                    rs.getString("Name"),
                    rs.getInt("Quantity"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getString("Product_Image")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
    
 // Update product quantity by product ID
    public boolean updateProductQuantity(int productId, int quantityToSubtract) {
        String query = "UPDATE products SET Quantity = Quantity - ? WHERE Product_Id = ? AND Quantity >= ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, quantityToSubtract); 
            stmt.setInt(2, productId);
            stmt.setInt(3, quantityToSubtract); // make sure enough in stock

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public void addProduct(ProductModel product) {
        String sql = "INSERT INTO products (Name, Quantity, Description, Price, Product_Image) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getName());
            stmt.setInt(2, product.getQuantity());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setString(5, product.getProduct_Image());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(ProductModel product) {
        String sql = "UPDATE products SET Name = ?, Quantity = ?, Description = ?, Price = ? WHERE Product_Id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getName());
            stmt.setInt(2, product.getQuantity());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getProductId());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE Product_Id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ProductModel> searchProducts(String query) {
        List<ProductModel> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE Name LIKE ? OR Description LIKE ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String likeQuery = "%" + query + "%";
            stmt.setString(1, likeQuery);
            stmt.setString(2, likeQuery);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setProductId(rs.getInt("Product_Id"));
                product.setName(rs.getString("Name"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setProduct_Image(rs.getString("Product_Image"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public ProductModel findProductByExactName(String name) {
        String sql = "SELECT * FROM products WHERE LOWER(Name) = LOWER(?) LIMIT 1";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                ProductModel product = new ProductModel();
                product.setProductId(rs.getInt("Product_Id"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setProduct_Image(rs.getString("Product_Image"));
                return product;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
