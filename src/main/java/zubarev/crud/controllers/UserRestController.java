package zubarev.crud.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
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

    @RequestMapping(value = "/user/gen/", method = RequestMethod.GET)
    public ResponseEntity<List<User>> generateUsers(){
        List<User> users = userDao.generateAllUsers();
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

    @RequestMapping(value = "/user/", method = RequestMethod.POST)
    public ResponseEntity<Void> createNewUser(@RequestBody User user, UriComponentsBuilder uriComponentsBuilder){
        System.out.println("Create user " + user);
        userDao.saveUser(user);
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setLocation(uriComponentsBuilder.path("/user/{id}").buildAndExpand(user.getId()).toUri());
        return new ResponseEntity<Void>(httpHeaders, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.PUT)
    public ResponseEntity<User> updateUser(@PathVariable("id") int id, @RequestBody User user){
        System.out.println("Update user " + user);
        User updateUser = userDao.findById(id);
        System.out.println(">>>>find " + updateUser);
        if (updateUser == null){
            System.out.println("User " + user + " not found in DB");
            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
        }
       /* updateUser.setName(user.getName());
        updateUser.setAge(user.getAge());*/
        userDao.updateUser(user);
        return new ResponseEntity<User>(HttpStatus.OK);
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<User> deleteUser(@PathVariable("id") int id){
        System.out.println("Delete user " + id);
        User deleteUser = userDao.findById(id);
        if (deleteUser == null){
            System.out.println("User " + id + " not found in DB");
            return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
        }
        userDao.deleteUser(id);
        return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
    }

}
