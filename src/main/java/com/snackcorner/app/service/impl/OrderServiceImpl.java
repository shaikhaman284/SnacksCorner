package com.snackcorner.app.service.impl;

import com.snackcorner.app.dao.OrderDAO;
import com.snackcorner.app.model.OrderM;
import com.snackcorner.app.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Transactional
    @Override
    public void saveOrder(OrderM order) {
        orderDAO.save(order);
    }

    @Override
    public OrderM getOrderById(Long id) {
        return orderDAO.findById(id);
    }

    @Override
    public List<OrderM> getAllOrders() {
        return orderDAO.findAll();
    }

    @Override
    public void deleteOrder(OrderM order) {
        orderDAO.delete(order);
    }

    // Method to get the latest order by user ID
    @Override
    public OrderM getLatestOrderByUserId(Long userId) {
        return orderDAO.findLatestByUserId(userId);
    }

    @Override
    public List<OrderM> getOrdersByUserId(Long userId) {
        return orderDAO.findOrdersByUserId(userId);
    }

}
