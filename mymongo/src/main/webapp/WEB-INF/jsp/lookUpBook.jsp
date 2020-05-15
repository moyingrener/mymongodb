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
    <title>书籍检索</title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/messages_zh.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            var a =<%=request.getAttribute("book_status")%>;
            if (a == null) {
                window.location.href = "${pageContext.request.contextPath}/book/lookUpBookS?currentPage=1";
            }
        }

        function selectForm() {
            let context = document.getElementById("context").value;
            if (context.indexOf("《") !== -1 || context.lastIndexOf("》") !== -1) {
                context = context.replace(/《/g, "");
                context = context.replace(/》/g, "");
                console.log(context);
                document.getElementById("context").value = context;
            }
            return true;
        }

        function form_delete(str) {
            const b = confirm("是否执行删除操作？" + "\n" + "(删除操作会使书籍数量归零，但不会删除该记录）");
            if (b) {
                const h = new XMLHttpRequest();
                if (str != null && str != "") {
                    h.open("post", "${pageContext.request.contextPath}/book/deleteBook", true);
                    h.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                } else {
                    alert("删除失败!")

                }
                h.send("object_id=" + str);
                h.onreadystatechange = function () {
                    if (h.readyState == 4 && h.status == 200) {
                        r=h.responseText;
                        delete_result=JSON.parse(r).delete_result;
                        if(delete_result){
                            alert("删除成功!");
                        }else {
                            alert("删除失败!");
                        }
                    }
                }

            }
        }
    </script>
    <style type="text/css">

    </style>
</head>
<body>
<!--首部导航条-->
<%@include file="head.jsp" %>
<div class="container">
    <div class="row">
        <form class="col-sm-6" action="${pageContext.request.contextPath}/book/lookUpBookS"
              onsubmit="return selectForm()" method="get">
            <div class="form-group">
                <label for="inputText" class="col-sm-2 control-label sr-only"
                       style="color: white;">&nbsp;&nbsp;搜索</label>
                <div class="col-sm-10" style="padding-top: 13px;">
                    <input type="text" class="form-control" id="context" name="context" id="inputText"
                           placeholder="请输入书名"
                           required="required" value="${context}">
                    <input type="hidden" name="currentPage" value="1">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2">
                    <button type="submit" class="btn btn-default">搜索</button>
                </div>
            </div>
        </form>
    </div>
    <hr/>
    <div class="row">
        <table class="table table-striped">
            <thead>
            <tr>
                <td>图书编号</td>
                <td>图书名</td>
                <td>出版社</td>
                <td>库存量</td>
                <c:if test="${role==0}">
                    <td>管理操作</td>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:if test="${book_list!=null}">
                <c:forEach items="${book_list}" var="book" varStatus="s">
                    <tr>
                        <td>${book._id}</td>
                        <td>${book.book_name}</td>
                        <td>${book.place}</td>
                        <td>${book.counts}</td>
                        <c:if test="${role==0}">
                            <td><a href="${pageContext.request.contextPath}/page/modifyBook?book_id=${book._id}"
                                   class="btn btn-success">编辑</a>
                                <button type="button" class="btn btn-danger" onclick="form_delete(this.value)"
                                        value="${book._id}">删除
                                </button>
                            </td>
                        </c:if>

                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
        <c:if test="${book_list==null}">
            <h3 style="color: red;">没有找到任何书哦！</h3>
        </c:if>
    </div>
    <c:if test="${book_list!=null}">
        <center>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${pageContext.request.contextPath}/book/lookUpBookS?context=${context}&currentPage=1">首页</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/book/lookUpBookS?context=${context}&currentPage=${currentPage-1}&max_page=${max_page}"
                           aria-label="Previous">
                            <span aria-hidden="true">上一页</span>
                        </a>
                    </li>
                    <c:forEach items="${book_array}" var="array" varStatus="s">
                        <li>
                            <a href="${pageContext.request.contextPath}/book/lookUpBookS?context=${context}&currentPage=${s.count}"
                               checked="true" style="checked:true;" class="">${s.count}</a>
                        </li>
                    </c:forEach>
                    <li>
                        <a href="${pageContext.request.contextPath}/book/lookUpBookS?context=${context}&currentPage=${currentPage+1}&max_page=${max_page}"
                           aria-label="Next">
                            <span aria-hidden="true">下一页</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/book/lookUpBookS?context=${context}&currentPage=${max_page}">尾页</a>
                    </li>
                </ul>
                <br/>
                <a>第${currentPage==0?1:currentPage}页,共${max_page}页</a>
                <br/>
                <a>共${max_count}条记录</a>
            </nav>
        </center>
    </c:if>

</div>
</body>
</html>
