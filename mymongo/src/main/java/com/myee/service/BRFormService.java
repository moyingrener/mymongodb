package com.myee.service;

import com.myee.pojo.BRForm;
import com.myee.pojo.BRFormCustom;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.List;

public interface BRFormService {
    /**
     *
     * @param form 借书还书操作
     * @param mongoTemplate
     * @param index(借书/还书 |1/2)  未还/已还(0/1)
     * @return
     */
    boolean updateBRForm(BRForm form, MongoTemplate mongoTemplate, Integer index);

    /**
     *
     * @param mongoTemplate 管理员查询借书/还书记录
     */
    List<BRFormCustom> selectBorrowAndReturnRBookRecordRole(MongoTemplate mongoTemplate, Integer back,Integer page);

    /**
     *
     * @param mongoTemplate 用户查询借书/还书记录
     * @param back
     * @return
     */
    List<BRFormCustom> selectBorrowAndReturnRBookRecordUser(MongoTemplate mongoTemplate,String email, Integer back,Integer page);

    /**
     *
     * @param mongoTemplate 查询记录数
     * @param back
     * @return
     */
    Integer selectBorrowAndReturnRBookRecordCountRole(MongoTemplate mongoTemplate, Integer back);

    /**
     *
     * @param mongoTemplate  查询记录数
     * @param email
     * @param back
     * @return
     */
    Integer selectBorrowAndReturnRBookRecordCountUser(MongoTemplate mongoTemplate, String email, Integer back);
}
