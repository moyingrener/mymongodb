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
    <title>书籍信息管理</title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/messages_zh.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <style type="text/css">
        .validate {
            color: red;
        }
    </style>
    <script type="text/javascript">
        function formSumit() {
            let o=document.getElementById("book_name").value;
            if (o.indexOf("《")!==-1&&o.lastIndexOf("》")!==-1){
                return true;
            }else{
                alert("请给书名加书名号,如《龙族》");
                return false;
            }
        }
        $(function () {
            $(".form-horizontal").validate({
                rules: {
                    book_name: {
                        required: true,
                        minlength: 3,
                    },
                    place: {
                        required: true,
                        minlength: 1,
                    },
                    counts: {
                        required: true,
                        minlength: 1,
                        digits: true
                    },
                },
                message: {},
                errorClass: "validate"
            });
        });
    </script>
</head>
<body>
<!--首部导航条-->
<%@include file="head.jsp" %>
<div class="container">
    <div class="row">
        <h3>书籍修改<span class="label label-info">信息填写</span></h3>
    </div>
    <div class="row">
        <form class="form-horizontal" id="book_form" action="${pageContext.request.contextPath}/book/modifyBook" onsubmit="return formSumit()" method="post">
            <div class="form-group">
                <label for="book_id_1" class="col-sm-2 col-sm-offset-2 control-label">图书编号</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" readonly id="book_id_1" name="book_id_1" autocomplete="off"
                           value="${book._id}">
                    <input type="hidden" value="${book._id}" id="book_id" name="book_id" readonly>
                </div>
            </div>
            <div class="form-group">
                <label for="book_name" class="col-sm-2 col-sm-offset-2 control-label">书名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="book_name" name="book_name" autocomplete="off"
                           placeholder="请输入书名" value="${book.book_name}">
                </div>
            </div>
            <div class="form-group">
                <label for="place" class="col-sm-2 col-sm-offset-2 control-label">出版社</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="place" name="place" placeholder="请输入出版社"
                           autocomplete="off" value="${book.place}">
                </div>
            </div>
            <div class="form-group">
                <label for="counts" class="col-sm-2 col-sm-offset-2 control-label">数量</label>
                <div class="col-sm-4">
                    <input type="number" class="form-control" id="counts" name="counts" autocomplete="off"
                           oninput="if(value<1)value=1"
                           placeholder="请输入数量" value="${book.counts}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-4">
                    <button type="submit" class="btn btn-default">提交</button>
                    <button type="reset" class="btn btn-default">重置</button>
                    <!-- 录入成功显示 -->
                    <c:if test="${success!=null}">
                        <span style="color: green">${success}</span>
                    </c:if>
                    <!-- 录入失败显示 -->
                    <c:if test="${fail!=null}">
                        <span style="color: red">${fail}</span>
                    </c:if>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
