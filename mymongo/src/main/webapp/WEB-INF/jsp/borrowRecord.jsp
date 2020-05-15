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
    <title>借书记录</title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <style type="text/css">

    </style>
    <script type="text/javascript">
        var a =
            <%=request.getAttribute("form_status") %>
            console.log(a);
        if (a == null) {
            window.onload = function () {
                window.location.href = "${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord"
            }
        }

    </script>
</head>
<body>
<!--首部导航条-->
<%@include file="head.jsp" %>
<div class="container">
    <div class="row">
        <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=1&currentPage=1"
           class="btn btn-success">查看已还</a>
        <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=0&currentPage=1"
           class="btn btn-danger">查看未还</a>
    </div>
    <div class="row">
        <table class="table table-striped">
            <thead>
            <tr>
                <td>图书编号</td>
                <td>图书名</td>
                <td>出版社</td>
                <%--管理员--%>
                <c:if test="${role==0}">
                    <td>借阅人邮箱</td>
                </c:if>
                <td>借书时间</td>
                <td>归还状态</td>
            </tr>
            </thead>
            <c:if test="${record_list!=null}">
                <tbody>
                <c:forEach items="${record_list}" var="record">
                    <tr>
                        <td>${record.book_id}</td>
                        <td>${record.book_name}</td>
                        <td>${record.place}</td>
                            <%--管理员--%>
                        <c:if test="${role==0}">
                            <td>${record.email}</td>
                        </c:if>
                        <td>${record.time}</td>
                        <td>${record.back}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </c:if>
        </table>
        <c:if test="${form_status==2}">
            <h3 style="color: red;">没有找到任何书哦！</h3>
        </c:if>
    </div>


    <c:if test="${record_list!=null}">
        <center>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=${back}&currentPage=1">首页</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=${back}&currentPage=${currentPage-1}&total_page=${total_page}"
                           aria-label="Previous">
                            <span aria-hidden="true">上一页</span>
                        </a>
                    </li>
                    <c:if test="${form_array!=null}">
                        <c:forEach items="${form_array}" var="array" varStatus="s">
                            <li>
                                <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=${back}&currentPage=${s.count}">${s.count}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <li>
                        <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=${back}&currentPage=${currentPage+1}&total_page=${total_page}"
                           aria-label="Next">
                            <span aria-hidden="true">下一页</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/form/selectBorrowAndReturnRBookRecord?back=${back}&currentPage=${total_page}">尾页</a>
                    </li>
                </ul>
                <br/>
                <a>第${currentPage}页,共${total_page}页</a>
                <br/>
                <a>共${total_count}条记录</a>
            </nav>
        </center>
    </c:if>


</div>
</body>
</html>
