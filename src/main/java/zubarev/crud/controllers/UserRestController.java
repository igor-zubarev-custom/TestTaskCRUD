package zubarev.crud.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import zubarev.crud.model.User;
import zubarev.crud.dao.UserDao;

import java.util.List;

/**
 * Created by Admin on 28.04.2016.
 */
@RestController
public class UserRestController  {
    @Autowired
    UserDao userDao;

    @RequestMapping(value = "/user/", method = RequestMethod.GET)
    public ResponseEntity<List<User>> allUsers(){
        List<User> users = userDao.getAllUsers();
        if (users.isEmpty()){
            return new ResponseEntity<List<User>>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<List<User>>(users, HttpStatus.OK);
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    public ResponseEntity<User> userById(@PathVariable("id") int id){
        User user = userDao.findById(id);
        if (user == null){
            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<User>(user, HttpStatus.OK);
    }

    /*@RequestMapping(value = "/user/name/{name}", method = RequestMethod.GET)
    public ResponseEntity<List<User>> usersByName(@PathVariable("name") String name){
        List<User> users = userDao.findByName(name);
        if (users.isEmpty()){
            return new ResponseEntity<List<User>>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<List<User>>(users, HttpStatus.OK);
    }*/

}
