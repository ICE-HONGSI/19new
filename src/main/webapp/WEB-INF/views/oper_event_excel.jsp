<%@ page contentType="application/vnd.ms-excel; charset=utf-8"
	import="java.text.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*"%>
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
	String today = format.format(new Date());
	String dateFrom = request.getParameter("dateFrom");
	String dateTo = request.getParameter("dateTo");

	String fileName = dateFrom + "_" + dateTo + "_event_" + today; // example : 201906_report_20190619.xls     
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
				<th id="no"><span>No.</span></th>
				<th id="date"><span>발생 일시</span></th>
				<th id="name"><span>설비명</span></th>
				<th id="content"><span>제어내용</span></th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach items="${list}" var="row">
						<tr onclick="PopupEmpInfo(this)">
							<td>${row.Gno }</td>
							<td>${row.DT }</td>
							<td>${row.Device }</td>
							<td>${row.Command }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr onclick="PopupEmpInfo(this)">
						<td colspan=4 style="color: #BDBDBD">조회된 데이터가 없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

</body>
</html>