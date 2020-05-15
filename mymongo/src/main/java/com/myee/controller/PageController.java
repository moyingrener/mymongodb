package com.myee.controller;

import com.myee.pojo.BookCustom;
import com.myee.service.BookService;
import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("page")
public class PageController {
    private Logger logger = Logger.getLogger(BookController.class);
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private BookService bookService;

    @GetMapping("/login")
    public String login(){
        return "redirect:/index.jsp";
    }

    @GetMapping("/bookManger")
    public String bookManger(){
        return "bookManger";
    }

    @GetMapping("/borrowAndReturn")
    public String borrowAndReturn(){
        return "borrowAndReturn";
    }

    @GetMapping("/borrowRecord")
    public String borrowRecord(){
        return "borrowRecord";
    }

    @GetMapping("/lookUpBook")
    public String lookUpBook(){
        return "lookUpBook";
    }

    @GetMapping("/personInfo")
    public String personInfo(){
        return "personInfo";
    }

    @GetMapping("/modifyBook")
    public String modifyBook(@ModelAttribute("book_1") BookCustom book,String book_id, HttpServletRequest req){
        book.set_id(new ObjectId(book_id));
        Map map=bookService.selectBook(book,mongoTemplate,1);
        if(map!=null){
            if(map.size()!=0){
                req.setAttribute("book",map.get("book"));
            }
        }
        return "modifyBook";
    }

}
