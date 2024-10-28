<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>
<html>
<head>
	<title>Session 사용</title>
</head>
<body>
<h2>Session 사용</h2>
<p>세션 이름 : <b>${sessionScope.userLoginInfo.getUuid()}</b></p>
<P>페이지 상단에 &lt;%@ page session="<font color="red">true</font>" %&gt; 선언함</P>
</body>
</html>
