<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<c:choose>
	<c:when test="${empty sessionScope.userLoginInfo}">
		<%
			response.sendRedirect("logout");
		%>
	</c:when>
</c:choose>
<c:import url="/top" />

<script src="./js/oper.js?v=0610"></script>
<script>
	function makePcsList() {

		var pcsCountStr = '${pcsCountStr}';
		var listId = "";
		var listStr = "";

		if (pcsCountStr != "") {
			var eachCount = pcsCountStr.split("/");
			var i = 0;
			while (i < eachCount.length - 1) {
				listId = "pcsCall0";
				listId += eachCount[i];
				listStr += "<li>";
				listStr += "<a href='javascript:;' onclick='pcsPage("
						+ eachCount[i] + ")' class='pcsCall" + eachCount[i]
						+ "'>PCS-0" + eachCount[i] + "</a>";
				listStr += "</li>";
				i++;
			}
			pcsDetail.innerHTML = listStr;
		} else {
			var ul = document.getElementById('pcsId');
			ul.onclick = function(event) {
				alert("PCS 계측정보가 없습니다.");
			}
		}
	}//end of makePcsList

	function pcsPage(num) {
		var id = "pcsCall" + num;
		//var form = document.createElement("form");
		$(".operRight").load("./oper_pcsCall01?pno=" + num);
		// alert(num);
		$('#pcsDetail li a').removeAttr("id")
		$("." + id).attr('id', 'pcsSelected');
	}

</script>
<div class="operDetail">
	<div class="operLeft">
		<ul>
			<li class="bms"><a href='javascript:;' id="bmsCall">BMS 계측 정보</a></li>
			<li class="pcs" id="pcsId"><a href='javascript:;' id="pcsCall">PCS 계측 경보</a></li>
			<ul id="pcsDetail">
			</ul>
			<ul id="metaDetail">
				<li><a href='javascript:;' class="metaCall01">태양광</a></li>
				<li><a href='javascript:;' class="metaCall02">ESS</a></li>
			</ul>
			<li class="system"><a href='javascript:;' id="systemInfo">시스템 정보</a></li>
			<li class="event"><a href='javascript:;' id="eventList">이벤트 발생 내역</a></li>
		</ul>
	</div>
	<div class="operRight"></div>
	<!--operRight-->
</div>
<!--operDetail-->
<script>
	makePcsList();
</script>
<c:import url="/bottom" />