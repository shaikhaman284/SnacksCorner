package com.snackcorner.app.service;


import com.snackcorner.app.model.User;
import java.util.List;

public interface UserService {
    void registerUser(User user);
    User loginUser(String loginId);
    User getUserById(long id);
    List<User> listAllUsers();
    void updateUser(User user);
}

