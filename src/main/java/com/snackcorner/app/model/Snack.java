package com.snackcorner.app.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "snacks")
public class Snack {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long snackid;

    private String name;
    private BigDecimal price;
    private String description;
    private String category;
    private String imagePath; // Stores image file name or URL

    // No-args constructor required by JPA
    public Snack() {}

    // Parameterized constructor (corrected)
    public Snack(String name, String category, String description, BigDecimal price, String imagePath) {
        this.name = name;
        this.category = category;
        this.description = description;
        this.price = price;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public Long getSnackid() {
        return snackid;
    }

    public void setSnackid(Long snackid) {
        this.snackid = snackid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
