package com.myee.service;

import com.alibaba.fastjson.JSONObject;
import com.mongodb.client.result.UpdateResult;
import com.myee.pojo.Book;
import com.myee.pojo.BookCustom;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;


@Service
public class BookServiceImpl implements BookService {
    private Logger logger = Logger.getLogger(BookService.class);

    /**
     * @param book          上传书籍
     * @param mongoTemplate
     */
    @Override
    public Boolean insertBook(Book book, MongoTemplate mongoTemplate) {
        if (book.getBook_name() != null && book.getCounts() != null && book.getPlace() != null) {
            BookCustom bookCustom = null;
            Query query = new Query();//查询是否存在同样的书籍
            query.addCriteria(Criteria.where("book_name").is(book.getBook_name()).and("place").is(book.getPlace()));
            try {
                bookCustom = mongoTemplate.findOne(query, BookCustom.class, "book");
            } catch (Exception e) {
                logger.error(getClass(), e);
                return false;
            }
            try {
                if (bookCustom == null) {//库中没有该书
                    mongoTemplate.insert(book, "book");
                } else {//库中有该书
                    Update update = new Update();
                    update.inc("counts", book.getCounts());
                    mongoTemplate.updateFirst(query, update, "book");
                }
            } catch (Exception e) {
                logger.error(getClass(), e);
                return false;
            }
            return true;
        } else {
            return false;
        }
    }

    /**
     * @param book          搜索书籍
     * @param mongoTemplate
     * @return
     */
    @Override
    public Map<String, Object> selectBook(BookCustom book, MongoTemplate mongoTemplate, Integer currentPage) {
        if (book.getBook_name() != null) {//根据book_name查询
            Map map=new HashMap();
            Integer max_count=0;
            List<BookCustom> book_list = null;
            int count = 0;
            Query query = new Query();
            query.addCriteria(Criteria.where("book_name")
                    .is(book.getBook_name())).limit(5).skip((currentPage - 1) * 5)
                    .with(Sort.by(Sort.Order.desc("_id")));
            try {//精准查询
                book_list = mongoTemplate.find(query, BookCustom.class, "book");
            } catch (Exception e) {
                logger.error(getClass(), e);
                return null;
            }
            if (book_list.size() != 0) {
                max_count=Integer.valueOf(String.valueOf(mongoTemplate
                        .count(new Query().addCriteria(Criteria.where("book_name")
                                .is(book.getBook_name())), "book")));
                map.put("book_list",book_list);
                map.put("max_count",max_count);
                return map;
            }
            String book_name=escapeExprSpecialWord(book.getBook_name());
            //模糊查询
            String[] key = new String[4];
            key[0] = "^" + book_name + "$";       // 完全匹配
            key[1] = "^.*" + book_name + ".*$";   // 模糊匹配
            key[2] = "^.*" + book_name + "$";     // 左匹配
            key[3] = "^" + book_name + ".*$";     // 右匹配

            // 进行四种方式的匹配
            for (int i = 0; i < 4; i++) {
                Pattern pattern = Pattern.compile(key[i]);
                query = Query.query(Criteria.where("book_name")
                        .regex(pattern)).skip((currentPage - 1) * 5).limit(5);
                try {
                    book_list = mongoTemplate.find(query, BookCustom.class, "book");
                }catch (Exception e){
                    logger.error(getClass(), e);
                    return null;
                }
                count = book_list.size();

                if (count != 0) {  // 四种匹配方式满足其一则返回
                   max_count= Integer.valueOf(String.valueOf(mongoTemplate.count(new Query()
                           .addCriteria(Criteria.where("book_name")
                           .regex(pattern)),"book")));
                    map.put("book_list",book_list);
                    map.put("max_count",max_count);
                    return map;
                }
            }
        }else if(book.get_id()!=null){//根据id查询
            Map map=new HashMap();
           Query query=new Query();
           query.addCriteria(Criteria.where("_id").is(book.get_id()));
            BookCustom book_2=null;
            try {
                 book_2=mongoTemplate.findOne(query,BookCustom.class,"book");
            }catch (Exception e){
                logger.error(getClass(), e);
                return null;
            }
            if (book_2!=null){
                map.put("book",book_2);
                return map;
            }
        }else {//默认查询所有书籍
            Map map=new HashMap();
            List<BookCustom> book_list = mongoTemplate.find(new Query()
                    .addCriteria(Criteria.where("counts").ne(0))
                    .skip((currentPage-1)*5).limit(5).with(Sort.by(Sort.Order.desc("_id"))), BookCustom.class, "book");
            Integer max_count=Integer.valueOf(String.valueOf(mongoTemplate.count(new Query()
                    .addCriteria(Criteria.where("counts").ne(0)),"book")));
            map.put("book_list",book_list);
            map.put("max_count",max_count);
            return map;
        }
        return null;
    }

    @Override
    public Boolean updateBook(BookCustom book, MongoTemplate mongoTemplate) {
       UpdateResult result= mongoTemplate.updateFirst(new Query().addCriteria(Criteria.where("_id")
                .is(book.get_id())),new Update().set("book_name",book.getBook_name())
                .set("place",book.getPlace()).set("counts",book.getCounts()),"book");
       if(result.getModifiedCount()!=0){
           return true;
       }else {
           return false;
       }
    }

    /**
     *
     * @param book 删除书籍(数量设置为0)
     * @param mongoTemplate
     * @return
     */
    @Override
    public Boolean deleteBookById(BookCustom book, MongoTemplate mongoTemplate) {
        Query query=new Query();
       query.addCriteria(Criteria.where("_id").is(book.get_id()));
       try {
            book=mongoTemplate.findOne(query,BookCustom.class,"book");
            if(book.getCounts()==0){
                return true;
            }else {
                UpdateResult result=mongoTemplate.updateFirst(query
                        ,new Update().set("counts",0),"book");
                if(result.getModifiedCount()!=0){
                    return true;
                }else {
                    return false;
                }
            }
       }catch (Exception e){
           logger.error(getClass(),e);
           return false;
       }
    }


    String escapeExprSpecialWord(String keyword) {

        if (StringUtils.isNotBlank(keyword)) {

            String[] fbsArr = {"\\", "$", "(", ")", "*", "+", ".", "[", "]", "?", "^", "{", "}", "|"};

            for (String key : fbsArr) {

                if (keyword.contains(key)) {
                    keyword = keyword.replace(key, "\\" + key);
                }
            }
        }

        return keyword;
    }
}
