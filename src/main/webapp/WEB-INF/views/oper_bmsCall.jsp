<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="./js/operFancy.js"></script>

<c:choose>
	<c:when test="${empty sessionScope.userLoginInfo}">
		<%
			response.sendRedirect("logout");
		%>
	</c:when>
</c:choose>

<div class="operRightBMS">
	<div class="operRightTitle">
		<span>RACK BMS</span>
	</div>
	<div class="operBMSHead">
		<table class="operBMSTable">
			<thead>
				<tr>
					<th id="no"><span>번호</span></th>
					<th id="date"><span>수신 시간</span></th>
					<th id="v"><span>전압[V]</span></th>
					<th id="a"><span>전류[A]</span></th>
					<th id="soc"><span>SOC[%]</span></th>
					<th id="c"><span>평균온도[&deg;C]</span></th>
					<th id="av"><span>평균전압[V]</span></th>
					<th id="maxv"><span>최고전압[V]</span></th>
					<th id="minv"><span>최저전압[V]</span></th>
					<th id="alarm"><span>알람</span></th>
					<th id="state"><span>상태정보</span></th>
					<th id="dinfo"><span>상세정보</span></th>
					<th id="trayinfo"><span>트레이정보</span></th>
				</tr>
			</thead>
		</table>
	</div>
<div class="operBMSWrapper">
	<table class="operBMSTable">
	<tbody>
		<c:choose>
			<c:when test="${fn:length(list) > 0}">
				<c:forEach items="${list}" var="row">
					<input type="hidden" class="click">
					<tr>
						<td id="no">${row.Rno }</td>
						<td id="date">${row.DT }</td>
						<td id="v">${row.DCV }</td>
						<td id="a">${row.DCC }</td>
						<td id="soc">${row.SOC }</td>
						<td id="c">${row.AvrCLT }</td>
						<td id="av">${row.AvrCLV }</td>
						<td id="maxv">${row.MaxCLV }</td>
						<td id="minv">${row.MinCLV }</td>
						<td style="display: none; position: absolute;">${row.BatOper}</td>
						<td style="display: none; position: absolute;">${row.BatWarn}</td>
						<td style="display: none; position: absolute;">${row.BatPrtFault}</td>
						<td style="display: none; position: absolute;">${row.BMS_Alarm}</td>
						<c:choose>
							<c:when test="${row.BMS_Alarm ==0 }">
								<td id="alarm"><img class="alarmImg"
									src="./img/oper/svg/bms/alarm-act.svg" /></td>
							</c:when>
							<c:when test="${row.BMS_Alarm ==1 }">
								<td id="alarm"><img class="alarmImg"
									src="./img/oper/svg/bms/alarm-redact.svg" /></td>
							</c:when>
							<c:otherwise>
								<td id="alarm"><img class="alarmImg"
									src="./img/oper/svg/bms/orange.svg" /></td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${row.BMS_Alarm ==0 }">
								<td id="state">대기중</td>
							</c:when>
							<c:when test="${row.BMS_Alarm ==1 }">
								<td id="state">충전중</td>
							</c:when>
							<c:otherwise>
								<td id="state">방전중</td>
							</c:otherwise>
						</c:choose>
						<td id="dinfo">
							<button style="background: url(./img/oper/svg/bms/new-detail.svg) no-repeat left top; background-size: 100% auto;" class="click">
							</button>
						</td>
						<td id="trayinfo">
							<button style="background: url(./img/oper/svg/bms/new-detail.svg) no-repeat left top; background-size: 100% auto;"
							  onclick="openTray(${row.Rno},'${row.DT}')" class="clickTray">
							 </button>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="11">조회된 결과가 없습니다!!</td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
</div>

<!-- -------------------------------------Detail Info ----------------------------------------- -->

<div class="detailModal">
	<div class="detailInfo">
		<div class="detailTitle">
			<p class="w3-input w3-border"
				style="font-size: 20px; font-weight: bold; opacity: 0.8; line-height: 40px; color: #ffffff;"
				id="emp_info_no" readonly>
		</div>
		<div class="detail_box">
			<div class="detailDate">
				<span>최근 계측 일시</span> <span class="w3-input w3-border"
					style="height: 50px" id="emp_info_date" readonly></span>
			</div>
			<table class="detailTable">
				<thead>
					<tr>
						<th class="detailTableWidth"><span>항목</span></th>
						<th class="detailTableWidth"><span>값</span></th>
						<th class="detailTableWidth"><span>항목</span></th>
						<th class="detailTableWidth"><span>값</span></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td id="detailv">전압(V)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_v"readonly"></td>
						<td id="detailv">전류(A)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_a"readonly"></td>
					</tr>
					<tr>
						<td id="detailv">SOC(%)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_soc"
							readonly></td>
						<td id="detailv">평균온도(&deg;C)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_c"readonly"></td>
					</tr>
					<tr>
						<td id="detailv">평균전압(V)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_av"readonly"></td>
						<td id="detailv">최고전압(V)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_maxv"readonly"></td>
					</tr>
					<tr>
						<td id="detailv">최저전압(V)</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_minv"readonly"></td>
						<td id="detailv">상태</td>
						<td style="color: #55e0ae; font-size: 20px;" id="emp_info_state"readonly"></td>
					</tr>
				</tbody>
			</table>
			<table class="operPCSSubtable">
				<tbody>
					<tr>
						<th class="bms_left_title bottom_border" rowspan="2"><span>OPER</span></th>
						<td><span>MAIN+S/W</span><span
							style="padding-left: 15px; padding-right: 15px;"
							id="emp_info_1-1"readonly"></span></td>
						<td><img id="emp_info_1-2"
							src="" /><span>Batt Fault</span></td>
						<td colspan="3"><span>Batt Status</span><span
							id="emp_info_1-3"readonly"></span></td>
					</tr>
					<tr class='bottom_border'>
						<td><span>MAIN- S/W</span><span
							style="padding-left: 15px; padding-right: 15px;"
							id="emp_info_1-4"readonly"></span></td>
						<td colspan="4"><img id="emp_info_1-5"
							src="" /><span>Batt Prot
								Fault</span></td>
					</tr>
					<tr>
						<th class="bms_left_title bottom_border" rowspan="3"><span>WARN</span></th>
						<td><img id="emp_info_2-1" src="" /><span>Cell
								OV</span></td>
						<td><img id="emp_info_2-4"
							src="" /><span>Cell OT</span></td>
						<td><img id="emp_info_2-7"
							src="" /><span>Batt OV</span></td>
						<td><img id="emp_info_2-9" src="" /><span>Batt
								OCC</span></td>
					</tr>
					<tr>
						<td><img id="emp_info_2-2" src="" /><span>Cell
								UV</span></td>
						<td><img id="emp_info_2-5"
							src="" /><span>Cell UT</span></td>
						<td><img id="emp_info_2-8"
							src="" /><span>Batt UV</span></td>
						<td><img id="emp_info_2-10"
							src="" /><span>Batt ODC</span></td>
					</tr>
					<tr class="bottom_border">
						<td><img id="emp_info_2-3"
							src="" /><span>Cell DEV</span></td>
						<td colspan="3"><img id="emp_info_2-6"
							src="" /><span>Temp DEV</span></td>
					</tr>
					<tr>
						<th class="bms_left_title bottom_border" rowspan="3"><span>FAULT</span></th>
						<td><img id="emp_info_3-1" src="" /><span>Cell
								OV</span></td>
						<td><img id="emp_info_3-4"
							src="" /><span>Cell OT</span></td>
						<td><img id="emp_info_3-7"
							src="" /><span>Batt OV</span></td>
						<td><img id="emp_info_3-9" src="" /><span>Batt
								OCC</span></td>
					</tr>
					<tr>
						<td><img id="emp_info_3-2" src="" /><span>Cell
								UV</span></td>
						<td><img id="emp_info_3-5"
							src="" /><span>Cell UT</span></td>
						<td><img id="emp_info_3-8"
							src="" /><span>Batt UV</span></td>
						<td><img id="emp_info_3-10"
							src="" /><span>Batt ODC</span></td>
					</tr>
					<tr class="bottom_border">
						<td><img id="emp_info_3-3"
							src="" /><span>Cell DEV</span></td>
						<td colspan="3"><img id="emp_info_3-6"
							src="" /><span>Temp DEV</span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<a class="closeDetailInfo" onclick="closeDetail()" href="#"><img
			src="./img/oper/svg/bms/closemodal.svg" /></a>
	</div>
</div>

<!-- -------------------------------------Tray Info ----------------------------------------- -->

<div class="trayModal">

</div>
<form class="trayAjaxData">
	<input type="hidden" value="0" class="Rnotray" name="Rnotray"> 
	<input type="hidden" value="" class="DTtray" name="DTtray">
</form>

<script>
	$('.DTtray').val();
	function Bms_Oper(type, alarm) {//BMS 상세정보 페이지의 비트알람 'OPER'부분

		var alarmBit16 = "";
		var BatOper = "";
		var Status = "";
		var message;
		var bitdata = dec2bin(alarm);
		var length = bitdata.length;
		for (var i = 0; i < 16 - length; i++) {
			alarmBit16 += "0";
		}
		alarmBit16 += bitdata;

		if (type == 0) {//MAIN+S/W
			Status = alarmBit16[14];
			if(Status == "0") message = "ON"; else message = "OFF";

		} else if (type == 1) {//Batt Fault
			Status = alarmBit16[9];
			if(Status == "0") message = alarm_diact(); else message = alarm_act();

		} else if (type == 2) {//Batt Status
			Status = alarmBit16[6] + alarmBit16[7];
			
			if (Status == "00")
				message = "StandBy";
			else if (Status == "01" || Status == "10")
				message = "Charging";
			else
				message = "DisCharging";

		} else if (type == 3) {//MAIN-S/W
			Status = alarmBit16[13];
			if(Status == "0") message = "ON"; else message = "OFF";

		} else if (type == 4) {//Batt Prot Fault
			Status = alarmBit16[8];
			if(Status == "0") message = alarm_diact(); else message = alarm_act();

		}
		
		return message;
	}
	
	function Bms_Warn(type, alarm) {//BMS 상세정보 페이지의 비트알람 'WARN'부분 

		var alarmBit16 = "";
		var BatOper = "";
		var Status = "";
		var bitdata = dec2bin(alarm);
		var length = bitdata.length;
		for (var i = 0; i < 16 - length; i++) {
			alarmBit16 += "0";
		}
		alarmBit16 += bitdata;
		
		if (type == 0) {
			Status = alarmBit16[15];
		} else if (type == 1) {
			Status = alarmBit16[14];
		} else if (type == 2) {
			Status = alarmBit16[13];
		} else if (type == 3) {
			Status = alarmBit16[12];
		} else if (type == 4) {
			Status = alarmBit16[11];
		} else if (type == 5) {
			Status = alarmBit16[10];
		} else if (type == 6) {
			Status = alarmBit16[9];
		} else if (type == 7) {
			Status = alarmBit16[8];
		} else if (type == 8) {
			Status = alarmBit16[7];
		} else if (type == 9) {
			Status = alarmBit16[6];
		}
		
		if (Status == "0") return alarm_diact(); else return alarm_orange();
	}
	
	function Bms_Fault(type, alarm) {//BMS 상세정보 페이지의 비트알람 'FAULT'부분

		var alarmBit16 = "";
		var BatOper = "";
		var Status = "";
		var bitdata = dec2bin(alarm);
		var length = bitdata.length;
		for (var i = 0; i < 16 - length; i++) {
			alarmBit16 += "0";
		}
		alarmBit16 += bitdata;

		if (type == 0) {
			Status = alarmBit16[15];
		} else if (type == 1) {
			Status = alarmBit16[14];
		} else if (type == 2) {
			Status = alarmBit16[13];
		} else if (type == 3) {
			Status = alarmBit16[12];
		} else if (type == 4) {
			Status = alarmBit16[11];
		} else if (type == 5) {
			Status = alarmBit16[10];
		} else if (type == 6) {
			Status = alarmBit16[9];
		} else if (type == 7) {
			Status = alarmBit16[8];
		} else if (type == 8) {
			Status = alarmBit16[7];	
		} else if (type == 9) {
			Status = alarmBit16[6];
		}
		
		if (Status == "0") return alarm_diact(); else return alarm_redact();
	}

	var BmsImgSrc = "./img/oper/svg/bms/"
	
	function dec2bin(dec) {//2bit로 변환하는 함수
		return (dec >>> 0).toString(2);
	}
	function alarm_act(){
		return BmsImgSrc + "alarm-act.svg"
	}
	function alarm_diact(){
		return BmsImgSrc + "alarm-diact.svg"
	}
	function alarm_redact(){
		return BmsImgSrc + "alarm-redact.svg"
	}
	function alarm_orange(){
		return BmsImgSrc + "orange.svg"
	}

	$(".click").click(
		function() {
			$('.detailModal').fadeIn(400);
			var str = ""
			var tdArr = new Array(); // 배열 선언
			var checkBtn = $(this);

			var tr = checkBtn.parent().parent();
			var td = tr.children();

			td.each(function(i) {
				tdArr.push(td.eq(i).text());
			});
			var idArr = new Array();
			var str2 = "emp_info_no,emp_info_date,emp_info_v,emp_info_a,emp_info_soc,emp_info_c,emp_info_av,emp_info_maxv,emp_info_minv,emp_info_1-1,emp_info_1-2,emp_info_1-3,emp_info_1-4,emp_info_1-5,emp_info_2-1,emp_info_2-2,emp_info_2-3,emp_info_2-4,emp_info_2-5,emp_info_2-6,emp_info_2-7,emp_info_2-8,emp_info_2-9,emp_info_2-10,emp_info_3-1,emp_info_3-2,emp_info_3-3,emp_info_3-4,emp_info_3-5,emp_info_3-6,emp_info_3-7,emp_info_3-8,emp_info_3-9,emp_info_3-10,emp_info_state,";
			idArr = str2.split(',');
			//console.log("배열에 담긴 값 : "+tdArr.length+" "+ tdArr + " " + idArr.length + typeof (idArr));
			for(i=0;i<9;i++){
				document.getElementById(idArr[i]).innerHTML = tdArr[i];
			}
			document.getElementById(idArr[9]).innerHTML = Bms_Oper(0,tdArr[9]);
			document.getElementById(idArr[10]).src = Bms_Oper(1,tdArr[9]);
			document.getElementById(idArr[11]).innerHTML = Bms_Oper(2,tdArr[10]);
			document.getElementById(idArr[12]).innerHTML = Bms_Oper(3,tdArr[10]);
			document.getElementById(idArr[13]).src = Bms_Oper(4,tdArr[10]);
			for(i=0;i<10;i++){
				document.getElementById(idArr[i+14]).src = Bms_Warn(i,tdArr[10]);
			}
			for(i=0;i<10;i++){
				document.getElementById(idArr[i+24]).src = Bms_Fault(i,tdArr[11]);
			}
			var state;
			if(tdArr[12]==0){
				state = "대기중";
			}else if(tdArr[12]==1){
				state = "충전중";
			}else{
				state = "방전중";
			}
			document.getElementById(idArr[34]).innerHTML = state;
			document.getElementById(idArr[0]).innerHTML = "RACK NO."+tdArr[0];
			document.getElementById("trayTitleText").innerHTML = "RACK NO."+tdArr[0];
		}
	);
	
//------------------------------------------------------- 트레이 차트
	var Rnotray = 0; // 트레이 상세보기를 클릭 Function에 쓰일 변수
	var DTtray = 0;
	var arr = new Array(); //차트에 쓸 어레이
	var _Tno = 0; 
	var Tno = 0;
	
	function chartOn() {
		event.preventDefault();
					
		$('.DTtray').val(DTtray);
		$('.Rnotray').val(Rnotray);
		//console.log("serial:"+$('.trayAjaxData').serialize());
		
		$.ajax({
			url : 'oper_bmsTray_ajax',
			type : 'POST',
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data : $('.trayAjaxData').serialize(),
			success : function(data) {
				$('.trayModal').html(data);
			}
		})
	}
	chartOn();

	function closeDetail() {
		$('.detailModal').fadeOut(400);
	}
	
	function openTray(Rno, DT) {
		$('.trayModal').fadeIn(400);
		Tno=0;
		$('.trayButton').removeAttr("id")
		$('.tray01').attr('id', 'trayAct');
		Rnotray = Rno;
		DTtray = DT;
		Tno=0;
		console.log("openTray! : " + DTtray);
		chartOn(event,$('.tray01')[0]);
	}
	
	function closeTray() {
		$('.trayModal').fadeOut(400);
	}
</script>
