package com.myee.service;

import com.myee.pojo.User;
import com.myee.pojo.UserCustom;
import org.springframework.data.mongodb.core.MongoTemplate;

public interface UserService {

    /**
     *
     * @param user 登录
     * @param mongoTemplate
     * @return
     */
    public UserCustom selectByEmailAndPassword(User user, MongoTemplate mongoTemplate);

    /**
     *
     * @param user 注册
     * @param mongoTemplate
     * @return
     */
    public Boolean insertByUser(User user, MongoTemplate mongoTemplate);

    /**
     *
     * @param user 根据单一条件查询用户信息
     * @param mongoTemplate
     * @return
     */
    public User selectUserByOneParam(User user, MongoTemplate mongoTemplate);
}
