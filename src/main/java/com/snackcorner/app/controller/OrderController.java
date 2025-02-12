package com.snackcorner.app.controller;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.snackcorner.app.model.OrderM;
import com.snackcorner.app.model.Snack;
import com.snackcorner.app.model.User;
import com.snackcorner.app.service.OrderService;
import com.snackcorner.app.service.SnackService;
import com.snackcorner.app.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.orm.hibernate5.HibernateOptimisticLockingFailureException;


@Controller
public class OrderController {

    private final UserService userService;
    private final SnackService snackService;
    private final OrderService orderService;

    private final String razorpayKey = "rzp_live_gUGMzzVnhT5cDP";
    private final String razorpaySecret = "MArClNraQJo8ynAdPus0M2Ov";

    @Autowired
    public OrderController(UserService userService, SnackService snackService, OrderService orderService) {
        this.userService = userService;
        this.snackService = snackService;
        this.orderService = orderService;
    }

    @GetMapping("/order")
    public String orderPage(@RequestParam("snackId") long snackId, @RequestParam("userId") long userId, Model model) {
        Snack snack = snackService.getSnackById(snackId);
        User user = userService.getUserById(userId);

        if (snack == null || user == null) {
            model.addAttribute("error", "Snack or User not found!");
            return "error";
        }

        model.addAttribute("snack", snack);
        model.addAttribute("user", user);

        try {
            RazorpayClient client = new RazorpayClient(razorpayKey, razorpaySecret);

            JSONObject orderRequest = new JSONObject();
            BigDecimal price = snack.getPrice();
            BigDecimal amount = price.multiply(BigDecimal.valueOf(10)); // Convert to paise
            orderRequest.put("amount", amount);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "txn_" + snackId + "_" + userId);

            Order order = client.orders.create(orderRequest);

            model.addAttribute("orderId", order.get("id"));
            model.addAttribute("razorpayKey", razorpayKey);
            model.addAttribute("amount", amount);
        } catch (Exception e) {
            model.addAttribute("error", "Error creating Razorpay order: " + e.getMessage());
            return "error";
        }

        return "order";
    }

    @PostMapping("/verifyPayment")
    public String verifyPayment(
            @RequestParam("razorpayPaymentId") String paymentId,
            @RequestParam("razorpayOrderId") String orderId,
            @RequestParam("razorpaySignature") String signature,
            @RequestParam("snackId") long snackId,
            @RequestParam("userId") long userId,
            Model model) {
        try {
            boolean isValidPayment = verifySignature(paymentId, orderId, signature);

            if (isValidPayment) {
                Snack snack = snackService.getSnackById(snackId);
                User user = userService.getUserById(userId);

                if (snack == null || user == null) {
                    model.addAttribute("error", "Snack or User not found!");
                    return "error";
                }

                OrderM order = new OrderM();
                order.setSnack(snack);
                order.setUser(user);
                order.setPaymentId(paymentId);
                order.setAmount(snack.getPrice());
                order.setStatus("Paid");
                order.setOrderDate(LocalDateTime.now());
                orderService.saveOrder(order);

                String invoiceDetails = "Invoice for Snack: " + snack.getName() + "\nAmount Paid: ₹" + snack.getPrice() + "\nOrder Id: " + order.getOrderId();
                model.addAttribute("invoiceDetails", invoiceDetails);
                model.addAttribute("orderId", order.getOrderId());
                model.addAttribute("paymentStatus", "Payment Successful!");
                model.addAttribute("orderConfirmation", "Your order has been placed successfully!");
                model.addAttribute("snack", snack);
                model.addAttribute("amount", snack.getPrice());

                model.addAttribute("order", order);

                return "order";
            } else {
                model.addAttribute("paymentStatus", "Payment Verification Failed!");
                return "order";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Error verifying payment: " + e.getMessage());
            return "error";
        }
    }

    private boolean verifySignature(String paymentId, String orderId, String signature) {
        try {
            String payload = orderId + "|" + paymentId;
            javax.crypto.Mac sha256_HMAC = javax.crypto.Mac.getInstance("HmacSHA256");
            javax.crypto.spec.SecretKeySpec secretKey = new javax.crypto.spec.SecretKeySpec(razorpaySecret.getBytes(), "HmacSHA256");
            sha256_HMAC.init(secretKey);

            byte[] hash = sha256_HMAC.doFinal(payload.getBytes());
            String generatedSignature = bytesToHex(hash);

            return generatedSignature.equals(signature);
        } catch (Exception e) {
            return false;
        }
    }

    private String bytesToHex(byte[] hash) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    @GetMapping("/myorder")
    public String showOrders(@RequestParam("userId") long userId, Model model) {
        User user = userService.getUserById(userId);
        if (user == null) {
            model.addAttribute("error", "User not found!");
            return "error";
        }

        List<OrderM> orders = orderService.getOrdersByUserId(userId);
        model.addAttribute("orders", orders);
        model.addAttribute("customer", user);
        return "myorder";
    }

    @GetMapping("/myprofile")
    public String showProfile(@RequestParam("userId") long userId, Model model) {
        User user = userService.getUserById(userId);
        if (user == null) {
            model.addAttribute("error", "User not found!");
            return "error";
        }

        List<OrderM> orders = orderService.getOrdersByUserId(userId);
        model.addAttribute("orders", orders);
        model.addAttribute("customer", user);
        return "myprofile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute User user, Model model) {
        try {
            if (user.getUserid() == 0) {
                model.addAttribute("error", "Invalid user ID!");  // Add error message to model
                return "redirect:/myprofile?userId=" + user.getUserid();  // Redirect to the same profile page with error
            }
            userService.updateUser(user);  // Pass the user object with the correct ID
            model.addAttribute("message", "Profile updated successfully!");  // Add success message to model
        } catch (HibernateOptimisticLockingFailureException e) {
            model.addAttribute("error", "The profile was updated by someone else. Please try again.");  // Handle exception with error message
        }
        return "redirect:/myprofile?userId=" + user.getUserid();  // Redirect to profile page with updated data
    }

}
