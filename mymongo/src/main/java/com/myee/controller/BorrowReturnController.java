package com.myee.controller;

import com.alibaba.fastjson.JSONObject;
import com.myee.pojo.BRForm;
import com.myee.pojo.BRFormCustom;
import com.myee.pojo.Book;
import com.myee.pojo.BookCustom;
import com.myee.service.BRFormService;
import com.myee.service.BookService;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("form")
public class BorrowReturnController {
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private BookService bookService;
    @Autowired
    private BRFormService brFormService;

    /**
     *  借书/还书操作
     * @param book
     * @param form
     * @param req
     * @param email
     * @param object_id
     * @param index
     * @return
     */
    @PostMapping("/borrowAndReturnBook")
    public String borrowAndReturnBook(@ModelAttribute("book") BookCustom book,
                                          @ModelAttribute("form") BRForm form,
                                          HttpServletRequest req,String email,
                                      String object_id, Integer index){
        Boolean b=false;
        book.set_id(new ObjectId(object_id));
        form.setBook_id(object_id);
        Map map=bookService.selectBook(book,mongoTemplate,1);
        if(map!=null){
            if(map.size()>0){//书籍存在
                Book object_book=(Book)map.get("book");
                form.setBook_name(object_book.getBook_name());
                form.setPlace(object_book.getPlace());
                b=brFormService.updateBRForm(form,mongoTemplate,index);
            }
        }
        //书籍不存在
        //回显
        if(index==1){
            req.setAttribute("borrow_email",email);
            req.setAttribute("book_object_id_1",object_id);
            if(b){
                req.setAttribute("success_1","操作成功!");
            }else {
                req.setAttribute("fail_1","操作失败!");
            }
        }else {
            req.setAttribute("return_email",email);
            req.setAttribute("book_object_id_2",object_id);
            if(b){
                req.setAttribute("success_2","操作成功!");
            }else {
                req.setAttribute("fail_2","操作失败!");
            }
        }

        return "borrowAndReturn";
    }

    /**
     *
     * @param req 查询借书/还书记录
     * @param session
     * @param back
     * @return
     */
    @GetMapping("/selectBorrowAndReturnRBookRecord")
    public String selectBorrowAndReturnRBookRecord(HttpServletRequest req, HttpSession session, Integer back,Integer currentPage,Integer total_page){
        if(total_page!=null){
            if (currentPage<0){
                currentPage=1;
            }else if(currentPage>total_page){
                currentPage=total_page;
            }
        }
        Integer role=(Integer)session.getAttribute("role");
        String email=(String)session.getAttribute("email");
        List<BRFormCustom> record_list=null;
        Integer total_count=0;
        if(role==0){//管理员权限查询
            if(back==null){//默认查未还
                record_list=brFormService.selectBorrowAndReturnRBookRecordRole(mongoTemplate,0,1);
                back=0;
                currentPage=1;
                total_count=brFormService.selectBorrowAndReturnRBookRecordCountRole(mongoTemplate,0);
            }else{//根据back值查询归还/借出 信息
                record_list=brFormService.selectBorrowAndReturnRBookRecordRole(mongoTemplate,back,currentPage);
                total_count=brFormService.selectBorrowAndReturnRBookRecordCountRole(mongoTemplate,back);
            }
        }else {//借阅者权限查询
            if(back==null){//默认查未还
                record_list=brFormService.selectBorrowAndReturnRBookRecordUser(mongoTemplate,email,0,1);
                back=0;
                currentPage=1;
                total_count=brFormService.selectBorrowAndReturnRBookRecordCountUser(mongoTemplate,email,0);
            }else {//根据back值查询归还/借出 信息
                record_list=brFormService.selectBorrowAndReturnRBookRecordUser(mongoTemplate,email,back,currentPage);
                total_count=brFormService.selectBorrowAndReturnRBookRecordCountUser(mongoTemplate,email,back);
            }
        }
        if(record_list!=null){
            if(record_list.size()>0){
                for(BRFormCustom b:record_list){
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        b.setTime(simpleDateFormat.format(new Date(Long.valueOf(b.get_id().getTimestamp())*1000L)));
                }
                Integer[] pageArray=null;
                if(total_count<6){
                    pageArray=new Integer[1];
                    req.setAttribute("total_page",1);
                }else {
                    pageArray=new Integer[(total_count/5)+1];
                    req.setAttribute("total_page",(total_count/5)+1);
                }
                Arrays.fill(pageArray,0);
                req.setAttribute("record_list",record_list);
                req.setAttribute("back",back);
                req.setAttribute("page",currentPage);
                req.setAttribute("total_count",total_count);
                req.setAttribute("form_status",1);
                req.setAttribute("form_array",pageArray);
                return "borrowRecord";
            }
        }
        req.setAttribute("form_status",2);//无记录
        return "borrowRecord";
    }
}
