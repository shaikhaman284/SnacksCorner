package com.snackcorner.app.dao;

import com.snackcorner.app.model.Snack;
import java.util.List;

public interface SnackDAO {
    void save(Snack snack);
    Snack findById(Long id);
    List<Snack> findAll();
    void delete(Snack snack);
}
