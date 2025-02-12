package com.snackcorner.app.dao.impl;

import com.snackcorner.app.dao.SnackDAO;
import com.snackcorner.app.model.Snack;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class SnackDAOImpl implements SnackDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Snack snack) {
        sessionFactory.getCurrentSession().merge(snack);
    }

    @Override
    public Snack findById(Long id) {
        return sessionFactory.getCurrentSession().get(Snack.class, id);
    }

    @Override
    public List<Snack> findAll() {
        return sessionFactory.getCurrentSession().createQuery("from Snack", Snack.class).list();
    }

    @Override
    public void delete(Snack snack) {
        sessionFactory.getCurrentSession().delete(snack);
    }
}
