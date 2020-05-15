package com.myee.service;

import com.alibaba.fastjson.JSONObject;
import com.myee.pojo.BRForm;
import com.myee.pojo.Book;
import com.myee.pojo.BookCustom;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.List;
import java.util.Map;

public interface BookService {
    /**
     *
     * @param book 上传书籍
     * @param mongoTemplate
     */
    Boolean insertBook(Book book, MongoTemplate mongoTemplate);

    /**
     *
     * @param book 搜索书籍
     * @param mongoTemplate
     * @return
     */
     Map selectBook(BookCustom book, MongoTemplate mongoTemplate, Integer currentPage);

    /**
     *
     * @param book 更新书籍
     * @param mongoTemplate
     * @return
     */
     Boolean updateBook(BookCustom book, MongoTemplate mongoTemplate);

    /**
     *
     * @param book 删除书籍(数量设置为0)
     * @param mongoTemplate
     * @return
     */
    Boolean deleteBookById(BookCustom book, MongoTemplate mongoTemplate);
}
