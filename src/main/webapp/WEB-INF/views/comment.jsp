<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/comment.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
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
<div id="commentAll">
  <h1 id="commentH1">Comment</h1>
  <div id="commentList">
    <!-- 목록 수정 다 되면 메인 댓글 여기로 옮기기(메인 댓글 옮기면 알아서 너비 조정됨) -->

  </div>
  <!-- 메인 댓글 작성 -->
  <div id="comment-writebox">
    <div class="commenter commenter-writebox">${sessionScope.id}</div>
    <div class="comment-writebox-content">
      <textarea name="comment" id="" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
    </div>
    <div id="comment-writebox-bottom">
      <div class="register-box">
        <button class="btn" id="sendBtn" type="button">등록</button>
<%--        <button class="btn" id="modBtn" type="button">수정</button>--%>
      </div>
    </div>
  </div>
  <!-- 대댓글 형식 수정해야함 -->
  <div id="replyForm" style="display: none"> <!-- 안보이게 설정함 -->
    <input type="text" name="replyComment">
    <button id="wrtRepBtn" type="button">등록</button>
  </div>

    <!-- 수정 화면 -->
    <div id="modalWin" class="modal">
      <!-- Modal content -->
      <div class="modal-content">
        <span class="close">&times;</span>
        <p>
        <h2> | 댓글 수정</h2>
        <div id="modify-writebox">
          <div class="commenter commenter-writebox"></div>
          <div class="modify-writebox-content">
            <textarea name="" id="" cols="30" rows="5" placeholder="댓글을 남겨보세요"></textarea>
          </div>
          <div id="modify-writebox-bottom">
            <div class="register-box">
              <button class="btn" id="modBtn" type="button">수정</button>
            </div>
          </div>
        </div>
        </p>
      </div>
    </div>
</div>
<script>
  // 게시글 번호 가져와야됨...... 어디서 가져오는 건지 모르겠음
  let bno = $();

  let showList = function (bno) {
    $.ajax({
      type:'GET',       // 요청 메서드
      url: '/ch4/comments?bno='+bno,  // 요청 URI
      success : function(result){
        $("#commentList").html(toHtml(result));    // 서버로부터 응답이 도착하면 호출될 함수
      },
      error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
    }); // $.ajax()

  }

  // 날짜 변환
  let dateToString = function(ms=0) {
    let date = new Date(ms);

    let yyyy = date.getFullYear();
    let mm = addZero(date.getMonth() + 1);
    let dd = addZero(date.getDate());

    let HH = addZero(date.getHours());
    let MM = addZero(date.getMinutes());
    let ss = addZero(date.getSeconds());

    return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
  }

  $(document).ready(function(){
    showList(bno);

    $("#modBtn").click(function(){
      // 1. 변경된 내용을 서버로 전송
      let cno = $(this).attr("data-cno");
      let comment = $("#modalWin textarea").val();

      if(comment.trim()=='') {
        alert("댓글을 입력해주세요.");
        $("textarea[name=comment]").focus()
        return;
      }

      $.ajax({
        type:'PATCH',       // 요청 메서드
        url: '/ch4/comments/' + cno,  // 요청 URI  // /ch4/comments/70  POST
        headers : {"content-type":"application/json"},  // 요청 헤더
        data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result);
          showList(bno);
          // 2. 모달 창을 닫는다.
          $(".close").trigger("click");
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
    });

    $(".close").click(function(){
      $("#modalWin").css("display","none");
    });

    $("#wrtRepBtn").click(function(){
      let comment = $("input[name=replyComment]").val();
      let pcno = $("#replyForm").parent().attr("data-pcno");

      if(comment.trim()=='') {
        alert("댓글을 입력해주세요.");
        $("input[name=comment]").focus()
        return;
      }

      $.ajax({
        type:'POST',       // 요청 메서드
        url: '/ch4/comments?bno=' + bno,  // 요청 URI  // /ch4/comments?bno=431  POST
        headers : { "content-type":"application/json"},  // 요청 헤더
        data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result);
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()

      $("#replyForm").css("display", "none")
      $("input[name=replyComment]").val('')
      $("#replyForm").appendTo("body");
    });

    $("#sendBtn").click(function(){
      let comment = $("textarea[name=comment]").val();

      if(comment.trim()=='') {
        alert("댓글을 입력해주세요.");
        $("textarea[name=comment]").focus()
        return;
      }

      $.ajax({
        type:'POST',       // 요청 메서드
        url: '/ch4/comments?bno=' + bno,  // 요청 URI  // /ch4/comments?bno=431  POST
        headers : { "content-type":"application/json"},  // 요청 헤더
        data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result);
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
    });

    $("#commentList").on("click", "#listModBtn", function() {
      let cno = $(this).parent().attr("data-cno");
      let comment = $("div.comment", $(this).parent()).text();

      // 1. comment의 내용을 input에 뿌려주기
      // $("#modalWin textarea[name=comment]").val(comment);
      $("#modalWin textarea").text(comment);
      // 2. cno 전달하기
      $("#modBtn").attr("data-cno", cno);
      $("#modBtn").attr("data-bno", bno);
      // 팝업창을 열고 내용을 보여준다.
      $("#modalWin").css("display","block");

    });

    $("#commentList").on("click", "#replyBtn", function() {
      // 1. replyForm을 옮기고,
      $("#replyForm").appendTo($(this).parent());


      // 2. 답글을 입력할 폼을 보여주고,
      $("#replyForm").css("display", "block");

    });

    // $(".delBtn").click(function(){
    $("#commentList").on("click", "#delBtn", function(){
      let cno = $(this).parent().attr("data-cno");
      let bno = $(this).parent().attr("data-bno");

      $.ajax({
        type:'DELETE',       // 요청 메서드
        url: '/ch4/comments/' + cno + '?bno=' + bno,  // 요청 URI
        success : function(result){
          alert(result)
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
    });
  });

  // 사진 추가 시 대댓글 작성, 삭제 안됨
  //     tmp += '<span class="comment-img"><i class="fa fa-user-circle" aria-hidden="true"></i></span> <div class="comment-area">'
  //     tmp += '</div></li>'

  let toHtml = function (comments) {
    let tmp = '<ul id="commentUl">';

    comments.forEach(function(comment) {
      tmp += '<li id="commentLi" data-cno=' + comment.cno
      tmp += ' data-pcno=' + comment.pcno
      tmp += ' data-bno=' + comment.bno + '>'
      if(comment.cno!=comment.pcno)
        tmp += 'ㄴ'
      tmp += ' <div class="commenter">' + comment.commenter + '</div>'
      tmp += ' <div class="comment">' + comment.comment + '</div>'
      tmp += ' <span class="up_date">' + comment.up_date + '</span>'
      tmp += '<button id="delBtn" class="commentListBtn">삭제</button>'
      tmp += '<button id="listModBtn" class="commentListBtn">수정</button>'
      tmp += '<button id="replyBtn" class="commentListBtn">답글</button>'
      tmp += '</li>'
    })
    return tmp + "</ul>";
  }
</script>
</body>
</html>