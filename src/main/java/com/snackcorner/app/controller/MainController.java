package com.snackcorner.app.controller;

import com.snackcorner.app.model.Snack;
import com.snackcorner.app.model.User;
import com.snackcorner.app.service.SnackService;
import com.snackcorner.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import javax.validation.Valid;

@Controller
public class MainController {

    private final UserService userService;
    private final SnackService snackService;

    // Static admin credentials
    private static final String ADMIN_ID = "admin@snackcorner.com";
    private static final String ADMIN_PASSWORD = "admin123";

    @Autowired
    public MainController(UserService userService, SnackService snackService) {
        this.userService = userService;
        this.snackService= snackService;
    }

    // Display the home page
    @GetMapping("/home")
    public String home(Model model) {
        
        model.addAttribute("message", "Welcome to Snacks Corner!");
        return "home";
    }

    @GetMapping("/menu")
    public String getMenu(Model model) {
        List<Snack> snacks = snackService.getAllSnacks();
        model.addAttribute("snacks", snacks);
        return "menu";
    }
    // Display the registration form
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }
    
    @GetMapping("/contact")
    public String showContact(Model model) {
        model.addAttribute("user", new User());
        return "contact";
    }

    @PostMapping("/register")
    public String registerUser(
            @Valid @ModelAttribute("user") User user,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            return "register";
        }

        try {
            userService.registerUser(user);
            model.addAttribute("message", "Registration Successful! Please Login.");
            return "register";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error: " + e.getMessage());
            return "register";
        }
    }

    // Display login form with user or admin option
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    // Handle user login
    @PostMapping("/userLogin")
    public String loginUser(@ModelAttribute("user") User user, Model model, HttpSession session) {
        User loggedInUser = userService.loginUser(user.getLoginId());
        if (loggedInUser != null && loggedInUser.getPassword().equals(user.getPassword())) {
            session.setAttribute("loggedInUser", loggedInUser);
            model.addAttribute("name", loggedInUser.getName());
            return "redirect:/home"; // Redirect to home page after user login
        } else {
            model.addAttribute("error", "Invalid login credentials. Please try again.");
            return "login";
        }
    }

    // Handle admin login
    // Handle admin login
    @PostMapping("/adminLogin")
    public String loginAdmin(@ModelAttribute("user") User user, Model model, HttpSession session) {
        System.out.println("Admin login attempt with ID: " + user.getLoginId()); // Debug log
        System.out.println("Admin login attempt with Password: " + user.getPassword()); // Debug log

        if (ADMIN_ID.equals(user.getLoginId()) && ADMIN_PASSWORD.equals(user.getPassword())) {
            session.setAttribute("adminUser", "Admin");
            System.out.println("Admin login successful"); // Debug log
            return "redirect:/admin"; // Redirect to admin module page after successful admin login
        } else {
            model.addAttribute("error", "Invalid admin credentials. Please try again.");
            System.out.println("Admin login failed"); // Debug log
            return "login";
        }
    }



    // Handle logout
    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    
    
}
