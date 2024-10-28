<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:choose>
	<c:when test="${empty sessionScope.userLoginInfo}">
		<%
			response.sendRedirect("logout");
		%>
	</c:when>
</c:choose>

<script language="JavaScript" type="text/JavaScript">
	var pcsAlarm = '${pcsAlarm}';
	
	var color="";
	var colorStr="";
	
	if (pcsAlarm == 0) {
		color="#68D168";
		colorStr="충전중";
	} else if (pcsAlarm == 1) {
		color="#e9ce08";
		colorStr="방전중";
	} else if (pcsAlarm == 2) {
		color="#787878";
		colorStr="대기중";
	}

	document.getElementById('pcsAlarmBox').style.backgroundColor = color;
	document.getElementById('pcsAlarmBox').innerHTML = colorStr;
	
	var pcs_mode = '${mode}';
	var pcs_cmode = '${c_mode}';
	var pcs_status = '${status}';

	if (pcs_mode == 0) {
		pcs_mode = "NONE";
	} else if (pcs_mode == 1) {
		pcs_mode = "START";
	} else if (pcs_mode == 2) {
		pcs_mode = "STOP";
	} else if (pcs_mode == 3) {
		pcs_mode = "RUN";
	} else if (pcs_mode == 4) {
		pcs_mode = "PAUSE";
	} else if (pcs_mode == 5) {
		pcs_mode = "RESET";
	} else if (pcs_mode == 6) {
		pcs_mode = "FACTORY";
	} else if (pcs_mode == 7) {
		pcs_mode = "CVCF";
	} else if (pcs_mode == 8) {
		pcs_mode = "START_DC";
	} else if (pcs_mode == 9) {
		pcs_mode = "START_AC";
	} else if (pcs_mode == 10) {
		pcs_mode = "STOP_DC";
	} else if (pcs_mode == 11) {
		pcs_mode = "STOP_AC";
	}
	document.getElementById('pcs_mode').innerHTML = pcs_mode;

	if (pcs_status == 0) {
		pcs_status = "INIT";
	} else if (pcs_status == 1) {
		pcs_status = "POWER_OFF";
	} else if (pcs_status == 2) {
		pcs_status = "POWER_ON";
	} else if (pcs_status == 3) {
		pcs_status = "READY";
	} else if (pcs_status == 4) {
		pcs_status = "RUN";
	} else if (pcs_status == 5) {
		pcs_status = "FAULT";
	} else if (pcs_status == 6) {
		pcs_status = "FACTORY";
	} else if (pcs_status == 7) {
		pcs_status = "POWERON_DC";
	} else if (pcs_status == 8) {
		pcs_status = "POWERON_AC";
	} else if (pcs_status == 9) {
		pcs_status = "POWEROFF_DC";
	} else if (pcs_status == 10) {
		pcs_status = "POWEROFF_AC";
	}

	document.getElementById('pcs_status').innerHTML = pcs_status;

	if (pcs_cmode == 0) {
		pcs_cmode = "CP";
	} else if (pcs_cmode == 1) {
		pcs_cmode = "CV";
	} else if (pcs_cmode == 2) {
		pcs_cmode = "CC";
	} else if (pcs_cmode == 3) {
		pcs_cmode = "CVCF";
	}

	document.getElementById('pcs_cmode').innerHTML = pcs_cmode;

	function do_table(alarm) {
		var alarmBit16 = "";
		var status = "";
		var bitdata = dec2bin(alarm);
		var length = bitdata.length;
		for (var i = 0; i < 16 - length; i++) {
			alarmBit16 += "0";
		}
		alarmBit16 += bitdata;

		//alert(alarmBit16);
		var index = 0;
		var bitIdx = 16;
		for (var i = 0; i < 16; i++) {
			var doId = "do";
			doId = doId.concat(index);
			bitIdx--;
			status = alarmBit16[bitIdx];
			//alert(status);
			if (i == 0 || i == 3 || i == 6 || i == 10 || i == 12 || i == 13)
				continue;
			if (i == 9) {
				//alert(unitId);
				if (status == "0")
					document.getElementById(doId).src = "./img/oper/pcs/alarm_diact.png";
				else
					document.getElementById(doId).src = "./img/oper/pcs/alarm_redact.png";

				index += 1;

			} else {
				//alert(unitId);
				if (status == "0")
					document.getElementById(doId).src = "./img/oper/pcs/alarm_diact.png";
				else
					document.getElementById(doId).src = "./img/oper/pcs/alarm_act.png";
				index += 1;
			}
		}
	}

	function di_table(alarm) {
		var alarmBit16 = "";
		var status = "";
		var bitdata = dec2bin(alarm);
		var length = bitdata.length;
		for (var i = 0; i < 16 - length; i++) {
			alarmBit16 += "0";
		}
		alarmBit16 += bitdata;

		var index = 1;
		var bitIdx = 16;
		for (var i = 0; i < 16; i++) {
			var diId = "di";
			diId = diId.concat(index);
			bitIdx--;
			status = alarmBit16[bitIdx];
			if (i == 3 || i == 6 || i == 13 || i == 14 || i == 15)
				continue;
			if (i == 7 || i == 8 || i == 12) {
				//alert(unitId);
				if (status == "0")
					document.getElementById(diId).src = "./img/oper/pcs/alarm_diact.png";
				else
					document.getElementById(diId).src = "./img/oper/pcs/alarm_redact.png";
				index += 1;

			} else {
				//alert(unitId);
				if (status == "0")
					document.getElementById(diId).src = "./img/oper/pcs/alarm_diact.png";
				else
					document.getElementById(diId).src = "./img/oper/pcs/alarm_act.png";
				index += 1;
			}
		}
	}

	function dec2bin(dec) {
		return (dec >>> 0).toString(2);
	}
</script>
<div class="operRightPCS">
	<div class="operRightTitle">
		<span>PCS 계측 정보</span>
	</div>
	<div class="operPCSWrapper">
		<div class="operPcsTopBox">
			<!-- <div id="pcsStatusBox">정상</div> -->
			<div id="pcsAlarmBox">충전중</div>
			<div id="topTime">최근 계측 일시 ${DT }</div>
		</div>
		<table class="operPCSTable">
			<thead>
				<tr>
					<th class="pcs_item"><span>항목</span></th>
					<th class="pcs_value"><span>값</span></th>
					<th class="pcs_item"><span>항목</span></th>
					<th class="pcs_value"><span>값</span></th>
					<th class="pcs_item"><span>항목</span></th>
					<th class="pcs_value"><span>값</span></th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<td class="pcs_title1">계통 전류 A</td>
					<td class="pcs_value1">${currA }A</td>
					<td class="pcs_title1">계통 전류 B</td>
					<td class="pcs_value1">${currB }A</td>
					<td class="pcs_title1">계통 전류 C</td>
					<td class="pcs_value1">${currC }A</td>
				</tr>
				<tr>
					<td class="pcs_title1">계통 전압 A</td>
					<td class="pcs_value1">${voltA }V</td>
					<td class="pcs_title1">계통 전압 B</td>
					<td class="pcs_value1">${voltB }V</td>
					<td class="pcs_title1">계통 전압 C</td>
					<td class="pcs_value1">${voltC }V</td>
				</tr>
				<tr>
					<td class="pcs_title1">계통 상전압 R</td>
					<td class="pcs_value1">${voltR }V</td>
					<td class="pcs_title1">계통 상전압 S</td>
					<td class="pcs_value1">${voltS }V</td>
					<td class="pcs_title1">계통 상전압 T</td>
					<td class="pcs_value1">${voltT }V</td>
				</tr>
				<tr>
					<td class="pcs_title1">DC 고전압</td>
					<td class="pcs_value1">${dc_voltH }V</td>
					<td class="pcs_title1">DC 저전압</td>
					<td class="pcs_value1">${dc_voltL }V</td>
					<td class="pcs_title1">DC 입력전압</td>
					<td class="pcs_value1">${dc_volt }V</td>
				</tr>
				<tr>
					<td class="pcs_title1">DC 입력전류</td>
					<td class="pcs_value1">${dc_curr }A</td>
					<td class="pcs_title1">Ambient 온도</td>
					<td class="pcs_value1">${ambient_temp }°C</td>
					<td class="pcs_title1">Stack 온도</td>
					<td class="pcs_value1">${stack_temp }°C</td>
				</tr>
				<tr>
					<td class="pcs_title1">입력 전력(DC)</td>
					<td class="pcs_value1">${dc_power }kW</td>
					<td class="pcs_title1">유효 전력(AC)</td>
					<td class="pcs_value1">${ac_power }kW</td>
					<td class="pcs_title1">무효 전력</td>
					<td class="pcs_value1">${r_power }kvar</td>
				</tr>
				<tr>
					<td class="pcs_title1">역률</td>
					<td class="pcs_value1">${wr }%</td>
					<td class="pcs_title1">출력 전력(방전)</td>
					<td class="pcs_value1">${dc_hgpower }kW</td>
					<td class="pcs_title1">출력 전력(충전)</td>
					<td class="pcs_value1">${c_hgpower }kW</td>
				</tr>
				<tr>
					<td class="pcs_title1">Trans 온도</td>
					<td class="pcs_value1">${trans_temp }°C</td>
					<td class="pcs_title1">주파수</td>
					<td class="pcs_value1">${freq }Hz</td>
					<td class="pcs_title1">제어모드</td>
					<td class="pcs_value1" id="pcs_cmode"></td>
				</tr>
				<tr>
					<td class="pcs_title1">시퀀스 지령</td>
					<td class="pcs_value1" id="pcs_mode"></td>
					<td class="pcs_title1">STATUS</td>
					<td class="pcs_value1" id="pcs_status"></td>
					<td class="pcs_title1">PEBB Fault</td>
					<td class="pcs_value1">${pebb }</td>
				</tr>

			</tbody>
		</table>
		<table class="operPCSSubtable">
			<tbody>
				<!-- act가 초록 diact가 무색 redact가 빨강 -->
				<!-- <tr> 
          <th class="pcs_left_title bottom_border" rowspan="2"><span>DC - STATUS</span></th>
          <td><img id="dc_status1" src="./img/oper/pcs/alarm_act.png"/><span>OV Relay</span></td>
          <td><img id="dc_status2" src="./img/oper/pcs/alarm_diact.png"/><span>UV Relay</span></td>
          <td><img id="dc_status3" src="./img/oper/pcs/alarm_redact.png"/><span>DC PRE-CHG</span></td>
          <td><img id="dc_status4" src="./img/oper/pcs/alarm_act.png"/><span>SPD</span></td>
          <td><img id="dc_status5" src="./img/oper/pcs/alarm_diact.png"/><span>MCCB_A</span></td>        
        </tr> 
        
        <tr class='bottom_border'>          
          <td><img id="dc_status6" src="./img/oper/pcs/alarm_act.png"/><span>GFR</span></td>
          <td><img id="dc_status7" src="./img/oper/pcs/alarm_diact.png"/><span>BAT-OV</span></td>
          <td colspan="3"><img id="dc_status8" src="./img/oper/pcs/alarm_redact.png"/><span>FLT</span></td>                 
        </tr>      
        -->
				<tr>
					<th class="pcs_left_title bottom_border" rowspan="2"><span>DO</span></th>
					<td><img id="do0" src="./img/oper/pcs/alarm_act.png" /><span>DCCB_ON</span></td>
					<td><img id="do1" src="./img/oper/pcs/alarm_diact.png" /><span>DCCB_OFF</span></td>
					<td><img id="do2" src="./img/oper/pcs/alarm_redact.png" /><span>ACB_ON</span></td>
					<td><img id="do3" src="./img/oper/pcs/alarm_act.png" /><span>ACCB_OFF</span></td>
					<td><img id="do4" src="./img/oper/pcs/alarm_diact.png" /><span>AUX_Power_MC</span></td>
				</tr>
				<tr class="bottom_border">
					<td><img id="do5" src="./img/oper/pcs/alarm_act.png" /><span>LAMP_POWER</span></td>
					<td><img id="do6" src="./img/oper/pcs/alarm_diact.png" /><span>LAMP_OPERATION</span></td>
					<td><img id="do7" src="./img/oper/pcs/alarm_redact.png" /><span>LAMP_FAULT</span></td>
					<td><img id="do8" src="./img/oper/pcs/alarm_act.png" /><span>Discharge
							MC2</span></td>
					<td><img id="do9" src="./img/oper/pcs/alarm_diact.png" /><span>FAN
							SMPS MC</span></td>
				</tr>
				<tr>
					<th class="pcs_left_title bottom_border" rowspan="2"><span>DI</span></th>
					<td><img id="di1" src="./img/oper/pcs/alarm_act.png" /><span>DCCB</span></td>
					<td><img id="di2" src="./img/oper/pcs/alarm_diact.png" /><span>DI_Signal</span></td>
					<td><img id="di3" src="./img/oper/pcs/alarm_redact.png" /><span>ACCB</span></td>
					<td><img id="di4" src="./img/oper/pcs/alarm_act.png" /><span>DC_Fuse</span></td>
					<td><img id="di5" src="./img/oper/pcs/alarm_diact.png" /><span>DC_SPD</span></td>
				</tr>
				<tr class="bottom_border">
					<td><img id="di6" src="./img/oper/pcs/alarm_act.png" /><span>EMERGENCY</span></td>
					<td><img id="di7" src="./img/oper/pcs/alarm_diact.png" /><span>DOOR</span></td>
					<td><img id="di8" src="./img/oper/pcs/alarm_redact.png" /><span>AC_SPD</span></td>
					<td><img id="di9" src="./img/oper/pcs/alarm_act.png" /><span>AC_GFD</span></td>
					<td><img id="di10" src="./img/oper/pcs/alarm_diact.png" /><span>Control
							SPD</span></td>
				</tr>
				
			</tbody>
		</table>
	</div>
</div>

<script language="JavaScript" type="text/JavaScript">
	do_table('${DO}');
	di_table('${DI}');
</script>