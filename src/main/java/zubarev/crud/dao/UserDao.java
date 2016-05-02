package zubarev.crud.dao;

import zubarev.crud.model.User;

import java.util.List;

/**
 * Created by IGor on 29.04.2016.
 */
public interface UserDao {

    List<User> getAllUsers();
    List<User> generateAllUsers();
    User findById(int id);
    void saveUser(User user);
    void updateUser(User user);
    void deleteUser(int id);
}
