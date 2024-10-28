<%@ page contentType="application/vnd.ms-excel; charset=utf-8"
	import="java.text.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	String today = format.format(new Date());
	String label = request.getParameter("year");
	if (Integer.valueOf(request.getParameter("month")) < 10) {
		label += "0";
	}
	;
	label += request.getParameter("month");
	String fileName = label + "_report_" + today; // example : 201906_report_20190619.xls     
	response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko" style="overflow: hidden">
<head>
<meta http-equiv='Content-Type'
	content='application/vnd.ms-excel; charset=utf-8' />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>excel</title>
<style>
* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
}

table {
	text-align: center;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
}
</style>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>No</th>
				<th>날짜</th>
				<th>발전량</th>
				<th>충전량</th>
				<th>방전량</th>
				<th>발전수익</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${power}" var="row" varStatus="status">
				<tr>
					<td><c:out value="${status.count}" /></td>
					<td>${year}-${month}-<c:out value="${status.count}" /></td>
					<td>${row}</td>
					<td>${charge[status.count-1]}</td>
					<td>${discharge[status.count-1]}</td>
					<td>${profitArr[status.count-1]}원</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>

</body>
</html>