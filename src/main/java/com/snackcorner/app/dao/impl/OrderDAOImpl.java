package com.snackcorner.app.dao.impl;

import com.snackcorner.app.dao.OrderDAO;
import com.snackcorner.app.model.OrderM;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Repository
public class OrderDAOImpl implements OrderDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(OrderM order) {
        entityManager.merge(order);
    }

    @Override
    public OrderM findById(Long id) {
        return entityManager.find(OrderM.class, id);
    }

    @Override
    public List<OrderM> findAll() {
        return entityManager.createQuery("FROM OrderM", OrderM.class).getResultList();
    }

    @Override
    public void delete(OrderM order) {
        entityManager.remove(order);
    }

    @Override
    public OrderM findLatestByUserId(Long userId) {
        String hql = "SELECT o FROM OrderM o WHERE o.user.id = :userId ORDER BY o.orderDate DESC";
        TypedQuery<OrderM> query = entityManager.createQuery(hql, OrderM.class);
        query.setParameter("userId", userId);
        query.setMaxResults(1);
        return query.getSingleResult();
    }

    @Override
    public List<OrderM> findOrdersByUserId(Long userId) {
        String hql = "SELECT o FROM OrderM o WHERE o.user.id = :userId ORDER BY o.orderDate DESC";
        TypedQuery<OrderM> query = entityManager.createQuery(hql, OrderM.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
}
