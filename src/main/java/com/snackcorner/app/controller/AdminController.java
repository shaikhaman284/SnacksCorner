package com.snackcorner.app.controller;

import com.snackcorner.app.dto.SnackForm;
import com.snackcorner.app.model.OrderM;
import com.snackcorner.app.model.Snack;
import com.snackcorner.app.model.User;
import com.snackcorner.app.service.OrderService;
import com.snackcorner.app.service.SnackService;
import com.snackcorner.app.service.UserService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private SnackService snackService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private ServletContext servletContext;  // To get the real path of the project

    @GetMapping("/admin")
    public String getAdminDashboard(Model model) {
        model.addAttribute("snacks", snackService.getAllSnacks());

        model.addAttribute("customers", userService.listAllUsers());
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin";
    }

    @PostMapping("/customerOrders")
    public ResponseEntity<String> viewCustomerOrders(@RequestParam Long userId) {
        if (userId == null || userId <= 0) {
            return ResponseEntity.ok("<h4>No orders found</h4>");
        }

        List<OrderM> orders = orderService.getOrdersByUserId(userId);
        User user = userService.getUserById(userId);

        StringBuilder htmlResponse = new StringBuilder();
        htmlResponse.append("<h4>Customer Name: ").append(user.getName()).append("</h4>");
        htmlResponse.append("<table border='1'><tr><th>Order ID</th><th>Snack Name</th><th>Price</th><th>Order Date</th></tr>");

        if (orders.isEmpty()) {
            htmlResponse.append("<tr><td colspan='4'>No orders found</td></tr>");
        } else {
            for (OrderM order : orders) {
                htmlResponse.append("<tr>")
                        .append("<td>").append(order.getOrderId()).append("</td>")
                        .append("<td>").append(order.getSnack().getName()).append("</td>")
                        .append("<td>").append(order.getSnack().getPrice()).append("</td>")
                        .append("<td>").append(order.getOrderDate()).append("</td>")
                        .append("</tr>");
            }
        }
        htmlResponse.append("</table>");

        return ResponseEntity.ok(htmlResponse.toString());
    }

    @PostMapping("/admin/addSnack")
    public ResponseEntity<String> addSnack(
            HttpServletRequest request,
            @RequestParam("name") String name,
            @RequestParam("price") String price,
            @RequestParam("description") String description,
            @RequestParam("category") String category,
            @RequestPart("imageFile") MultipartFile imageFile) {

        try {
            double snackPriced = Double.parseDouble(price);
            BigDecimal snackPrice = BigDecimal.valueOf(snackPriced);

            if (imageFile == null || imageFile.isEmpty()) {
                return ResponseEntity.badRequest().body("Image file is missing!");
            }

            // ✅ Get Real Path (Works on both Local & Cloud Deployments)
            String uploadDir = request.getServletContext().getRealPath("/static/uploaded-img/");
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // ✅ Save the File
            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename(); // Prevent duplicates
            Path filePath = Paths.get(uploadDir, fileName);
            Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // ✅ Set Relative Path for Frontend
            String imageUrl = "/static/uploaded-img/" + fileName;

            // ✅ Save snack details
            Snack snack = new Snack();
            snack.setName(name);
            snack.setPrice(snackPrice);
            snack.setDescription(description);
            snack.setCategory(category);
            snack.setImagePath(imageUrl); // Relative Path

            snackService.addSnack(snack);

            return ResponseEntity.ok("Snack added successfully!");

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to add snack: " + e.getMessage());
        }
    }

// Update Snack: Process Edit Form Submission
    @PostMapping("/admin/updateSnack")
    public String updateSnack(@Valid
            @ModelAttribute("snack") Snack snack, BindingResult result,
            Model model, RedirectAttributes redirectAttributes
    ) {
        if (result.hasErrors()) {
            model.addAttribute("error", "Validation errors occurred. Snack not updated.");
            return "admin";  // Return to the admin page if there are validation errors
        }
        try {
            snackService.updateSnack(snack);
            redirectAttributes.addFlashAttribute("message", "Snack updated successfully!");
            return "redirect:/admin";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to update snack.");
            return "admin";  // Return to the admin page if update fails
        }
    }

    // Delete Snack: Process Delete Request
    @GetMapping("/deleteSnack")
    public String deleteSnack(@RequestParam("id") Long snackId, RedirectAttributes redirectAttributes
    ) {
        try {
            snackService.deleteSnack(snackId);
            redirectAttributes.addFlashAttribute("message", "Snack deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete snack.");
        }
        return "redirect:/admin";
    }

    @PostMapping("/adminLogout")
    public String adminLogout(HttpSession session
    ) {
        session.removeAttribute("adminUser");
        session.invalidate();
        return "redirect:/login";
    }
}
