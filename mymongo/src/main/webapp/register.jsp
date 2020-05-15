<%@ page language="java" contentType="text/html;charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="fm" %>
<%--<jsp:useBean id="user" class="com.myee.pojo.User" scope="request"></jsp:useBean>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/messages_zh.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <style type="text/css">
        .validate{
            color: red;
        }
        body{
            background-color: beige;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $(".form-horizontal").validate({
                rules: {
                    user_name: {
                        required: true,
                        minlength: 3,
                    },
                    password: {
                        required: true,
                        minlength: 6
                    },
                    repassword: {
                        required: true,
                        equalTo: "[name='password']"
                    },
                    email: {
                        required: true,
                        email: true
                    }, phone: {
                        required: true,
                        minlength: 11,
                        maxlength: 11,
                        digits: true,
                    },
                },
                message: {},
                errorClass: "validate"
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <h3>用户注册<span class="label label-info">信息填写</span></h3>
    </div>
    <div class="row">
        <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/register">
            <div class="form-group">
                <label for="user_name" class="col-sm-2 col-sm-offset-2 control-label">用户名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="user_name" name="user_name" autocomplete="off"
                           placeholder="请输入用户名" value="${user.user_name}">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 col-sm-offset-2 control-label">密码</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label for="repassword" class="col-sm-2 col-sm-offset-2 control-label">确认密码</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="repassword" name="repassword" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-sm-2 col-sm-offset-2 control-label">邮箱</label>
                <div class="col-sm-4">
                    <input type="email" class="form-control" id="email" name="email" autocomplete="off"
                           placeholder="请输入邮箱" value="${user.email}">
                    <!-- 邮箱已被注册时显示 -->
                    <c:if test="${error!=null}">
                        <span style="color: red">${error}</span>
                    </c:if>
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 col-sm-offset-2 control-label">手机号</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="phone" name="phone" autocomplete="off"
                           placeholder="请输入手机号" value="${user.phone}">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-4">
                    <button type="submit" class="btn btn-default">注册</button>
                    <button type="reset" class="btn btn-default">重置</button>
                    <a href="${pageContext.request.contextPath}" class="btn btn-default">登录</a>
                    <!-- 注册成功显示 -->
                    <c:if test="${success!=null}">
                        <span style="color: green">${success}</span>
                        点击此处<a href="${pageContext.request.contextPath}">登陆</a>
                    </c:if>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
