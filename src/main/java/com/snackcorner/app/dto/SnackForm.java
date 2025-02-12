package com.snackcorner.app.dto;

import java.math.BigDecimal;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.Part;

public class SnackForm {

    private String name;
    private String category;
    private String description;
    private BigDecimal price;
    private Part imageFile;  // ✅ Use Part instead of MultipartFile

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Part getImageFile() {
        return imageFile;
    }

    public void setImageFile(Part imageFile) {
        this.imageFile = imageFile;
    }
}
