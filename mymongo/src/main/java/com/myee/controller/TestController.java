package com.myee.controller;

import com.alibaba.fastjson.JSONObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.myee.pojo.User;
import com.myee.service.UserService;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.codehaus.jackson.map.util.ISO8601DateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class TestController {
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private UserService userService;
    private MongoCollection<Document> tx;
    private JSONObject json = new JSONObject();

    @GetMapping("/test")
    @ResponseBody
    public JSONObject test(@ModelAttribute("user")User user) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        int time = 1574689526;
        System.out.println(simpleDateFormat.format(new Date(Long.valueOf("1574689526")*1000L)));
        //getTimestamp获取秒,要乘1000变成毫秒
        System.out.println(simpleDateFormat.format(new Date(Long.valueOf(new ObjectId().getTimestamp())*1000L)));
        //System.out.println(new ObjectId().getTimestamp());
        //System.out.println(new Date((long)new ObjectId().getTimestamp()));
        //System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(1574664176));
        //System.out.println(System.currentTimeMillis());
        //System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis())));
        user.setEmail("aaa");
        user=userService.selectUserByOneParam(user,mongoTemplate);
        json.put("list", user);
        return json;
    }


}
