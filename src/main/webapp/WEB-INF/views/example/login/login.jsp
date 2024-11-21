<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
  <head>
    <title>ENERGUARD SYSTEM</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="./css/login.css">
  </head>
<body class="backGround">
<c:choose>
	<c:when test="${not empty sessionScope.userLoginInfo}">
		<%
		response.sendRedirect("main");
		%>
	</c:when>
	<c:otherwise>
		
		
    <div class="loginContent">
      <img src="./img/login/svg/logo.svg" alt="logo" id="loginLogo"/>
      <form name="form1" method="post" action="loginProcess">
        <input type="text" style="background-color: blue!important;" name="Uuid" class="loginText" placeholder="ID"/><br/><br/>
        <input type="password" name="Upwd" class="loginText" placeholder="Password"/><br/><br/>
        <div class="loginSubWrapper">
          <span id="saveId"><input type="checkbox" name="saveId">&nbsp;아이디 저장</span>
          <input type="submit" value="로그인" id="loginSubmit"/>
        </div>
      </form>
    </div>
  
	</c:otherwise>
</c:choose>
</body>
</html>