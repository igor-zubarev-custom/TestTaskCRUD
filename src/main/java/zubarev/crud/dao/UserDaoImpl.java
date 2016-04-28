package zubarev.crud.dao;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import zubarev.crud.model.User;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Admin on 28.04.2016.
 */
@Service("userDao")
@Transactional
@Repository
public class UserDaoImpl extends BaseDao<Integer, User> implements UserDao {
    /*private static List<User> users;
    static {
        users = new ArrayList<User>();
        users.add(new User(1, "name1"));
        users.add(new User(2, "name2"));
        users.add(new User(3, "name3"));
    }*/

    @Override
    public List<User> getAllUsers() {
        Criteria criteria = createUserCriteria();
        return (List<User>) criteria.list();
    }

    @Override
    public User findById(int id) {
        return getByKey(id);
    }

    /*@Override
    public List<User> findByName(String name) {
        List<User> result = new ArrayList<>();
        for (User user :users) {
            if (user.getName().equalsIgnoreCase(name)){
                result.add(user);
            }
        }
        return result;
    }*/
}
