<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>

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
			<c:forEach items="${list}" var="row" varStatus="status">
				<tr onclick="PopupEmpInfo(this)">
					<td>${fn:length(list)-status.index }</td>
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