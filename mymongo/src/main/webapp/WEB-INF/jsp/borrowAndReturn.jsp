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
    <title>借书/还书</title>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/statics/js/messages_zh.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
    <style type="text/css">
        body {
            background-color: black;
        }

        .validate {
            color: red;
        }
    </style>
    <script type="text/javascript">
        window.a=false;
        window.b=false;
        $(function () {
            $(".book_form_1").validate({
                rules: {
                    object_id: {
                        required: true,
                        minlength: 24,
                        maxlength: 24
                    },
                    email: {
                        required: true,
                        email: true
                    }
                },
                message: {},
                errorClass: "validate"
            });

            $(".book_form_2").validate({
                rules: {
                    object_id: {
                        required: true,
                        minlength: 24,
                        maxlength: 24
                    },
                    email: {
                        required: true,
                        email: true
                    }
                },
                message: {},
                errorClass: "validate"
            });
        });

        function lookUpBookName(int) {
            document.getElementById("book_success_1").innerText = "";
            document.getElementById("book_fail_1").innerText = "";
            document.getElementById("book_success_2").innerText = "";
            document.getElementById("book_fail_2").innerText = "";
            const h = new XMLHttpRequest();
            if (int == 1) {
                const v = document.getElementById("object_id_1").value;
                console.log(v);
                if (v.length == 24) {
                    h.open("get", "${pageContext.request.contextPath}/book/lookUpBookById?object_id=" + v, true);
                }
            } else {
                const v = document.getElementById("object_id_2").value;
                if (v.length == 24) {
                    h.open("get", "${pageContext.request.contextPath}/book/lookUpBookById?object_id=" + v, true);
                }
            }
            const v1 = document.getElementById("object_id_1").value;
            const v2 = document.getElementById("object_id_2").value;
            if (v1.length == 24 || v2.length == 24) {
                h.send();
                h.onreadystatechange = function () {
                    if (h.readyState == 4 && h.status == 200) {
                        const json = h.responseText;//获取到json字符串，还需解析
                        const book_name = JSON.parse(json).book_name;
                        if (book_name != null) {
                            if (int == 1) {
                                document.getElementById("book_success_1").innerText = "书名为:" + book_name + "请核对!";
                            } else {
                                document.getElementById("book_success_2").innerText = "书名为" + book_name + "请核对!";
                            }
                            window.a=true;
                        } else {
                            if (int == 1) {
                                document.getElementById("book_fail_1").innerText = "未查到该书，请检查编号是否正确!"
                            } else {
                                document.getElementById("book_fail_2").innerText = "未查到该书，请检查编号是否正确!"
                            }
                            window.a=false;
                        }
                    }
                };
            }
        }

        function lookUpEmailIsExist(int) {
            document.getElementById("book_success_email_1").innerText = "";
            document.getElementById("book_fail_email_1").innerText = "";
            document.getElementById("book_success_email_2").innerText = "";
            document.getElementById("book_fail_email_2").innerText = "";
            const h = new XMLHttpRequest();
            if (int == 1) {
                const v = document.getElementById("email_1").value;
                console.log(v);
                h.open("get", "${pageContext.request.contextPath}/user/lookUpEmailIsExist?email=" + v, true);
            } else {
                const v = document.getElementById("email_2").value;
                h.open("get", "${pageContext.request.contextPath}/user/lookUpEmailIsExist?email=" + v, true);
            }
            if (document.getElementById("email_1").value!=""||document.getElementById("email_2").value!="") {
                h.send();
                h.onreadystatechange = function () {
                    if (h.readyState == 4 && h.status == 200) {
                        const json = h.responseText;//获取到json字符串，还需解析
                        console.log(json);
                        const user_result = JSON.parse(json).user_result;
                        if (user_result) {
                            if (int == 1) {
                                document.getElementById("book_success_email_1").innerText = "用户存在!";
                            } else {
                                document.getElementById("book_success_email_2").innerText = "用户存在!";
                            }
                            window.b=true;
                        } else {
                            if (int == 1) {
                                document.getElementById("book_fail_email_1").innerText = "用户不存在!"
                            } else {
                                document.getElementById("book_fail_email_2").innerText = "用户不存在!"
                            }
                            window.b=false;
                        }
                    }
                };
            }
        }

        function form_submit(int) {
                lookUpBookName(int);
                lookUpEmailIsExist(int);
                if(window.a){
                    if(window.b){
                        return true;
                    }
                }else {
                    alert("1.请检查书籍编号或用户邮箱是否存在!"+ "\n"+"2.请检查邮箱是否是借阅者本人！")
                    return false;
                }
        }
    </script>
</head>
<body>
<!--首部导航条-->
<%@include file="head.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-sm-6">
            <div class="jumbotron">
                <h1>借书</h1>
                <form class="book_form_1" action="${pageContext.request.contextPath}/form/borrowAndReturnBook"
                      method="post" onsubmit="return form_submit(1)">
                    <div class="form-group">
                        <label for="object_id_1">图书编号</label>
                        <input type="text" class="form-control" name="object_id" id="object_id_1" placeholder="请输入图书编号"
                               required="required" autocomplete="off" value="${book_object_id_1}"
                               onblur="lookUpBookName(1)">
                        <input type="hidden" name="index" value=1>
                        <%--回显书籍名--%>
                        <span id="book_success_1" style="color: green;"></span>
                        <span id="book_fail_1" style="color: red;"></span>
                    </div>
                    <div class="form-group">
                        <label for="email_1">借阅人邮箱</label>
                        <input type="email" class="form-control" name="email" id="email_1" placeholder="请输入借阅人邮箱"
                               required="required" autocomplete="off" value="${borrow_email}"
                               onblur="lookUpEmailIsExist(1)">
                        <%--回显邮箱--%>
                        <span id="book_success_email_1" style="color: green;"></span>
                        <span id="book_fail_email_1" style="color: red;"></span>
                    </div>
                    <button type="submit" class="btn btn-default">提交</button>
                    <%--操作结果提示--%>
                    <span id="book_submit_success_1" style="color: green;">${success_1}</span>
                    <span id="book_submit_fail_1" style="color:red;">${fail_1}</span>
                </form>
            </div>
        </div>

        <div class="col-sm-6">
            <div class="jumbotron">
                <h1>还书</h1>
                <form class="book_form_2" action="${pageContext.request.contextPath}/form/borrowAndReturnBook"
                      method="post" onsubmit="return form_submit(2)">
                    <div class="form-group">
                        <label for="object_id_2">图书编号</label>
                        <input type="text" class="form-control" name="object_id" id="object_id_2" placeholder="请输入图书编号"
                               required="required" autocomplete="off" value="${book_object_id_2}"
                               onblur="lookUpBookName(2)">
                        <input type="hidden" name="index" value=2>
                        <%--回显书籍名--%>
                        <span id="book_success_2" style="color: green;"></span>
                        <span id="book_fail_2" style="color: red;"></span>
                    </div>
                    <div class="form-group">
                        <label for="email_2">借阅人邮箱</label>
                        <input type="email" class="form-control" name="email" id="email_2" placeholder="请输入借阅人邮箱"
                               onblur="lookUpEmailIsExist(2)"
                               required="required" autocomplete="off" value="${return_email}">
                        <%--回显邮箱--%>
                        <span id="book_success_email_2" style="color: green;"></span>
                        <span id="book_fail_email_2" style="color: red;"></span>
                    </div>
                    <button type="submit" class="btn btn-default">提交</button>
                    <%--操作结果提示--%>
                    <span id="book_submit_success_2" style="color: green;">${success_2}</span>
                    <span id="book_submit_fail_2" style="color:red;">${fail_2}</span>
                </form>
            </div>
        </div>
    </div>

</div>
</div>
</body>
</html>
