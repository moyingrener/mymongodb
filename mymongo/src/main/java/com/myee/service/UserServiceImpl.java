package com.myee.service;

import com.myee.pojo.User;
import com.myee.pojo.UserCustom;
import org.apache.log4j.Logger;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    private Logger logger=Logger.getLogger(UserServiceImpl.class);
    /**
     *
     * @param user 登录
     * @param mongoTemplate
     * @return
     */
    @Override
    public UserCustom selectByEmailAndPassword(User user, MongoTemplate mongoTemplate) {
        UserCustom userCustom=null;
        if (user.getEmail() != null && user.getEmail() != "") {
            if (user.getPassword() != null && user.getPassword() != "") {
                Query query = new Query();
                query.addCriteria(Criteria.where("email").is(user.getEmail()).and("password").is(user.getPassword()));
                try {
                    userCustom= mongoTemplate.findOne(query, UserCustom.class, "user");
                }catch (Exception e){
                    logger.error(getClass(),e);
                }
            }
        }
        return userCustom;
    }

    /**
     *
     * @param user 注册
     * @param mongoTemplate
     * @return
     */
    @Override
    public Boolean insertByUser(User user, MongoTemplate mongoTemplate) {
        user.setRole(1);
        user.setTime(String.valueOf(System.currentTimeMillis()));
        try {
            mongoTemplate.insert(user,"user");
        }catch (Exception e){
                logger.error(getClass(),e);
                return false;
        }
        return true;
    }

    /**
     *
     * @param user 根据单一条件查询用户信息
     * @param mongoTemplate
     * @return
     */
    @Override
    public User selectUserByOneParam(User user, MongoTemplate mongoTemplate) {
        Query query=new Query();
        if(user.getUser_name()!=null&&user.getUser_name()!=""){
            query.addCriteria(Criteria.where("user_name").is(user.getUser_name()));
        }else if(user.getEmail()!=null&&user.getEmail()!=""){
            query.addCriteria(Criteria.where("email").is(user.getEmail()));
        }else if(user.getRole()!=null){
            query.addCriteria(Criteria.where("role").is(user.getRole()));
        }else  if(user.getPhone()!=null&&user.getPhone()!=""){
            query.addCriteria(Criteria.where("phone").is(user.getPhone()));
        }else if(user.getTime()!=null&&user.getTime()!=""){
            query.addCriteria(Criteria.where("time").is(user.getTime()));
        }

        try {
            user=mongoTemplate.findOne(query,User.class,"user");
        }catch (Exception e){
            logger.error(getClass(),e);
            return null;
        }
        return user;
    }
}
