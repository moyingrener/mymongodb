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
</head>
<body>
<div class="container">
    <div class="jumbotron">
        <h1>您没有权限访问哦!</h1>
        <p>点击此处回到<a class="btn btn-lg" href="${pageContext.request.contextPath}/page/lookUpBook">首页</a></p>
    </div>
</div>
</body>
</html>