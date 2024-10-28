<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>Main</title>
</head>
<body>
	<h2>데이터 목록</h2><br>
	<h3>태양광 발전 정보</h3><br>
	현재 발전량:${row.R_PVOut}<br>
	현재 배터리:${row.R.SOC}<br>
	
	<h3>운전정보</h3><br>
	설치용량: 다른 SQL에서 데이터를 또 긁어와야하네<br>
	PMS통신상태: ${row.PMS_Alarm}<br>
	PCS상태아이콘: ${row.PCS_Status}<br>
	BMS룸온도:${row.Temp1}<br>
	PCS룸온도:${row.Temp2}<br>
	BMS룸습도:${row.Humi1}<br>
	
	<h3>운전실적</h3>
	당일실적<br>
	발전량: ${row.D_PVOut}<br>
	충전량: ${row.D_ESSIn}<br>
	방전량: ${row.D_ESSOut}<br>
	
	당월실적<br>
	발전량: <br>
	충전량: <br>
	방전량: <br>
	
	<table style="border: 1px solid #ccc">
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="15%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">Gno</th>
				<th scope="col">Gname</th>
				<th scope="col">DT</th>
				<th scope="col">PMS_Alarm</th>
				<th scope="col">PMS_Status</th>
				<th scope="col">Temp1</th>
				<th scope="col">Temp2</th>
				<th scope="col">Humi1</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(list) > 0}">
					<c:forEach items="${list }" var="row">
						<tr>
							<td>${row.Gno}</td>
							<td>${row.Gname}</td>
							<td>${row.DT}</td>
							<td>${row.PMS_Alarm}</td>
							<td>${row.PMS_Status}</td>
							<td>${row.Temp1}</td>
							<td>${row.Temp2}</td>
							<td>${row.Humi1}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">조회된 결과가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>

