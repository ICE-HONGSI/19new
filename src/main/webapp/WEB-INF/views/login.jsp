<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ubinetsys.pms.login.LoginController"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html>
<head>
<title>ENERGUARD SYSTEM</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="./css/login.css">
<script>
	var getCookie = function(name) {
	    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	    return value? value[2] : null;
	};
    var deleteCookie = function(name) {
        var date = new Date();
        document.cookie = name + "= " + "; expires=" + date.toUTCString() + "; path=/";
    }
    var setCookie = function(name, value, day) {
        var date = new Date();
        date.setTime(date.getTime() + day * 60 * 60 * 24 * 1000);
        document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
    };   
</script>
</head>
<body class="backGround">
	<c:choose>
		<c:when test="${not empty sessionScope.userLoginInfo}">
			<script>
				location.href = 'main';
			</script>
		</c:when>
		<c:otherwise>
			<div class="loginContent">
				<img src="./img/login/logo.png" alt="logo" id="loginLogo" />
				<form name="form1" method="post" action="loginProcess">
					<input type="text" style="background-color: blue !important;"
						name="Uuid" id="Uuid" placeholder="id" class="loginText"
						value="" /><br /> <br /> <input type="password"
						name="Upwd" class="loginText" placeholder="Password" /><br /> <br />
					<div class="loginSubWrapper">
						<span id="saveId"><input type="checkbox" name="saveId" id="idSave">&nbsp;아이디
							저장</span> <span id="saveBoth"><input type="checkbox"
							name="saveBoth">&nbsp;
							자동로그인 </span> <input type="submit" value="로그인" id="loginSubmit" />
					</div>
				</form>
			</div>
		</c:otherwise>
	</c:choose>
	<script>
		var userid = getCookie("userid");
		if(userid){
			document.getElementById("Uuid").value=getCookie("userid");
			document.getElementById("idSave").checked = true;
			document.getElementById("Upwd").focus();			
		}			
		else
			document.getElementById("Uuid").focus();		
	</script>
	<c:if test="${param.msg == 'f'}">
		<script>
			alert("사용자 ID나 암호를 확인하세요");			
		</script>
	</c:if>
</body>
</html>