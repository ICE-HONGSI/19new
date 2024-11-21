<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="true"%>
<c:choose>
	<c:when test="${empty sessionScope.userLoginInfo}">
		<%
			response.sendRedirect("logout");
		%>
	</c:when>
</c:choose>
<c:import url="/top" />
<script src="./js/control.js"></script>
<div class="controlDetail">
	<div class="controlDetailRow">

		<!-- PMS 제어 -->
		<div class="controlDetailSmallInfoBox">
			<div class="controlBoxTitleContainer">
				<p class="controlBoxTitle">PMS 제어</p>
			</div>
			<div class="controlBoxContentContainer pmsControlContent">
				<button type="button"
					style="background: url(./img/control/svg/new-deactrun.svg) no-repeat left top;"
					onclick="openRunPopup()" id="controlRunButton"></button>
				<button type="button"
					style="background: url(./img/control/svg/new-deactstop.svg) no-repeat left top;"
					onclick="openStopPopup()" id="controlStopButton"></button>
			</div>
		</div>

		<!-- 장비 통신 상태 -->
		<div class="controlDetailSmallInfoBox">
			<div class="controlBoxTitleContainer">
				<p class="controlBoxTitle">장비 통신 상태</p>
			</div>
			<div class="controlBoxContentContainer equitmentCommunicationState">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit"></span>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">

						<c:choose>

							<c:when test="">
								<div class="controlCharging" style="padding: 0 45px;"></div>
							</c:when>
							<c:when test="">
								<div class="controlStop" style="padding: 0 45px;"></div>
							</c:when>
							<c:otherwise>
								<div class="controlStop" style="padding: 0 45px;"></div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<c:choose>

							<c:when test="">
								<div class="controlCharging"></div>
							</c:when>
							<c:when test="">
								<div class="controlCharging"></div>
							</c:when>
							<c:otherwise>
								<div class="controlStop"></div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit"></span>
					</div>
				</div>
			</div>
		</div>

		<!-- METER -->
		<div class="controlDetailSmallInfoBox">
			<div class="controlBoxTitleContainer">
				<p class="controlBoxTitle">METER</p>
			</div>
			<div class="controlBoxContentContainer">
				<div class="controlDetailSmallInfoBoxContent">


					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit"></span>
					</div>


				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<span class="controlData"><fmt:formatNumber value=""
								pattern=".0" /> </span> <span class="controlUnit"></span>
					</div>
				</div>
			</div>
		</div>


		<!-- PCS -->
		<div class="controlDetailSmallInfoBox">
			<div class="controlBoxTitleContainer">
				<p class="controlBoxTitle">PCS</p>
			</div>
			<div class="controlBoxContentContainer">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit"></span>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<c:choose>

							<c:when test="">
								<div class="controlCharging"></div>
							</c:when>
							<c:when test="">
								<div class="controlCharging"></div>
							</c:when>
							<c:otherwise>
								<div class="controlStop"></div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>

		<!-- BMS -->
		<div class="controlDetailSmallInfoBox">
			<div class="controlBoxTitleContainer">
				<p class="controlBoxTitle">BMS</p>
			</div>
			<div class="controlBoxContentContainer">
				<div class="controlDetailSmallInfoBoxContent">
					SOC
					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit"></span>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">
					상태
					<div class="controlContentFloatRight">
						<c:choose>

							<c:when test="">
								<div class="controlCharging" style="padding: 0 29px;"></div>
							</c:when>
							<c:when test="">
								<div class="controlCharging" style="padding: 0 29px;"></div>
							</c:when>
							<c:otherwise>
								<div class="controlStop" style="padding: 0 29px;"></div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit">&nbsp;</span>
					</div>
				</div>
				<hr class="dataLine">
				<div class="controlDetailSmallInfoBoxContent">

					<div class="controlContentFloatRight">
						<span class="controlData"></span> <span class="controlUnit">&nbsp;</span>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="controlDetailRow controlDetailRow2">
		<!-- Menu  -->
		<div class="controlDetailMenuBox">
			<a class="controlDetailMenuButton controlMenuSelected"
				id="normalControlButton" href="#">기본제어</a> <a
				class="controlDetailMenuButton controlMenuUnselected"
				id="operationSetting" href="#">운용설정</a> <a
				class="controlDetailMenuButton controlMenuUnselected" id="engineer"
				href="#">엔지니어</a>
		</div>

		<!-- Control Option -->
		<div class="controlDetailOptionButtonBox">
			<div class="controlBoxTitleContainer controlOptionTitle">
				<p class="controlBoxTitle">PCS 선택</p>
			</div>
			<select class="selectPCS" name="">
				<option value="">PCS</option>
				<option value="">PCS</option>
			</select>
			<div class="controlBoxTitleContainer controlOptionTitle">
				<p class="controlBoxTitle">동작모드</p>
			</div>
			<button type="button" class="modeButtonUnSelected"
				id="autoModeButton" onclick="openAutoPopup()">
				<div id="autoModeText">자동모드</div>
			</button>
			<button type="button" class="modeButtonUnselected"
				id="manualModeButton" onclick="openManualPopup()">
				<div id="manualModeText">수동모드</div>
			</button>
			<button type="button" id="resetButton" onclick="openPwModal()"></button>
		</div>
		<div class="controlDetailContainer">
			<!-- Control Detail -->

			<div class="controlDetailControlBox"></div>
		</div>
	</div>

</div>


</div>
<div class="pwModal">
	<div class="pwInput">
		<div class="pwContents">
			<div class="pwTitle">
				<span>관리자 비밀번호</span>
			</div>
			<%-- <form name="form1" id="form1">
				<!--  method="post" -->
				<div class="pwInputField">
					<input type="password" id="password" name="password"
						placeholder="비밀번호를 입력하세요." />
				</div>
				<div class="pwButtonSection">
					<button type="button" class="pwClose" onclick="closePwModal()">닫기</button>
					<button type="submit" class="pwConfirm" onclick="resetMode()"
						id="hello">확인</button>
				</div>
			</form> --%>
			<form:form commandName="form" action="control_url.do" metho="post">
				<!--  method="post" -->
				<div class="pwInputField">
					<input type="password" id="password" name="password"
						placeholder="비밀번호를 입력하세요." />
				</div>
				<div class="pwButtonSection">
					<button type="button" class="pwClose" onclick="closePwModal()">닫기</button>
					<button type="submit" class="pwConfirm">확인</button>
				</div>
			</form:form>
		</div>
	</div>
</div>




<script>
	var state;
	var setCookie = function(name, value) {
		var date = new Date();
		date.setTime(date.getTime() + 1000 * 60 * 60 * 24 * 30); //cookie 10분 지속
		document.cookie = name + '=' + value + ';expires=' + date.toUTCString()
				+ ';path=/';
	};

	var getCookie = function(name) {
		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return value ? value[2] : null;
	};

	function openRunPopup() {
		//$('.reportDetail').fadeOut(500);
		$('.controlRunPopup').fadeIn(500);
	}
	function closeRunPopup() {
		$('.controlRunPopup').fadeOut(500);
		// $('.reportDetail').fadeIn(500);

	}
	function openStopPopup() {
		$('.controlStopPopup').fadeIn(500);
	}
	function closeStopPopup() {
		$('.controlStopPopup').fadeOut(500);
		// $('.reportDetail').fadeIn(500);
	}

	function openAutoPopup() {
		$('.controlAutoPopup').fadeIn(500);
	}

	function closeAutoPopup() {
		$('.controlAutoPopup').fadeOut(500);
	}

	function openManualPopup() {
		$('.controlManualPopup').fadeIn(500);
	}

	function closeManualPopup() {
		$('.controlManualPopup').fadeOut(500);
	}

	function runMode(event) {

		event.preventDefault();
		$.ajax({
			url : 'control_run',
			type : 'POST',
			success : function(data) {
				var success = document.querySelector(".controlDetailRow");
				success.innerHTML = data;
				setCookie("state", 0);
				closeRunPopup();
			}
		})

	}

	function stopMode(event) {
		event.preventDefault();
		$.ajax({
			url : 'control_stop',
			type : 'POST',
			success : function(data) {
				var success = document.querySelector(".controlDetailRow");
				success.innerHTML = data;
				setCookie("state", 1);
				closeStopPopup();
			}
		});

	}

	function autoMode(event) {
		event.preventDefault();
		$
				.ajax({
					url : 'control_autoMode',
					type : 'POST',
					success : function(data) {
						var success = document
								.querySelector(".controlDetailControlBox");
						success.innerHTML = data;
						setCookie("state_mode", 0);
						closeAutoPopup();
						document.getElementById("autoModeButton").style.backgroundImage = "url(./img/control/svg/new-modeact.svg)";
						document.getElementById("manualModeButton").style.backgroundImage = "url(./img/control/svg/new-modedeact.svg)";
						document.getElementById("manualModeButton").style.color = "white";
						document.getElementById("autoModeButton").style.color = "black";
						document.getElementById("manualModeText").style.opacity = "0.85";
					}
				});
	}

	function manualMode(event) {
		event.preventDefault();
		$
				.ajax({
					url : 'control_manualMode',
					type : 'POST',
					success : function(data) {
						var success = document
								.querySelector(".controlDetailControlBox");
						success.innerHTML = data;
						setCookie("state_mode", 1);
						closeManualPopup();
						document.getElementById("manualModeButton").style.backgroundImage = "url(./img/control/svg/new-modeact.svg)";
						document.getElementById("autoModeButton").style.backgroundImage = "url(./img/control/svg/new-modedeact.svg)";
						document.getElementById("manualModeButton").style.color = "black";
						document.getElementById("autoModeButton").style.color = "white";
						document.getElementById("manualModeText").style.opacity = "0.6";
						document.getElementById("autoModeText").style.opacity = "0.85";

					}
				});

	}
</script>

<div class="controlRunPopup">
	<div class="runPopup">
		<form id="profitForm" onsubmit="return check();" name="profitForm"
			style="margin-inline-start: 1em; margin-block-start: 3em; margin: 0, auto; width: 600px"
			method="GET" action="/pms/reportUpdate">
			<div>
				<div class="popupImg">
					<img src="./img/controls/svg/run-icon.svg"></img>
				</div>
				<div class="popupFont">
					<p id='popupMessage1'>PMS 가동을 시작하시겠습니까?</p>
					<p id='popupMessage2'>확인버튼을 누르시면 자동모드로 가동됩니다.</p>
				</div>
			</div>

			<div class=popupButton>
				<input class="runSubmit"
					style="margin-right: 10px; background-image: url(./img/control/svg/cancel.svg)"
					onclick="closeRunPopup()" type="button" value=""> <input
					class="runSubmit" id="btn" type="button" onclick="runMode(event)"
					value="">
			</div>

		</form>
	</div>
</div>
<div class="controlStopPopup">
	<div class="runPopup">
		<form id="profitForm" onsubmit="return check();" name="profitForm"
			style="margin-inline-start: 1em; margin-block-start: 3em; margin: 0, auto; width: 600px"
			method="GET" action="/pms/reportUpdate">
			<div>
				<div class="popupImg">
					<img src="./img/control/svg/stop-icon.svg"></img>
				</div>
				<div class="popupFont">
					<p id='popupMessage1'>PMS 가동을 멈추시겠습니까?</p>
					<p id='popupMessage2'>확인버튼을 누르시면 시스템 가동을 멈추게 됩니다.</p>
				</div>
			</div>

			<div class=popupButton>
				<input class="runSubmit"
					style="margin-right: 10px; background-image: url(./img/control/svg/cancel.svg)"
					onclick="closeStopPopup()" type="button" value=""> <input
					class="runSubmit" id="btn" type="button" onclick="stopMode(event)"
					value="">
			</div>

		</form>
	</div>
</div>
<div class="controlAutoPopup">
	<div class="runPopup">
		<form id="profitForm" onsubmit="return check();" name="profitForm"
			style="margin-inline-start: 1em; margin-block-start: 3em; margin: 0, auto; width: 600px"
			method="GET" action="/pms/reportUpdate">
			<div>
				<div class="popupImg">
					<img src="./img/control/svg/stop-icon.svg"></img>
				</div>
				<div class="popupFont">
					<p id='popupMessage1'>자동 모드로 전환하시겠습니까?</p>
				</div>
			</div>

			<div class=popupButton>
				<input class="runSubmit"
					style="margin-right: 10px; background-image: url(./img/control/svg/cancel.svg)"
					onclick="closeAutoPopup()" type="button" value=""> <input
					class="runSubmit" id="btn" type="button" onclick="autoMode(event)"
					value="">
			</div>

		</form>
	</div>
</div>
<div class="controlManualPopup">
	<div class="runPopup">
		<form id="profitForm" onsubmit="return check();" name="profitForm"
			style="margin-inline-start: 1em; margin-block-start: 3em; margin: 0, auto; width: 600px"
			method="GET" action="/pms/reportUpdate">
			<div>
				<div class="popupImg">
					<img src="./img/control/svg/stop-icon.svg"></img>
				</div>
				<div class="popupFont">
					<p id='popupMessage1'>수동 모드로 전환하시겠습니까?</p>
				</div>
			</div>

			<div class=popupButton>
				<input class="runSubmit"
					style="margin-right: 10px; background-image: url(./img/control/svg/cancel.svg)"
					onclick="closeManualPopup()" type="button" value=""> <input
					class="runSubmit" id="btn"cs type="button"
					onclick="manualMode(event)" value="">
			</div>

		</form>
	</div>
</div>

<c:import url="/bottom"/>