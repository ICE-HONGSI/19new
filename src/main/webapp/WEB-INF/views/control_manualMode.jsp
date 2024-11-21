<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<div class="controlDetailControlBox">
<div class="controlBoxTitleContainer controlDetailTitleContainer">
	<p class="controlBoxTitle controlDetailTitle">수동 운전 설정</p>
</div>
<div class="controlDetailBoxContentContainer manualMode">
	<!-- Box1 -->
	<div class="controlDetailManulBox">
		<div class="controlDetailSmallInfoBoxContent">
			PCS 출력
			<div class="controlContentFloatRight">
				<span class="controlData">50</span> <span class="controlUnit">kW</span>
			</div>
		</div>
		<hr class="dataLine">
		<div class="controlDetailSmallInfoBoxContent">
			충전 효율
			<div class="controlContentFloatRight">
				<span class="controlData">100</span> <span class="controlUnit">&nbsp;&nbsp;%</span>
			</div>
		</div>
		<hr class="dataLine">
		<div class="controlDetailSmallInfoBoxContent">
			SOC 상한치
			<div class="controlContentFloatRight">
				<span class="controlData">100</span> <span class="controlUnit">&nbsp;&nbsp;%</span>
			</div>
		</div>
		<div class="manualModeChargingButton">충전</div>
		<div class="manualModeOutPutModeButton" onclick="toggleButton()"
			id="whichmode">출력 모드</div>
	</div>
	<div class="verticalLine"></div>
	<!-- Box2 -->
	<div class="controlDetailManulBox">
		<div class="controlDetailSmallInfoBoxContent">
			PCS 출력
			<div class="controlContentFloatRight">
				<span class="controlData">50</span> <span class="controlUnit">kW</span>
			</div>
		</div>
		<hr class="dataLine">
		<div class="controlDetailSmallInfoBoxContent">
			SOC 하한치
			<div class="controlContentFloatRight">
				<span class="controlData">100</span> <span class="controlUnit">&nbsp;&nbsp;%</span>
			</div>
		</div>
		<div class="manualModedisChargingButton">방전</div>
	</div>

	<div class="verticalLine"></div>
	<!-- Box3 -->
	<div class="controlDetailManulBox">
		<div class="manualModedisStopButton">정지</div>
	</div>
</div>
</div>
<script>
	var toggle = 0; // if toggle 0; 충전 모드, else 효율 모드
	var mode = "";
	var img = "";
	var color;
	function toggleButton() {
		if (toggle == 0) {
			mode = "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp효율 모드";
			img = "url('./img/control/svg/output-mode2.svg')";
			color = "white";
			toggle++;
		}

		else {
			mode = "충전 모드";
			img = "url('./img/control/svg/output-mode.svg')";
			color = "black";
			toggle--;
		}

		document.getElementById("whichmode").innerHTML = mode;
		document.getElementById("whichmode").style.backgroundImage = img;
		document.getElementById("whichmode").style.color = color;

	}
</script>
