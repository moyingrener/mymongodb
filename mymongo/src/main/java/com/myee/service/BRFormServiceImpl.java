package com.myee.service;

import com.mongodb.client.result.UpdateResult;
import com.myee.pojo.BRForm;
import com.myee.pojo.BRFormCustom;
import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BRFormServiceImpl implements BRFormService {
    private Logger logger = Logger.getLogger(BRFormService.class);

    /**
     *
     * @param form 借书还书操作
     * @param mongoTemplate
     * @param index(借书/还书 |1/2)  未还/已还(0/1)
     * @return
     */
    @Override
    public boolean updateBRForm(BRForm form, MongoTemplate mongoTemplate, Integer index) {
        if(index==1){//借书
        form.setBack(0);
            try {//图书数量减一,插入借书记录操作
                UpdateResult result= mongoTemplate.updateFirst(new Query()
                                .addCriteria(Criteria.where("_id")
                                        .is(new ObjectId(form.getBook_id()))),
                        new Update().inc("counts",-1), "book");
                if(result.getModifiedCount()!=0){
                    mongoTemplate.insert(form,"brform");
                }else {
                    return false;
                }
            }catch (Exception e){
                logger.error(getClass(),e);
                return false;
            }
            return true;

        }else {//还书
            form.setBack(1);
            try {//修改借书/还书状态
                UpdateResult result= mongoTemplate.updateFirst(new Query()
                        .addCriteria(Criteria.where("book_id")
                                .is(form.getBook_id())
                                .and("email").is(form.getEmail())
                                .and("back").is(0)),new Update().set("back",1),"brform");
                if(result.getModifiedCount()!=0){
                    //书籍数量加一
                    mongoTemplate.updateFirst(new Query()
                                    .addCriteria(Criteria.where("_id")
                                            .is(new ObjectId(form.getBook_id()))),
                            new Update().inc("counts",1), "book");
                }

            }catch (Exception e){
                logger.error(getClass(),e);
                return false;
            }
        }

        return true;
    }

    /**
     *
     * @param mongoTemplate 管理员查询借书/还书记录
     */
    @Override
    public List<BRFormCustom> selectBorrowAndReturnRBookRecordRole(MongoTemplate mongoTemplate, Integer back,Integer page) {
            try {
                return  mongoTemplate.find(new Query().addCriteria(Criteria.where("back")
                            .is(back)).with(Sort.by(Sort.Order.desc("_id"))).skip((page-1)*5).limit(5),
                    BRFormCustom.class,"brform");
            }catch (Exception e){
                logger.error(getClass(),e);
                return null;
            }
    }

    /**
     *
     * @param mongoTemplate 用户查询借书/还书记录
     * @param back
     * @return
     */
    @Override
    public List<BRFormCustom> selectBorrowAndReturnRBookRecordUser(MongoTemplate mongoTemplate,String email, Integer back,Integer page) {
        try {
            return mongoTemplate.find(new Query().addCriteria(Criteria.where("back")
                            .is(back).and("email").is(email)).with(Sort.by(Sort.Order.desc("_id"))).skip((page-1)*5).limit(5),
                    BRFormCustom.class,"brform");
        }catch (Exception e){
            logger.error(getClass(),e);
            return null;
        }
    }

    /**
     *
     * @param mongoTemplate 查询记录数
     * @param back
     * @return
     */
    @Override
    public Integer selectBorrowAndReturnRBookRecordCountRole(MongoTemplate mongoTemplate, Integer back) {
        return Integer.valueOf(String.valueOf(mongoTemplate.count(new Query().addCriteria(Criteria.where("back")
                .is(back)), "brform")));

    }

    /**
     *
     * @param mongoTemplate  查询记录数
     * @param email
     * @param back
     * @return
     */
    @Override
    public Integer selectBorrowAndReturnRBookRecordCountUser(MongoTemplate mongoTemplate, String email, Integer back) {
        return Integer.valueOf(String.valueOf(mongoTemplate.count(new Query().addCriteria(Criteria.where("back")
                .is(back).and("email").is(email)), "brform")));
    }


}
