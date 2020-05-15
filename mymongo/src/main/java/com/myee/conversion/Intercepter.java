package com.myee.conversion;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Intercepter extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler)
            throws Exception {
        HttpSession session = req.getSession();//获取请求地址
        String oldUrl=req.getRequestURI();
        //假如请求公共页面,放行
        if(oldUrl.indexOf("/login")>=0||
                oldUrl.indexOf("/register")>=0||
                oldUrl.indexOf("/lookUpBook")>=0
        ){
            return true;
        }
        //否则开始认证
        Integer role=null;
        role=(Integer) session.getAttribute("role");
        if(role==null){//验证失败
            req.getRequestDispatcher("/error.jsp").forward(req, res);
            return false;
        }else if(role==0){//管理员权限
            return true;
        }else if(role==1){//用户权限
            if(oldUrl.indexOf("uploadBook")>=0
                    ||oldUrl.indexOf("lookUpBookById")>=0
                    ||oldUrl.indexOf("modifyBook")>=0
                    ||oldUrl.indexOf("deleteBook")>=0
                    ||oldUrl.indexOf("borrowAndReturnBook")>=0
                    ||oldUrl.indexOf("bookManger")>=0
                    ||oldUrl.indexOf("borrowAndReturn")>=0
                    ||oldUrl.indexOf("lookUpEmailIsExist")>=0
            ){
                req.getRequestDispatcher("/error2.jsp").forward(req, res);
                return false;
            }else {
                return true;
            }
        }
        //验证失败返回首页
        req.getRequestDispatcher("/index.jsp").forward(req, res);
        return false;

    }
}
