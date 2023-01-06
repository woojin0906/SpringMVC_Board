<%--
  Created by IntelliJ IDEA.
  User: jwjle
  Date: 2022-12-29
  Time: 오후 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--세션을 false 상태로 해둠 -->
<%@ page session="false"%>
<!-- id 세션이 없는 경우 공백, 있는 경우 id 값 가져오기 -->
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<!-- id 값이 없는 경우 'Login', 있는 경우 'Logout'으로 표시 -->
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>fastcampus</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<div id="menu">
    <ul id="menuUl">
        <li class="menuLi" id="logo">fastcampus</li>
        <li class="menuLi"><a class="menuA" href="<c:url value='/'/>">Home</a></li>
        <li class="menuLi"><a class="menuA" href="<c:url value='/board/list'/>">Board</a></li>
        <li class="menuLi"><a class="menuA" href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li class="menuLi"><a class="menuA" href="<c:url value='/register/add'/>">Sign in</a></li>
        <li class="menuLi"><a class="menuA" href=""><i class="fa fa-search"></i></a></li>
    </ul>
</div>
<div style="text-align:center">
    <h1>This is HOME</h1>
    <h1>This is HOME</h1>
    <h1>This is HOME</h1>
</div>
</body>
</html>