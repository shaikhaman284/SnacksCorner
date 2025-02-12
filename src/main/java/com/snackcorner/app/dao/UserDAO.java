package com.snackcorner.app.dao;

import com.snackcorner.app.model.User;
import java.util.List;

public interface UserDAO {
    void saveUser(User user);
    User getUserByLoginId(String loginId);
    List<User> getAllUsers();
    void updateUser(User user);

    public User findById(long userId);
}
