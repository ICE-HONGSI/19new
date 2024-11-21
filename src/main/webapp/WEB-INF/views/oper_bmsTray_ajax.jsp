<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="./js/operFancy.js"></script>

<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<style>
#trayChartCanvas {
	width: 95%;
	height: 240px;
}

svg {
	margin: 10px 30px;
}
</style>
<script>
	var Tno;
	
	// var arr = new Array(); oper_bmsCall에 선언해놓음
	if("${tray[0].CL01}"=="" && "${tray[0].CL02}"==""){
		//데이터가 없다면 0으로 배열 전부 초기화
		arr =  Array.apply(null, new Array(15)).map(Number.prototype.valueOf,0);
	}
	else{
		<c:forEach items = "${tray}" var = "row">
			arr[0]="${row.CL01}";
			arr[1]="${row.CL02}";
			arr[2]="${row.CL03}";
			arr[3]="${row.CL04}";
			arr[4]="${row.CL05}";
			arr[5]="${row.CL06}";
			arr[6]="${row.CL07}";
			arr[7]="${row.CL08}";
			arr[8]="${row.CL09}";
			arr[9]="${row.CL10}";
			arr[10]="${row.CL11}";
			arr[11]="${row.CL12}";
			arr[12]="${row.CL13}";
			arr[13]="${row.CL14}";
			arr[14]="${row.CL15}";
			var MMStext = "";
			MMStext += "최대 : " + ("${row.Max}"=="" ? "0" : "${row.Max}") + " ";
			MMStext += "최소 : " + ("${row.Min}"=="" ? "0" : "${row.Min}") + " ";
			MMStext += "표준편차 : " + ("${row.Dif}"=="" ? "0" : "${row.Dif}") + " ";
			$('.trayMMS').text(MMStext);
		</c:forEach>
	}
	var chart;
	am4core.ready(function() {
		Tno = parseInt(${Tno});

		// Themes begin
		function am4themes_myTheme(target) {
			if (target instanceof am4core.ColorSet) {
				target.list = [ am4core.color("#ffff00"),
						am4core.color("#ff0000") ];
			}
		}

		am4core.useTheme(am4themes_myTheme);
		// Themes end

		// Create chart instance
		chart = am4core.create("trayChartCanvas",
				am4charts.XYChart);
		
		chart.data = [ 
			{"value" : "01", "tray" : arr[0]}, 
			{"value" : "02", "tray" : arr[1]}, 
			{"value" : "03", "tray" : arr[2]}, 
			{"value" : "04", "tray" : arr[3]}, 
			{"value" : "05", "tray" : arr[4]}, 
			{"value" : "06", "tray" : arr[5]}, 
			{"value" : "07", "tray" : arr[6]}, 
			{"value" : "08", "tray" : arr[7]}, 
			{"value" : "09", "tray" : arr[8]}, 
			{"value" : "10", "tray" : arr[9]}, 
			{"value" : "11", "tray" : arr[10]},
			{"value" : "12", "tray" : arr[11]}, 
			{"value" : "13", "tray" : arr[12]}, 
			{"value" : "14", "tray" : arr[13]}, 
			{"value" : "15", "tray" : arr[14]} 
		];

		// Create axes

		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category = "value";
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.minGridDistance = 30;
		categoryAxis.renderer.labels.template.fill = "#FFFFFF";
		
		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.renderer.labels.template.fill = "#FFFFFF";

		// Create series
		var series = chart.series.push(new am4charts.ColumnSeries());
		series.dataFields.valueY = "tray";
		series.dataFields.categoryX = "value";
		series.name = "tray";
		series.tooltip.getFillFromObject = false;
		series.columns.template.tooltipText = "{categoryX}: [Grey,bold]{valueY}[/]";
		series.columns.template.fillOpacity = .8;

		var columnTemplate = series.columns.template;
		columnTemplate.strokeWidth = 1;
		columnTemplate.strokeOpacity = 1;
		
	}); // end am4core.ready()
	
	function changeChartData(obj){
		_Tno = obj.getAttribute("class");
		
		Tno = parseInt(_Tno.substr(_Tno.length-2,2));
		//console.log("Tno is " + Tno);
		$('.trayChartTitle').text("Chart for Tray "+Tno);
		
		// var arr = new Array(); oper_bmsCall에 선언해놓음
		if("${tray[0].CL01}"=="" && "${tray[0].CL02}"==""){
			//데이터가 없다면 0으로 배열 전부 초기화
			arr =  Array.apply(null, new Array(15)).map(Number.prototype.valueOf,0);
		}
		else{
			<c:forEach items = "${tray}" var = "row">
				if(${row.Tno}==Tno){
					arr[0]="${row.CL01}";
					arr[1]="${row.CL02}";
					arr[2]="${row.CL03}";
					arr[3]="${row.CL04}";
					arr[4]="${row.CL05}";
					arr[5]="${row.CL06}";
					arr[6]="${row.CL07}";
					arr[7]="${row.CL08}";
					arr[8]="${row.CL09}";
					arr[9]="${row.CL10}";
					arr[10]="${row.CL11}";
					arr[11]="${row.CL12}";
					arr[12]="${row.CL13}";
					arr[13]="${row.CL14}";
					arr[14]="${row.CL15}";
					var MMStext = "";
					MMStext += "최대 : " + ("${row.Max}"=="" ? "0" : "${row.Max}") + " ";
					MMStext += "최소 : " + ("${row.Min}"=="" ? "0" : "${row.Min}") + " ";
					MMStext += "표준편차 : " + ("${row.Dif}"=="" ? "0" : "${row.Dif}") + " ";
					$('.trayMMS').text(MMStext);
				}
			</c:forEach>
		}
		
		
		chart.data = [ 
			{"value" : "01", "tray" : arr[0]}, 
			{"value" : "02", "tray" : arr[1]}, 
			{"value" : "03", "tray" : arr[2]}, 
			{"value" : "04", "tray" : arr[3]}, 
			{"value" : "05", "tray" : arr[4]}, 
			{"value" : "06", "tray" : arr[5]}, 
			{"value" : "07", "tray" : arr[6]}, 
			{"value" : "08", "tray" : arr[7]}, 
			{"value" : "09", "tray" : arr[8]}, 
			{"value" : "10", "tray" : arr[9]}, 
			{"value" : "11", "tray" : arr[10]},
			{"value" : "12", "tray" : arr[11]}, 
			{"value" : "13", "tray" : arr[12]}, 
			{"value" : "14", "tray" : arr[13]}, 
			{"value" : "15", "tray" : arr[14]} 
		];
	}
</script>

<div class="trayInfo">
	<div class="trayTitle">
		<span id="trayTitleText">RACK No.${tray[0].Rno}</span>
	</div>
	<div class="tray_box">
		<div class="trayButtonSection">
			<div class="trayButton tray01" onclick="changeChartData(this);"
				id="trayAct">
				<a href="javascript:;" id="tray1">TRAY 01</a>
			</div>
			<div class="trayButton tray02" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray2">TRAY 02</a>
			</div>
			<div class="trayButton tray03" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray3">TRAY 03</a>
			</div>
			<div class="trayButton tray04" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray4">TRAY 04</a>
			</div>
			<div class="trayButton tray05" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray5">TRAY 05</a>
			</div>
			<div class="trayButton tray06" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray6">TRAY 06</a>
			</div>
			<div class="trayButton tray07" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray7">TRAY 07</a>
			</div>
			<div class="trayButton tray08" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray8">TRAY 08</a>
			</div>
			<div class="trayButton tray09" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray9">TRAY 09</a>
			</div>
			<div class="trayButton tray10" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray10">TRAY 10</a>
			</div>
			<div class="trayButton tray11" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray11">TRAY 11</a>
			</div>
			<div class="trayButton tray12" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray12">TRAY 12</a>
			</div>
			<div class="trayButton tray13" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray13">TRAY 13</a>
			</div>
			<div class="trayButton tray14" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray14">TRAY 14</a>
			</div>
			<div class="trayButton tray15" onclick="changeChartData(this);">
				<a href="javascript:;" id="tray15">TRAY 15</a>
			</div>
		</div>
		<div class="trayChartSection" style="background-color: #212121">
			<div class="trayMMS" style="color: #a6a6a6; float: right; margin-right: 20px;">
				최대 : 0, &nbsp
				최소 : 0, &nbsp
				표준편차 : 0
			</div>
			<div id="trayChartCanvas"></div>
			<center class="trayChartTitle" style="color: #a6a6a6; margin-top: 10px;">
				Chart for Tray 1
			</center>
		</div>
		<a class="closeDetailInfo" onclick="closeTray()" href="#"><img
			src="./img/oper/svg/bms/closemodal.svg" />
		</a>
	</div>
</div>


