package zubarev.crud.dao;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import zubarev.crud.model.User;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by Admin on 28.04.2016.
 */
@Service("userDao")
@Transactional
@Repository
public class UserDaoImpl extends BaseDao<Integer, User> implements UserDao {

    @Override
    public List<User> getAllUsers() {
        Criteria criteria = createUserCriteria();
        return (List<User>) criteria.list();
    }

    @Override
    public List<User> generateAllUsers() {
        Random rnd = new Random();
        for (int i = 0; i < 30; i++) {
            User user = new User();
            user.setName("Name" + String.valueOf((char)(rnd.nextInt(26)+65)));
            user.setAge(rnd.nextInt(50) + 18);
            user.setAdmin(rnd.nextBoolean());
            user.setCreatedDate(new Date(new Date().getTime()-rnd.nextInt(100_000_000_0)));
            saveUser(user);
        }
        return getAllUsers();
    }

    @Override
    public User findById(int id) {
        return getByKey(id);
    }

    @Override
    public void saveUser(User user) {
        persist(user);
    }

    @Override
    public void updateUser(User user) {
        User result = getByKey(user.getId());
        if (result != null) {
            result.setId(user.getId());
            result.setName(user.getName());
            result.setAge(user.getAge());
            result.setAdmin(user.isAdmin());
            //При изменении дату менять не стал
            //result.setCreatedDate(user.getCreatedDate());
        }
    }

    @Override
    public void deleteUser(int id) {
        Criteria criteria = createUserCriteria();
        criteria.add(Restrictions.eq("id", id));
        User user = (User) criteria.uniqueResult();
        delete(user);
    }
}
