package com.myee.controller;

import com.alibaba.fastjson.JSONObject;
import com.myee.pojo.User;
import com.myee.pojo.UserCustom;
import com.myee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;


@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private UserService userService;

    /**
     * 登录操作
     *
     * @param user
     * @return
     */
    @PostMapping("/login")
    public String login(@ModelAttribute("user") User user, HttpSession session, HttpServletRequest req) {
        req.setAttribute("user", user);//登录失败回显
        UserCustom userCustom = userService.selectByEmailAndPassword(user, mongoTemplate);
        if (userCustom != null) {
            session.setAttribute("user_name", userCustom.getUser_name());//登录成功
            session.setAttribute("role", userCustom.getRole());
            session.setAttribute("email", userCustom.getEmail());
            session.setAttribute("phone", userCustom.getPhone());
            session.setAttribute("object_id", userCustom.get_id().toString());
            session.setAttribute("register_time",
                    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").
                            format(new Date(Long.valueOf(userCustom.getTime())*1000L)));

            return "lookUpBook";
        }
        //登录失败
        req.setAttribute("error", "账号或密码错误！");
        return "forward:/index.jsp";

    }

    /**
     * @return 注册页面
     */
    @GetMapping("/register")
    public String register() {
        return "redirect:/register.jsp";
    }

    /**
     * 注册操作
     *
     * @param user
     * @param req
     * @return
     */
    @PostMapping("/register")
    public String registers(@ModelAttribute("user") User user, HttpServletRequest req) {
        User user2 = new User();
        user2.setEmail(user.getEmail());//邮箱重复校验
        user2 = userService.selectUserByOneParam(user2, mongoTemplate);
        if (user2 == null) {//邮箱不重复
            Boolean b = userService.insertByUser(user, mongoTemplate);
            if (b) {
                req.setAttribute("success", "注册成功");
            } else {//插入失败,未知错误
                req.setAttribute("error", "邮箱已被注册");
            }
        } else {//邮箱重复
            req.setAttribute("error", "邮箱已被注册");
        }
        req.setAttribute("user", user);//注册信息回显
        return "forward:/register.jsp";
    }

    /**
     *
     * @param user 根据邮箱查询用户是否存在
     * @param req
     * @return
     */
    @GetMapping("/lookUpEmailIsExist")
    @ResponseBody
    public JSONObject lookUpEmailIsExist(@ModelAttribute("user") User user, HttpServletRequest req) {
        JSONObject json=new JSONObject();
        if(user.getEmail()!=null&&user.getEmail()!=""){
            String email=user.getEmail();
            user = userService.selectUserByOneParam(user, mongoTemplate);
            if(user!=null){
                if(user.getEmail().equals(email)){
                        json.put("user_result",true);
                        return json;
                }
            }
        }
        json.put("user_result",false);
        return json;
    }

    /**
     * 注销操作
     *
     * @param session
     * @return
     */
    @GetMapping("/cancellation")
    public String cancellation(HttpSession session) {
        session.invalidate();
        return "redirect:/index.jsp";
    }

}

