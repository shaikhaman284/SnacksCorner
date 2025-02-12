package com.snackcorner.app.dao;

import com.snackcorner.app.model.OrderM;
import java.util.List;

public interface OrderDAO {
    void save(OrderM order);
    OrderM findById(Long id);
    List<OrderM> findAll();
    void delete(OrderM order);
    OrderM findLatestByUserId(Long userId);
    List<OrderM> findOrdersByUserId(Long userId);  // Fetch all orders by user ID
}
