<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!--세션을 false 상태로 해둠 -->
<%@ page session="false"%>
<%@ page import="java.net.URLDecoder"%>
<!-- id 세션이 없는 경우 공백, 있는 경우 id 값 가져오기 -->
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<!-- id 값이 없는 경우 'Login', 있는 경우 'Logout'으로 표시 -->
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/register.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <title>Register</title>
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

<!--form action="<c:url value="/register/save"/>" method="POST" onsubmit="return formCheck(this)"-->
<form:form modelAttribute="user">
    <div class="title">Register</div>
    <div id="msg" class="msg"><form:errors path="id"/></div>
    <label>아이디</label>
    <input class="input-field" type="text" name="id" placeholder="6~12자리의 영대소문자와 숫자 조합">
    <label>비밀번호</label>
    <input class="input-field" type="text" name="pwd" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label>이름</label>
    <input class="input-field" type="text" name="name" placeholder="홍길동">
    <label>이메일</label>
    <input class="input-field" type="text" name="email" placeholder="example@fastcampus.co.kr">
    <label>생일</label>
    <input class="input-field" type="text" name="birth" placeholder="2020-12-31">
    <div class="sns-chk">
        <label><input type="checkbox" name="sns" value="facebook"/>페이스북</label>
        <label><input type="checkbox" name="sns" value="kakaotalk"/>카카오톡</label>
        <label><input type="checkbox" name="sns" value="instagram"/>인스타그램</label>
    </div>
    <button>회원 가입</button>
</form:form>
<script>

    function formCheck(frm) {
        let msg ='';
        // !!!!!!!!!!수정해야함
        if(frm.id.value.length<3) {
            setMessage('id의 길이는 3이상이어야 합니다.', frm.id);
            return false;
        }
        return true;
    }
    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
        if(element) {
            element.select();
        }
    }
</script>
</body>
</html>
