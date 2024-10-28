<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
<title>ENERGUARD SYSTEM</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="./css/top.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="./js/top.js"></script>
<link rel="stylesheet" type="text/css" href="./css/top.css">
<link rel="stylesheet" type="text/css" href="./css/main.css">
<link rel="stylesheet" type="text/css" href="./css/oper.css?v=0530">
<link rel="stylesheet" type="text/css" href="./css/trend.css">
<link rel="stylesheet" type="text/css" href="./css/report.css">
<link rel="stylesheet" type="text/css" href="./css/control.css">
</head>
<body>

	<div class="pwInput">
		<div class="pwContents">
			<div class="pwTitle">
				<span>관리자 비밀번호</span>
			</div>
			<div class="pwInputField">
				<input type="password" id="password" name="password"
					placeholder="비밀번호를 입력하세요." />
			</div>
			<div class="pwButtonSection">
				<button class="pwClose">닫기</button>
				<button class="pwConfirm">확인</button>
			</div>
		</div>
	</div>

</body>

</html>
