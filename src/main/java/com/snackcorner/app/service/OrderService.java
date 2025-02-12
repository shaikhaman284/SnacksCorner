package com.snackcorner.app.service;

import com.snackcorner.app.model.OrderM;

import java.util.List;

public interface OrderService {
    void saveOrder(OrderM order);
    OrderM getOrderById(Long id);
    List<OrderM> getAllOrders();
    void deleteOrder(OrderM order);
    OrderM getLatestOrderByUserId(Long userId);
    List<OrderM> getOrdersByUserId(Long userId);
    
}

