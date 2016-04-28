package zubarev.crud.dao;

import zubarev.crud.model.User;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface UserDao {

    List<User> getAllUsers();
    User findById(int id);
   /* List<User> findByName(String name);*/
}
