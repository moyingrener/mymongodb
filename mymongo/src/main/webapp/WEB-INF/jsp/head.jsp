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
        .navbar-default .navbar-nav > li > a{
            color: white;
        }
        body{
            background-color: beige;
        }
        #bs-example-navbar-collapse-1 a {
            padding-left: 20px;
            padding-right: 20px;
        }
        #userpic{
            width: 68px;
            height: 50px;
        }
    </style>
    <script type="text/javascript">

    </script>
</head>
<body>
<!--首部导航条-->
<nav class="navbar navbar-default" style="background-color: black;">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-bishop" aria-hidden="true">Brand</span></a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <c:if test="${role==null}">
                    <li><a href="${pageContext.request.contextPath}/page/login">登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/register">注册</a></li>
                </c:if>
                <c:if test="${user_name!=null}">
                    <li><a href="${pageContext.request.contextPath}/user/cancellation">注销</a></li>
                </c:if>
                <li><a href="" style="padding: 0px;"><img id="userpic" src="${pageContext.request.contextPath}/statics/img/userIamge.png" alt="用户图片" class="img-circle">
                    <span>${user_name}</span></a>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="${pageContext.request.contextPath}/page/lookUpBook">书籍检索</a></li>
                <%--管理员--%>
                <c:if test="${role==0}">
                    <li><a href="${pageContext.request.contextPath}/page/bookManger">书籍信息管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/page/borrowAndReturn">借书/还书</a></li>
                </c:if>
                    <li><a href="${pageContext.request.contextPath}/page/borrowRecord">借书记录</a></li>
                <li><a href="${pageContext.request.contextPath}/page/personInfo">个人信息管理</a></li>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>
