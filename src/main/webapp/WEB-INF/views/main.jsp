<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<c:choose>
	<c:when test="${empty sessionScope.userLoginInfo}">
		<%
			response.sendRedirect("logout");
		%>
	</c:when>
</c:choose>
<c:import url="/top" />

<!-- Resources -->
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/material.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/kelly.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


<div class="mainDetail">
	<div class="mainLeft">
		<div class="solar-info">
			<div class="main-box-main-box-title-container">
				<p class="main-box-title">태양광 발전 정보</p>
			</div>
			<div class="solar-info-content-container">
				<img class="solar-info-img-container"
					src="./img/main/svg/solar-info/solar-panel-1-c.svg" alt="Solar Panel" />
				<div class="solar-info-content-detail-conatiner">
					<p class="solar-info-subtitle">현재 발전량</p>
					<p>
						<span class="solar-info-value" id="solar-info-value1"> 0 </span> <span
							class="solar-info-unit">&nbspkW</span>
					</p>
				</div>
			</div>
		</div>

		<div class="ess-info">
			<div class="main-box-main-box-title-container">
				<p class="main-box-title">ESS 발전 정보</p>
			</div>
			<div class="ess-info-content-container">
				<img class="ess-info-img-container"
					src="./img/main/svg/ess-info/battery-1-c.svg" id="ess-info-battery"
					alt="Battery" />
				<div class="ess-info-content-detail-conatiner">
					<p class="ess-info-subtitle">현재 배터리 SOC</p>
					<p>
						<span class="ess-info-value" id="ess-info-value1">0</span> <span
							class="ess-info-unit">%</span>
					</p>
				</div>
			</div>
		</div>

		<div class="run-info">
			<div class="main-box-main-box-title-container">
				<p class="main-box-title">운전 정보</p>
			</div>
			<div class="run-info-content-container">
				<ul>
					<li class="subLTW"><p
							class="subLeft run-info-content-main-box-title">설치 용량</p>
						<p class="subRight ">
							<span id="kw">-</span> <span class="run-info-content-unit">&nbsp;kWh</span>
						</p></li>
					<hr class="dataLine" />
					<li class="subLTW"><p
							class="subLeft run-info-content-main-box-title">PCS 모드</p>
						<p class="subRight" id="run-info-FirstImg">자동모드</p></li>
					<hr class="dataLine" />
					<li class="subLTW"><p
							class="subLeft run-info-content-main-box-title">BMS 상태</p>
						<p class="subRight" id="run-info-SecondImg">-</p></li>
					<hr class="dataLine" />
					<li class="subLTW"><p
							class="subLeft run-info-content-main-box-title">BMS 룸 온도</p>
						<p class="subRight">
							<span class="run-info-content-number"
								id="run-info-content-number1">-</span> <span
								class="run-info-content-unit">&nbsp;&deg;C</span>
						</p></li>
					<hr class="dataLine" />
					<li class="subLTW"><p
							class="subLeft run-info-content-main-box-title">PCS 룸 온도</p>
						<p class="subRight">
							<span class="run-info-content-number"
								id="run-info-content-number2">-</span> <span
								class="run-info-content-unit">&nbsp;&deg;C</span>
						</p></li>
					<hr class="dataLine" />
					<li class="subLTW"><p
							class="subLeft run-info-content-main-box-title">BMS 룸 습도</p>
						<p class="subRight">
							<span class="run-info-content-number"
								id="run-info-content-number3">-</span> <span
								class="run-info-content-unit">&nbsp;&nbsp;%</span>
						</p></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="mainRight">
		<div class="mainRightTop">
			<div class="power-system">
				<div class="main-box-main-box-title-container">
					<p class="main-box-title" id="RunResultDT">
						발전 계통 <span id="RunResultDT2"></span>
					</p>
				</div>
				<div class="power-system-content-container">
					<div class="power-system-content-row">
						<div class="power-system-image-name-container" id="kepco">
							<img src="./img/main/svg/power-system/kepco.svg" alt="">
							<div class="power-system-name-tag">한전</div>
						</div>
						<div id="line1-value">
							<p class="line-value">
								<span id="FigureA">0</span><span class="unit">&nbspkW</span>
							</p>
						</div>
						<div class="power-system-image-name-container" id="solar-panel">
							<img src="./img/main/svg/power-system/solar-panel.svg" alt="">
							<div class="power-system-name-tag">태양광</div>
						</div>
						<div id="line2-value">
							<p class="line-value">
								<span id="FigureB">0</span> <span class="unit">&nbspkW</span>
							</p>
						</div>
						<div id="line3-value">
							<p class="line-value">
								<span id="FigureD">0</span> <span class="unit">&nbspkW</span>
							</p>
						</div>
						<!-- 정렬을 위한 빈 div 1개 -->
						<div class="power-system-image-name-container"></div>
						<div class="power-system-image-name-container" id="battery">
							<img src="./img/main/svg/power-system/battery.svg"
								id="power-system-battery" alt="">
							<div class="ess-info-number">
								<div class="power-system-name-tag">배터리</div>
								<center>
									<p>
										<span class="ess-info-value2" id="FigureF">0</span> <span
											class="ess-info-unit">%</span>
									</p>
								</center>
							</div>
						</div>
					</div>
					<div class="power-system-content-row">
						<!-- 정렬을 위한 빈 div 3개 -->
						<div class="power-system-image-name-container"></div>
						<div class="power-system-image-name-container"></div>
						<div id="line4-value">
							<p class="line-value">
								<span id="FigureE">0</span><span class="unit">&nbspkW</span>
							</p>
						</div>
						<div class="power-system-image-name-container" id="PCS">
							<img src="./img/main/svg/power-system/pcs.svg" alt="">
							<!-- <div id="line5-value"> -->
							<p class="line-value">
								<span id="FigureC">0</span><span class="unit">&nbspkW</span>
							</p>
							<!-- </div> -->
							<div class="power-system-name-tag">PCS</div>
						</div>

						<div class="power-system-image-name-container"></div>
					</div>
					<img src="./img/main/svg/power-system/de-line1.svg" id="line1" alt="">
					<img src="./img/main/svg/power-system/de-line2.svg" id="line2" alt="">
					<img src="./img/main/svg/power-system/de-line3.svg" id="line3" alt="">
					<img src="./img/main/svg/power-system/de-line4.svg" id="line4" alt="">
					<img src="./img/main/svg/power-system/de-line5.svg" id="line5" alt="">
				</div>
			</div>

			<div class="run-result">
				<div class="main-box-main-box-title-container">
					<p class="main-box-title">운전 실적</p>
				</div>
				<div class="rigtTwoWrapper" id="rightTwoTopWrapper">
					<h3 class="run-result-submain-box-title">당일 실적</h3>
					<ul>
						<li class="subRTW"><p class="subLeft">발전량</p>
							<p class="subRight">
								<span class="run-result-value" id="run-result-value1">0</span>&nbsp;<span
									id="subRight1"> kWh</span>
							</p></li>
						<hr class="dataLine" />
						<li class="subRTW"><p class="subLeft">충전량</p>
							<p class="subRight">
								<span class="run-result-value" id="run-result-value2">0</span>&nbsp;<span
									id="subRight2"> kWh</span>
							</p></li>
						<hr class="dataLine" />
						<li class="subRTW"><p class="subLeft">방전량</p>
							<p class="subRight">
								<span class="run-result-value" id="run-result-value3">0</span>&nbsp;<span
									id="subRight3"> kWh</span>
							</p></li>
					</ul>
				</div>

				<div class="rigtTwoWrapper">
					<h3 class="run-result-submain-box-title">당월 실적</h3>
					<ul>
						<li class="subRTW"><p class="subLeft">발전량</p>
							<p class="subRight">
								<span class="run-result-value" id="run-result-value4"> 0</span>&nbsp;
								<span id="subRight4"> kWh</span>
							</p></li>
						<hr class="dataLine" />
						<li class="subRTW"><p class="subLeft">충전량</p>
							<p class="subRight">
								<span class="run-result-value" id="run-result-value5"> 0</span>&nbsp;
								<span id="subRight5"> kWh</span>
							</p></li>
						<hr class="dataLine" />
						<li class="subRTW"><p class="subLeft">방전량</p>
							<p class="subRight">
								<span class="run-result-value" id="run-result-value6"> 0</span>&nbsp;
								<span id="subRight6"> kWh</span>
							</p></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="realtime-trend">
			<div class="main-box-main-box-title-container">
				<p class="main-box-title">실시간 트렌드</p>
			</div>
			<div class="realtime-trend-content-AxisX">충전·방전량 (kWh)</div>
			<div style="display: inline-block"
				class="realtime-trend-content-container"></div>
			<div class="realtime-trend-content-AxisY">시간 (hr)</div>
			<div class="subWrapper"></div>
		</div>
	</div>
</div>



<script>
	//-----------------------------------------------------------메인 상태표기 & 애니메이션
	//------------------------------------단위 처리
	var MainImgSrc = "./img/main/svg/power-system/";

	function check_unit(A, B, id, id2) {
		if (parseInt(A - B) > 1000) {
			document.getElementById(id).innerHTML = (parseInt(A - B) / 1000)
					.toFixed(1);
			document.getElementById(id2).innerHTML = "MWh";
		}

		else {
			document.getElementById(id).innerHTML = (parseInt(A - B).toFixed(1));
			document.getElementById(id2).innerHTML = "kWh";
		}
	}
	function check_unit2(A, id, id2) {
		if (parseInt(A) > 1000) {
			document.getElementById(id).innerHTML = (parseInt(A) / 1000)
					.toFixed(1);
			document.getElementById(id2).innerHTML = "MWh";
		}

		else {
			document.getElementById(id).innerHTML = parseInt(A).toFixed(1);
			document.getElementById(id2).innerHTML = "kWh";
		}
	}

	//애니메이션 효과
	function change_line(BMS_Status, R_PCSPower, R_ESSIn, R_ESSOut, R_PVOut,
			R_SOC) {

		/* <!-- Button image Change as BMS_Status--> */
		var runInfoSecImgStyle = document.getElementById("run-info-SecondImg").style;
		var runInfoImgUrl = "url('./img/main/svg/run-info/"

		if (BMS_Status == "대기중") {
			runInfoImgUrl += "waiting.svg')";
			runInfoSecImgStyle.color = "white";
		} else if (BMS_Status == "방전중")
			runInfoImgUrl += "discharge.svg')";
		else
			runInfoImgUrl += "charging.svg')";

		runInfoSecImgStyle.bacgroundImage = runInfoImgUrl;

		/* Line Chagne */
		var C = parseFloat(R_PCSPower);
		var D = parseFloat(R_ESSIn);
		var E = parseFloat(R_ESSOut);

		/*  get Line */

		var line1 = document.getElementById("line1");
		line1.src = MainImgSrc;

		var line2 = document.getElementById("line2");
		line2.src = MainImgSrc;

		var line3 = document.getElementById("line3");
		line3.src = MainImgSrc;

		var line4 = document.getElementById("line4");
		line4.src = MainImgSrc;

		var line5 = document.getElementById("line5");
		line5.src = MainImgSrc;

		switch (BMS_Status) {
		case "충전중":
			var A = parseFloat(R_PVOut) - parseFloat(R_PCSPower);
			var B = parseFloat(R_PCSPower);

			A > 0 ? line1.src += "1.gif" : line1.src += "de-line1.svg"; //animation A

			B > 0 ? line2.src += "2.gif" // animation B
			: line2.src += "de-line2.svg";

			D > 0 ? line3.src += "3.gif" // animation C
			: line3.src += "de-line3.svg";

			line4.src += "de-line4.svg"; // off D
			line5.src += "de-line5.svg"; // off E

			break;

		case "방전중":
			var A = parseFloat(R_PVOut);
			var B = 0;

			A > 0 ? line1.src += "1.gif" //animation A
			: line1.src += "de-line1.svg";

			if (C > 0) {
				line4.src += "4.gif"; // F off
				line4.style.top = "225px";
			} else {
				line4.src += "de-line4.svg";
			}

			if (E > 0) {
				line5.src += "5.gif"; //animation E
				line5.style.left = "583px";
				line5.style.top = "227px";
			} else {
				line5.src += "de-line5.svg";
			}

			line2.src += "de-line2.svg"; // B off
			line3.src += "de-line3.svg"; // D off

			break;

		case "대기중":
			var A = parseFloat(R_PVOut) - parseFloat(R_PCSPower);
			var B = parseFloat(R_PCSPower);

			A > 0 ? line1.src += "1.gif" //animation A
			: line1.src += "de-line1.svg";

			line2.src += "de-line2.svg"; // B off
			line3.src += "de-line3.svg"; // D off
			line5.src += "de-line5.svg"; // E off
			line4.src += "de-line4.svg"; // F off

			break;

		}
		

		document.getElementById("FigureA").innerHTML = A.toFixed(1);
		document.getElementById("FigureB").innerHTML = B.toFixed(1);
		document.getElementById("FigureC").innerHTML = C.toFixed(1);
		document.getElementById("FigureD").innerHTML = D.toFixed(1);
		document.getElementById("FigureE").innerHTML = E.toFixed(1);

		var img = document.getElementById("power-system-battery");
		img.src = MainImgSrc;

		var temp = Number(R_SOC);

		if (0 <= temp && temp <= 5)
			img.src += "battery1.svg";
		else if (6 <= temp && temp <= 30)
			img.src += "battery2.svg";
		else if (31 <= temp && temp <= 50)
			img.src += "battery3.svg";
		else if (51 <= temp && temp <= 75)
			img.src += "battery4.svg";
		else if (75 <= temp && temp <= 94)
			img.src += "battery5.svg";
		else
			img.src += "battery.svg";

		img.style.width = "120px";
		img.style.height = "auto";

	}

	/* Battery Change */
	var img = document.getElementById("power-system-battery");
	var temp = Number("${RunResult[0].R_SOC}");
	img.src = MainImgSrc;

	if (0 <= temp && temp <= 5)
		img.src += "battery1.svg";
	else if (6 <= temp && temp <= 30)
		img.src += "battery2.svg";
	else if (31 <= temp && temp <= 50)
		img.src += "battery3.svg";
	else if (51 <= temp && temp <= 75)
		img.src += "battery4.svg";
	else if (75 <= temp && temp <= 94)
		img.src += "battery5.svg";
	else
		img.src += "battery.svg";

	//-----------------------------------------------------------메인 차트 부분

	//------------------------------------차트 데이터 처리
	//R_PVOut Average Values Per Hour Saved in Ravrg, ESS Average Values Per Hour Saved in Eavrg
	var Ravrg, Eavrg;
	var chartLoaded = false;
	
	function loadChartData(chartdata) {
		Ravrg = Array.apply(null, new Array(25)).map(Number.prototype.valueOf,
				0);
		Eavrg = Array.apply(null, new Array(25)).map(Number.prototype.valueOf,
				0);
		for (var i = 0; i <= 24; i++) {
			var addcount = 0;
			for(var j = 0; j < chartdata.length; j++){
				var num = Number(chartdata[j].TIME.substring(0, 2));
				if (num == i) {
					Ravrg[i] += parseFloat(chartdata[j].R_PVOut);
					Eavrg[i] += parseFloat(chartdata[j].ESS);
					addcount++;
				}
			}

			if (Ravrg[i] != 0 || Eavrg[i] != 0) {
				(Ravrg[i] /= addcount).toFixed(1);
				(Eavrg[i] /= addcount).toFixed(1);
			}
		}
		if(!chartLoaded){
			drawChart();			
		}
	}

	//------------------------------------차트 그리기		
	function drawChart() {
		
		//Amschart Logo Delete
		var g;
		var LogoDelete = setInterval(function() {
			g = document.getElementsByTagName("g");
			for (var i = 0; i < g.length; i++) {
				var abc = g[i];
				if (abc.getAttribute("aria-labelledby") == "id-60-title") {
					abc.parentElement.removeChild(abc);
				}
			}
		}, 100)

		am4core.ready(function() {

			// Themes begin
			function am4themes_myTheme(target) {
				if (target instanceof am4core.ColorSet) {
					target.list = [ am4core.color("#ffff00"),
							am4core.color("#55e0ae") ];
				}
			}

			am4core.useTheme(am4themes_myTheme);

			// Themes end

			// Create chart instance
			var chart = am4core.create("realtime-trend-content-container",
					am4charts.XYChart);
			chart.paddingRight = 20;

			chart.data = [ 
				{"hour" : "00","value" : Ravrg[0],"value2" : Eavrg[0]}, 
				{"hour" : "01","value" : Ravrg[1],"value2" : Eavrg[1]}, 
				{"hour" : "02","value" : Ravrg[2],"value2" : Eavrg[2]}, 
				{"hour" : "03","value" : Ravrg[3],"value2" : Eavrg[3]}, 
				{"hour" : "04","value" : Ravrg[4],"value2" : Eavrg[4]}, 
				{"hour" : "05","value" : Ravrg[5],"value2" : Eavrg[5]}, 
				{"hour" : "06","value" : Ravrg[6],"value2" : Eavrg[6]}, 
				{"hour" : "07","value" : Ravrg[7],"value2" : Eavrg[7]}, 
				{"hour" : "08","value" : Ravrg[8],"value2" : Eavrg[8]}, 
				{"hour" : "09","value" : Ravrg[9],"value2" : Eavrg[9]}, 
				{"hour" : "10","value" : Ravrg[10],"value2" : Eavrg[10]}, 
				{"hour" : "11","value" : Ravrg[11],"value2" : Eavrg[11]}, 
				{"hour" : "12","value" : Ravrg[12],"value2" : Eavrg[12]}, 
				{"hour" : "13","value" : Ravrg[13],"value2" : Eavrg[13]}, 
				{"hour" : "14","value" : Ravrg[14],"value2" : Eavrg[14]}, 
				{"hour" : "15","value" : Ravrg[15],"value2" : Eavrg[15]}, 
				{"hour" : "16","value" : Ravrg[16],"value2" : Eavrg[16]}, 
				{"hour" : "17","value" : Ravrg[17],"value2" : Eavrg[17]}, 
				{"hour" : "18","value" : Ravrg[18],"value2" : Eavrg[18]}, 
				{"hour" : "19","value" : Ravrg[19],"value2" : Eavrg[19]}, 
				{"hour" : "20","value" : Ravrg[20],"value2" : Eavrg[20]}, 
				{"hour" : "21","value" : Ravrg[21],"value2" : Eavrg[21]}, 
				{"hour" : "22","value" : Ravrg[22],"value2" : Eavrg[22]}, 
				{"hour" : "23","value" : Ravrg[23],"value2" : Eavrg[23]}, 
				{"hour" : "24","value" : Ravrg[24],"value2" : Eavrg[24]} 
			];

			// Create axes
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "hour";
			categoryAxis.renderer.minGridDistance = 50;
			categoryAxis.renderer.grid.template.location = 0.5;
			categoryAxis.renderer.labels.template.fontSize = 20;
			categoryAxis.renderer.labels.template.fontWeight = "bold";
			categoryAxis.renderer.labels.template.fill = "#FFFFFF";

			// Create value axis
			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.baseValue = 0;
			valueAxis.renderer.labels.template.fontSize = 20;
			valueAxis.renderer.labels.template.fontWeight = "bold";
			valueAxis.renderer.labels.template.fill = "#FFFFFF";

			// Create series
			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.valueY = "value2";
			series.dataFields.categoryX = "hour";
			series.tensionX = 0;
			series.name = "충방전량";
			series.columns.template.width = am4core.percent(50);

			series.tooltip.getFillFromObject = false;
			series.tooltipText = "{hour}시 충방전량 : [Grey,bold]{valueY}[/]kWh";
			series.tooltip.label.fill = am4core.color("#575757");
			series.tooltip.trackable = true;

			var series2 = chart.series.push(new am4charts.LineSeries());
			series2.dataFields.valueY = "value";
			series2.dataFields.categoryX = "hour";
			series2.strokeWidth = 5;
			series2.tensionX = 1;
			series2.name = "태양광방전량";
			series2.bullets.push(new am4charts.CircleBullet());
			series2.tooltip.getFillFromObject = false;
			series2.tooltipText = "{hour}시 발전량 : [Grey,bold]{valueY}[/]kWh";
			series2.tooltip.label.fill = am4core.color("#575757");
			series2.tooltip.trackable = true;

			chart.cursor = new am4charts.XYCursor();

		});
	}

	//-----------------------------------------------------------30초마다 리프레쉬
	exam();
	if ("${status}" == "error")
		alert("데이터가 없습니다.");
	window.setInterval(function() {
		exam();
	}, 1000 * 30); // each 30sec refresh

	function exam() {
		$.ajax({
			type : "GET",
			url : "mainRefresh",
			error : function(error) {
				console.log("error");
			},
			success : function(data) {
				/* left side */
				document.getElementById("solar-info-value1").innerHTML = data.RunResult[0].R_PVOut;
				document.getElementById("ess-info-value1").innerHTML = data.RunResult[0].R_SOC;
				document.getElementById("kw").innerHTML = data.BatSize;
				document.getElementById("run-info-SecondImg").innerHTML = data.BMS_Status;
				document.getElementById("run-info-content-number1").innerHTML = data.RunResult[0].Temp1;
				document.getElementById("run-info-content-number2").innerHTML = data.RunResult[0].Temp2;
				document.getElementById("run-info-content-number3").innerHTML = data.RunResult[0].Humi1;
				document.getElementById("RunResultDT2").innerHTML = data.RunResult[0].DT;

				var asc_PVOut = 0;
				var asc_ESSIn = 0;
				var asc_ESSOut = 0;
				if (data.month_asc[0] != null) {
					asc_PVOut = data.month_asc[0].G_PVOut;
					asc_ESSIn = data.month_asc[0].G_ESSIn;
					asc_ESSOut = data.month_asc[0].G_ESSOut;
				}

				/* right side */
				check_unit2(data.RunResult[0].D_PVOut,
						"run-result-value1", "subRight1");
				check_unit2(data.RunResult[0].D_ESSIn,
						"run-result-value2", "subRight2");
				check_unit2(data.RunResult[0].D_ESSOut,
						"run-result-value3", "subRight3");

				check_unit(data.month_now[0].G_PVOut,
						asc_PVOut, "run-result-value4",
						"subRight4");
				check_unit(data.month_now[0].G_ESSIn,
						asc_ESSIn, "run-result-value5",
						"subRight5");
				check_unit(data.month_now[0].G_ESSOut,
						asc_ESSOut,
						"run-result-value6", "subRight6");

				/* center */
				change_line(data.BMS_Status,
						data.RunResult[0].R_PCSPower,
						data.RunResult[0].R_ESSIn,
						data.RunResult[0].R_ESSOut,
						data.RunResult[0].R_PVOut,
						data.RunResult[0].R_SOC);

				document.getElementById("FigureF").innerHTML = data.RunResult[0].R_SOC;

				loadChartData(data.chartdata);
			}
		});
	}
</script>

<!--mainDetail-->
<c:import url="/bottom" />