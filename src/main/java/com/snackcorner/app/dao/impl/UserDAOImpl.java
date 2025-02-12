package com.snackcorner.app.dao.impl;

import com.snackcorner.app.dao.UserDAO;
import com.snackcorner.app.model.User;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public void saveUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.merge(user);  // Copies state without directly attaching the instance
    }

    @Override
    @Transactional(readOnly = true)
    public User getUserByLoginId(String loginId) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM User WHERE loginId = :loginId", User.class)
                .setParameter("loginId", loginId)
                .uniqueResult();
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM User", User.class).list();
    }

    @Override
     @Transactional(readOnly = true)
    public User findById(long userId) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM User WHERE id = :userId", User.class)
                .setParameter("userId", userId)
                .uniqueResult();
    }
    @Override
    @Transactional
    public void updateUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.merge(user);  // Copies state without directly attaching the instance
    }
  
}
