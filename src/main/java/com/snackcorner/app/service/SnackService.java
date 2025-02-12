package com.snackcorner.app.service;

import com.snackcorner.app.model.Snack;
import java.util.List;

public interface SnackService {
    void addSnack(Snack snack);
    Snack getSnackById(long id);
    List<Snack> getAllSnacks();
    void deleteSnack(Long id);
    void updateSnack(Snack snack);  // New method for updating a snack
}
