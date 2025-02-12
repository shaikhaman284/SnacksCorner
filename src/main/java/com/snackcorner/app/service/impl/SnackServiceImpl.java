package com.snackcorner.app.service.impl;

import com.snackcorner.app.dao.SnackDAO;
import com.snackcorner.app.model.Snack;
import com.snackcorner.app.service.SnackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SnackServiceImpl implements SnackService {

    @Autowired
    private SnackDAO snackDAO;

    @Override
    public void addSnack(Snack snack) {
        snackDAO.save(snack);
    }

    @Override
    public Snack getSnackById(long id) {
        return snackDAO.findById(id);
    }

    @Override
    public List<Snack> getAllSnacks() {
        return snackDAO.findAll();
    }

    @Override
    public void deleteSnack(Long id) {
        Snack snack = snackDAO.findById(id);
        if (snack != null) {
            snackDAO.delete(snack);
        }
    }

    @Override
    public void updateSnack(Snack updatedSnack) {
        Snack existingSnack = snackDAO.findById(updatedSnack.getSnackid());
        if (existingSnack != null) {
            existingSnack.setName(updatedSnack.getName());
            existingSnack.setPrice(updatedSnack.getPrice());
            existingSnack.setCategory(updatedSnack.getCategory());
            existingSnack.setDescription(updatedSnack.getDescription());
            snackDAO.save(existingSnack);  // Save updated snack details
        }
    }
}
