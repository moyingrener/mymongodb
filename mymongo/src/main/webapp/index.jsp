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
    <title>登陆</title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/messages_zh.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <style type="text/css">
        body {
            background: url(${pageContext.request.contextPath}/statics/img/timg1.jpg) no-repeat;
            background-size: 100% 100%;
            background-attachment: fixed;
        }

        .validate {
            color: red;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $(".form-horizontal").validate({
                rules: {
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true,
                        minlength: 6
                    }

                },
                message: {},
                errorClass: "validate"
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="row" style="padding:150px 0px 50px 0px;">
        <div class="col-sm-4 text-center col-sm-offset-4">
            <h1 style="color: white;">图书管理系统</h1></div>
    </div>
    <div class="row">
        <form class="col-sm-4 col-sm-offset-4" action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-group">
                <label for="email" class="control-label" style="color: white;">&nbsp;&nbsp;账号</label>
                <div class="">
                    <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱"
                           value="${user.email}" autocomplete="on"
                           required="required">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="control-label" style="color: white;">&nbsp;&nbsp;密码</label>
                <div class="">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码"
                           required="required">
                    <!-- 登录失败时显示 -->
                    <c:if test="${error!=null}">
                        <span style="color: red">${error}</span>
                    </c:if>
                </div>
            </div>
            <div class="form-group">
                <div class="text-center">
                    <button type="submit" class="btn btn-default">登录</button>
                    <a href="${pageContext.request.contextPath}/user/register" class="btn btn-default">注册</a>
                    <a href="${pageContext.request.contextPath}/book/lookUpBookS?currentPage=1" class="btn btn-default">查书</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>