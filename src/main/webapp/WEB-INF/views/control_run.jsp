<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true"%>

<div class="controlDetailRow">

	<!-- PMS 제어 -->
	<div class="controlDetailSmallInfoBox">
		<div class="controlBoxTitleContainer">
			<p class="controlBoxTitle">PMS 제어</p>
		</div>
		<div class="controlBoxContentContainer pmsControlContent">
			<button type="button"
				style="background: url(./img/control/svg/new-run2.svg) no-repeat left top;"
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
				설치 용량
				<div class="controlContentFloatRight">
					<span class="controlData">${basic[0].BatSize}</span> <span
						class="controlUnit">kW</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				PMS 통신
				<div class="controlContentFloatRight">

					<c:choose>

						<c:when test="${list[0].PCS_Alarm==0 }">
							<div class="controlCharging" style="padding: 0 45px;">정상</div>
						</c:when>
						<c:when test="${list[0].PCS_Alarm==1 }">
							<div class="controlStop" style="padding: 0 45px;">이상</div>
						</c:when>
						<c:otherwise>
							<div class="controlStop" style="padding: 0 45px;">대기</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				PCS 상태
				<div class="controlContentFloatRight">
					<c:choose>

						<c:when test="${list[0].PCS_Status==0 }">
							<div class="controlCharging">충전중</div>
						</c:when>
						<c:when test="${list[0].PCS_Status==1 }">
							<div class="controlCharging">방전중</div>
						</c:when>
						<c:otherwise>
							<div class="controlStop">대기중</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				BMS 룸 온도
				<div class="controlContentFloatRight">
					<span class="controlData">${list[0].Temp1}</span> <span
						class="controlUnit">kW</span>
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

				태양광 발전량
				<div class="controlContentFloatRight">
					<span class="controlData">${list[0].R_PVOut}</span> <span
						class="controlUnit">kW</span>
				</div>


			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				ESS 충방전량
				<div class="controlContentFloatRight">
					<span class="controlData"><fmt:formatNumber
							value="${list[0].R_ESSIn+list[0].R_ESSOut}" pattern=".0" /> </span> <span
						class="controlUnit">kW</span>
				</div>
			</div>
		</div>
	</div>
	<script>
	
	</script>

	<!-- PCS -->
	<div class="controlDetailSmallInfoBox">
		<div class="controlBoxTitleContainer">
			<p class="controlBoxTitle">PCS</p>
		</div>
		<div class="controlBoxContentContainer">
			<div class="controlDetailSmallInfoBoxContent">
				출력값
				<div class="controlContentFloatRight">
					<span class="controlData">${list[0].R_PCSPower}</span> <span
						class="controlUnit">kW</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				상태
				<div class="controlContentFloatRight">
					<c:choose>

						<c:when test="${list[0].PCS_Status==0 }">
							<div class="controlCharging">충전중</div>
						</c:when>
						<c:when test="${list[0].PCS_Status==1 }">
							<div class="controlCharging">방전중</div>
						</c:when>
						<c:otherwise>
							<div class="controlStop">대기중</div>
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
					<span class="controlData">${list[0].R_SOC}</span> <span
						class="controlUnit">%</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				상태
				<div class="controlContentFloatRight">
					<c:choose>

						<c:when test="${list[0].BMS_Status==0 }">
							<div class="controlCharging" style="padding: 0 29px;">충전중</div>
						</c:when>
						<c:when test="${list[0].BMS_Status==1 }">
							<div class="controlCharging" style="padding: 0 29px;">방전중</div>
						</c:when>
						<c:otherwise>
							<div class="controlStop" style="padding: 0 29px;">대기중</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				전압
				<div class="controlContentFloatRight">
					<span class="controlData">100</span> <span class="controlUnit">&nbsp;V</span>
				</div>
			</div>
			<hr class="dataLine">
			<div class="controlDetailSmallInfoBoxContent">
				전류
				<div class="controlContentFloatRight">
					<span class="controlData">100</span> <span class="controlUnit">&nbsp;A</span>
				</div>
			</div>
		</div>
	</div>
</div>
