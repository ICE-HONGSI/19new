<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>


<div class="controlDetailRow">

	<!-- PMS 제어 -->
	<div class="controlDetailSmallInfoBox">
		<div class="controlBoxTitleContainer">
			<p class="controlBoxTitle">PMS 제어</p>
		</div>
		<div class="controlBoxContentContainer pmsControlContent">
			<div
				style="background: url(./img/control/new_deactrun.png) no-repeat left top;"
				onclick="openRunPopup()" id="controlRunButton"></div>
			<div
				style="background: url(./img/control/new_stop2.png) no-repeat left top;"
				onclick="openStopPopup()" id="controlStopButton"></div>
		</div>
	</div>

	<!-- 장비 통신 상태 -->
	<div class="controlDetailSmallInfoBox">
		<div class="controlBoxTitleContainer">
			<p class="controlBoxTitle">장비 통신 상태</p>
		</div>
		<div class="controlBoxContentContainer equitmentCommunicationState">
			<div class="controlDetailSmallInfoBoxContent">
				설치 용량
				<div style="background-color: red" class="controlDot"></div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				PMS 통신
				<div style="background-color: red" class="controlDot"></div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				PCS 상태
				<div style="background-color: red" class="controlDot"></div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				BMS 룸 온도
				<div style="background-color: red" class="controlDot"></div>
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

				태양광 발전량
				<div class="controlContentFloatRight">
					<span class="controlData">0</span> <span class="controlUnit">kW</span>
				</div>


			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				ESS 충방전량
				<div class="controlContentFloatRight">
					<span class="controlData">0</span> <span class="controlUnit">kW</span>
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
				출력값
				<div class="controlContentFloatRight">
					<span class="controlData">0</span> <span class="controlUnit">kW</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				상태
				<div class="controlContentFloatRight">
					<div class="controlStop" style="padding: 0 45px;">정지</div>
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
					<span class="controlData">0</span> <span class="controlUnit">&nbsp;%</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				상태
				<div class="controlContentFloatRight">
					<div class="controlStop" style="padding: 0 42px;">정지</div>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				전압
				<div class="controlContentFloatRight">
					<span class="controlData">0</span> <span class="controlUnit">&nbsp;&nbsp;V</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				전류
				<div class="controlContentFloatRight">
					<span class="controlData">0</span> <span class="controlUnit">&nbsp;&nbsp;A</span>
				</div>
			</div>
		</div>
	</div>
</div>

