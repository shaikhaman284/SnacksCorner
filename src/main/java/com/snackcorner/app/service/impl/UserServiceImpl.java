package com.snackcorner.app.service.impl;

import com.snackcorner.app.dao.UserDAO;
import com.snackcorner.app.model.User;
import com.snackcorner.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    @Transactional
    public void registerUser(User user) {
        if (userDAO.getUserByLoginId(user.getLoginId()) != null) {
            throw new RuntimeException("Login ID already exists");
        }
        userDAO.saveUser(user);
    }

    @Override
    @Transactional
    public User loginUser(String loginId) {
        return userDAO.getUserByLoginId(loginId);
    }

    @Override
    @Transactional
    public List<User> listAllUsers() {
        return userDAO.getAllUsers();
    }

    @Override
    public User getUserById(long userid) {
        return userDAO.findById(userid);
    }
    
    @Override
    @Transactional
    public void updateUser(User user){
        userDAO.updateUser(user);
    }
}
