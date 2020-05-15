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
    <title>个人信息管理</title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/messages_zh.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <style type="text/css">

    </style>
</head>
<body>
<!--首部导航条-->
<%@include file="head.jsp"%>
<div class="container">
    <div class="row">
        <h1>我的信息</h1><br/>
        <h4>会员名:<span>&nbsp;&nbsp;${user_name}</span></h4><br/>
        <h4>邮箱:<span>&nbsp;&nbsp;${email}</span></h4><br/>
        <h4>手机号:<span>&nbsp;&nbsp;${phone}</span></h4><br/>
        <h4>注册时间:<span>&nbsp;&nbsp;${register_time}</span></h4><br/>
    </div>
</div>
</body>
</html>
