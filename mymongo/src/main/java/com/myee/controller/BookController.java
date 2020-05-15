package com.myee.controller;

import com.alibaba.fastjson.JSONObject;
import com.myee.pojo.BRForm;
import com.myee.pojo.Book;
import com.myee.pojo.BookCustom;
import com.myee.service.BRFormService;
import com.myee.service.BookService;
import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("book")
public class BookController {
    private Logger logger = Logger.getLogger(BookController.class);
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private BookService bookService;

    //上传书籍
    @PostMapping("/uploadBook")
    public String uploadBook(@ModelAttribute("book") Book book, HttpServletRequest req) {
        Boolean b = bookService.insertBook(book, mongoTemplate);
        if (b) {
            req.setAttribute("success", "录入成功!");
        } else {
            req.setAttribute("fail", "录入失败，请重试!");
        }
        req.setAttribute("book", book);
        return "bookManger";
    }

    //搜索书籍
    @GetMapping("/lookUpBookS")
    public String lookUpBookS(@ModelAttribute("book") BookCustom book,
                             HttpServletRequest req,String context
                             ,Integer currentPage,Integer max_page){
        Map map=null;
        if(currentPage<0){
            currentPage=1;
        }else if(max_page!=null){
            if (currentPage>max_page){
                currentPage=max_page;
            }
        }
        if(context!=null&&context!=""){//根据搜索内容查书
            try{
                context=new String(context.getBytes("ISO-8859-1"),"utf-8");
            }catch (UnsupportedEncodingException e){
                    logger.error(getClass(),e);
                    return "lookUpBook";
            }
            book.setBook_name(context);
             map=bookService.selectBook(book,mongoTemplate,currentPage);
        }else {//页面默认页
                    map=bookService.selectBook(book,mongoTemplate,currentPage);
        }
        if(map!=null){
                req.setAttribute("book_list",map.get("book_list"));
                req.setAttribute("max_count",map.get("max_count"));
                req.setAttribute("currentPage",currentPage);
                if(context!=null){
                    req.setAttribute("context",context);
                }
                if((Integer)map.get("max_count")<6){
                    Integer[] a=new Integer[1];
                    req.setAttribute("book_array",a);
                }else {
                    Integer[] a=new Integer[((Integer)map.get("max_count")/5)+1];
                    req.setAttribute("book_array",a);
                }
                if((Integer)map.get("max_count")<6){
                    req.setAttribute("max_page",1);
                }else {
                    req.setAttribute("max_page",((Integer)map.get("max_count")/5)+1);
                }
                req.setAttribute("book_status",1);//阻止首页默认访问内容
            return "lookUpBook";
        }
        req.setAttribute("book_status",2);//显示没有查到书籍提示
        return "lookUpBook";
    }

    //借书还书时异步搜索书籍名
    @GetMapping("/lookUpBookById")
    @ResponseBody
    public JSONObject lookUpBookById(@ModelAttribute("book") BookCustom book,
                             HttpServletRequest req,String object_id){
        Map map=null;
        JSONObject json = new JSONObject();
        if(object_id!=null&&object_id!=""){//根据id查书
            book.set_id(new ObjectId(object_id));
            map=bookService.selectBook(book,mongoTemplate,1);
        }
        if(map!=null){
            if(map.size()>0){
                json.put("book_name",((BookCustom)map.get("book")).getBook_name());
                return json;
            }
        }
        json.put("book_name",null);
        return json;
    }


    //编辑书籍操作
    @PostMapping("/modifyBook")
    public String modifyBook(@ModelAttribute("book") BookCustom book,
                                 HttpServletRequest req,String book_id){
        book.set_id(new ObjectId(book_id));
            boolean b=bookService.updateBook(book,mongoTemplate);
            if(b){
                req.setAttribute("success","修改成功!");
            }else {
                req.setAttribute("fail","修改失败!");
            }
            req.setAttribute("book",book);
        return "modifyBook";
    }

    //删除书籍
    @PostMapping("/deleteBook")
    @ResponseBody
    public JSONObject deleteBook(@ModelAttribute("book") BookCustom book,
                                     HttpServletRequest req,String object_id){
        JSONObject json = new JSONObject();
        book.set_id(new ObjectId(object_id));
        boolean b=bookService.deleteBookById(book,mongoTemplate);
        if(b){
            json.put("delete_result",true);
        }else {
            json.put("delete_result",false);
        }
        json.put("delete_result",b);
        return json;
    }


}
