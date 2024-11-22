<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<div class="operRightEvent">
	<div class="operRightTitle">
		<span>이벤트 발생 내역</span>
	</div>
	<div class="operEventWrapper">
		<div class="eventSearch">
			<form name="form1"
				style="font-size: 20px; width: 100%; line-height: 40px; float: left;"
				method="POST" action="/pms/oper_event_ajax">
				<div class="searchDate" onclick="dateDiff();">
					<span style="font-size: 20px; line-height: 40px; float: left;">조회기간</span>
					<input class="yearSearch" id="dateFrom" name="dateFrom" type="date"
						value=${dateFrom} > <span
						style="font-size: 20px; line-height: 40px; float: left;">부터</span>
					<input class="yearSearch" id="dateTo" name="dateTo" type="date"
						value=${dateTo}>
						<span style="font-size: 20px; line-height: 40px; float: left;">까지
				</div>
				<div class="buttonSection">
					<input class="rightButton" type="button" onclick="excelEvent();"
						style="background: url('./img/oper/svg/eventlist/new-excel.svg'); width: 133px; border-radius: 10px;" />
					<input class="rightButton" type="button" name="Submit" alt="Submit"
						   onclick="searchEvent(event);"
						   style="background: url('./img/oper/svg/eventlist/new-search.svg'); width: 103px; border-radius: 10px;" />
				</div>
			</form>
		</div>
		<table class="operEventTable">
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
				</c:choose>
			</tbody>
		</table>
	</div>
</div>
<script>
	var WarnedValid = 0; //Stop alerting repeatedly
	var WarnedLate = 0; //Stop alerting repeatedly

	function excelEvent() {
		var dateFrom = $("#dateFrom").val();
		var dateTo = $("#dateTo").val();
		var link = "oper_event_excel?dateFrom=" + dateFrom + "&dateTo="
				+ dateTo;
		console.log(link);
		location.href = link;
	}

	function searchEvent(event) {
		WarnedValid = 0;
		WarnedLate = 0;
		event.preventDefault();

		if (dateDiff()) {
			$.ajax({
				url : 'oper_event_ajax',
				type : 'POST',
				data : $('form').serialize(),
				success : function(data) {
					$('.operEventTable').html(data);
				}
			});
		} else {
		}
	}
	// 날짜 초기값 설정
	document.getElementById('dateFrom').value = new Date().toISOString()
			.substring(0, 8)
			+ "01";
	document.getElementById('dateTo').value = new Date().toISOString()
			.substring(0, 10);

	// 끝 날짜가 시작날짜보다 늦으면 True, 아니면 False 반환
	function dateDiff() {
		//console.log(WarnedLate+","+WarnedValid);
		var _date1 = document.getElementById('dateFrom').value;
		var _date2 = document.getElementById('dateTo').value;
		var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
		var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);
		//console.log(diffDate_1+diffDate_2);
		if ((diffDate_1 == "Invalid Date" || diffDate_2 == "Invalid Date")
				&& WarnedValid == 0) {
			alert("날짜값이 잘못되었습니다.");
			WarnedValid = 1;
			return false;
		}

		diffDate_1 = new Date(diffDate_1.getFullYear(),
				diffDate_1.getMonth() + 1, diffDate_1.getDate());
		diffDate_2 = new Date(diffDate_2.getFullYear(),
				diffDate_2.getMonth() + 1, diffDate_2.getDate());
		//console.log(diffDate_1+diffDate_2);
		var diff = diffDate_2.getTime() - diffDate_1.getTime();
		diff = Math.ceil(diff / (1000 * 3600 * 24));
		//console.log("diff:"+diff);
		if (diff < 0 && WarnedLate == 0) {
			alert("시작 날짜는 끝 날짜보다 늦을 수 없습니다.");
			WarnedLate = 1;
			return false;
		} else if (diff < 0 && WarnedLate == 1) {
			return false;
		} else if (diff.toString() == "NaN") {
			return false;
		} else {
			WarnedValid = 0;
			WarnedLate = 0;
			return true;
		}
	}
</script>
