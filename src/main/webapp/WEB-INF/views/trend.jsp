<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${empty sessionScope.userLoginInfo}">
		<%
		response.sendRedirect("logout");
		%>
	</c:when>
</c:choose>
<c:import url="/top"/>


<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	var RPV = Array.apply(null, new Array(24)).map(Number.prototype.valueOf,0);
	//console.log('${list}');
	var ESS = Array.apply(null, new Array(24)).map(Number.prototype.valueOf,0);

				<c:forEach items = "${list}" var = "info">
				var num = Number("${info.DT}".substring(11,13));
				for(var i=0 ; i <= 23 ; i++){
					var addcount = 0;
					
					console.log(num);
					if(num==i){
						RPV[i]=parseFloat("${info.R_PVOut}");
						ESS[i]=parseFloat("${info.ESS}");
					}
				}
				</c:forEach>
	
</script>

<div class="trendDetail">
  <div class="trendSubWrapper" id="tsOne">
    <div class="trendTitle" id="day">
      <span>일간 트렌드</span>
      
      <form class="TrendForm" name="form1" method="GET" action="/pms/trend">
        <input name="date1" type="date" id="date1" value=${date1} >
        <input type="button" class="form_btn" onclick="check(1);" value="조회">
    </form>
    </div>
    <div class="define_bar">
      <span class="trendbar" id="bar2"><img src="img/trend/svg/bar2.svg"/>태양광 발전량</span>
      <span class="trendbar" id="bar1"><img src="img/trend/svg/bar1.svg"/>배터리 충.방전량</span>
    </div>
    <div class="trend_chart">
    <canvas id="lineCanvas"></canvas>
      <script>
      
      
      var config ={
      	type :'line',
       data :{
		
  	        labels: ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"],

  	        datasets: [

  	            {

  	                label: "발전량",

  	                

  	              borderColor: "rgb(249, 179, 28)",

  	              backgroundColor: "rgba(220,220,220,0)",

  	                pointStrokeColor: "#fff",

  	                pointHighlightFill: "#fff",

  	                pointHighlightStroke: "rgba(220,220,220,1)",

  	                data: [RPV[0],RPV[1],RPV[2],RPV[3],RPV[4],RPV[5],RPV[6],RPV[7],RPV[8],RPV[9],RPV[10],RPV[11],RPV[12],RPV[13],RPV[14],RPV[15],RPV[16],RPV[17],RPV[18],RPV[19],RPV[20],RPV[21],RPV[22],RPV[23]]
  	            },

  	            {
  	            	

  	                label: "충.방전량",
					
  	                

  	                borderColor: "rgb(75, 219, 165)",

  	              backgroundColor: "rgba(220,220,220,0)",

  	                pointStrokeColor: "#fff",

  	                pointHighlightFill: "#fff",

  	                pointHighlightStroke: "rgba(151,187,205,1)",

  	                data: [ESS[0],ESS[1],ESS[2],ESS[3],ESS[4],ESS[5],ESS[6],ESS[7],ESS[8],ESS[9],ESS[10],ESS[11],ESS[12],ESS[13],ESS[14],ESS[15],ESS[16],ESS[17],ESS[18],ESS[19],ESS[20],ESS[21],ESS[22],ESS[23]]
  	            }

  	        ]

  	    },
  	  options: {
			responsive: true,maintainAspectRatio: false,bezierCurve : false,
			title: {
				display: true,
				text: '${date1}'
			},
			legend: {
			      display: false
			    },
			    
			tooltips: {
				mode: 'index',
				intersect: false,
			},
			hover: {
				mode: 'nearest',
				intersect: true
			},
			scales: {
				xAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: 'Day'
					},
					
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: 'kWh'
					},
					gridLines:{ 
					     color:"rgba(255,255,255,0.5)", 
					     zeroLineColor:"rgba(255,255,255,0.5)" 
					    }
				}]
			}
		}
      };




  
      </script>
      
      
    </div>
  </div>
  <div class="trendSubWrapper" id="tsTwo">
    <div class="trendTitle" id="month">
      <span>월간 트렌드</span>
      
      <form  class="TrendForm" name="form2" method="GET" action="/pms/trend">
        <input name="date2" type="month" id="date2" value=${date2}>
        <input type="button" class="form_btn" onclick="check(2);" value="조회">
    </form>
    </div>
    <div class="define_bar">
      <span class="bar_bold" id="bar5"><img src="img/trend/svg/bar5.svg"/>방전량</span>
      <span class="bar_bold" id="bar4"><img src="img/trend/svg/bar4.svg"/>충전량</span>
      <span class="bar_bold" id="bar3"><img src="img/trend/svg/bar3.svg"/>태양광 발전량</span>
    </div>
    <div class="trend_chart">
      <canvas id="barCanvas" width="384" height="210"></canvas>
      <script>
      Chart.defaults.global.defaultFontColor = 'white';
      var MonthDate;
      if ("${dateLabel}"=="02"){
    	 if("${dateLabel2}"%4==0)
    		MonthDate = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29"];
    	 else
    		MonthDate = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
      }
      else if("${dateLabel}"=="01"||"${dateLabel}"=="03"||"${dateLabel}"=="05"||"${dateLabel}"=="07"||"${dateLabel}"=="08"||"${dateLabel}"=="10"||"${dateLabel}"=="12"){
  			MonthDate = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
  		}
      else{
    	  MonthDate = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"];
      }

   /*	var data = {

    				labels: MonthDate,

    				datasets: [

    					{

    						label: "발전량",

    						backgroundColor: "rgb(249, 179, 28)",
    						
    						strokeColor: "rgb(249, 179, 28)",

    						highlightFill: "rgb(249, 179, 28)",

    						highlightStroke: "rgb(249, 179, 28)",

    						data: ["${list2[0].PV_SumOut}","${list2[1].PV_SumOut}","${list2[2].PV_SumOut}","${list2[3].PV_SumOut}","${list2[4].PV_SumOut}","${list2[5].PV_SumOut}","${list2[6].PV_SumOut}","${list2[7].PV_SumOut}","${list2[8].PV_SumOut}","${list2[9].PV_SumOut}","${list2[10].PV_SumOut}","${list2[11].PV_SumOut}","${list2[12].PV_SumOut}","${list2[13].PV_SumOut}","${list2[14].PV_SumOut}","${list2[15].PV_SumOut}","${list2[16].PV_SumOut}","${list2[17].PV_SumOut}","${list2[18].PV_SumOut}","${list2[19].PV_SumOut}","${list2[20].PV_SumOut}","${list2[21].PV_SumOut}","${list2[22].PV_SumOut}","${list2[23].PV_SumOut}","${list2[24].PV_SumOut}","${list2[25].PV_SumOut}","${list2[26].PV_SumOut}","${list2[27].PV_SumOut}","${list2[28].PV_SumOut}","${list2[29].PV_SumOut}","${list2[30].PV_SumOut}"]

    					},
    					{

    						label: "충전량",

    						backgroundColor: "rgb(242, 55, 88)",
    						
    						strokeColor: "rgb(242, 55, 88)",

    						highlightFill: "rgb(242, 55, 88)",

    						highlightStroke: "rgb(242, 55, 88)",

    						data: ["${list2[0].ESS_SumOut}","${list2[1].ESS_SumOut}","${list2[2].ESS_SumOut}","${list2[3].ESS_SumOut}","${list2[4].ESS_SumOut}","${list2[5].ESS_SumOut}","${list2[6].ESS_SumOut}","${list2[7].ESS_SumOut}","${list2[8].ESS_SumOut}","${list2[9].ESS_SumOut}","${list2[10].ESS_SumOut}","${list2[11].ESS_SumOut}","${list2[12].ESS_SumOut}","${list2[13].ESS_SumOut}","${list2[14].ESS_SumOut}","${list2[15].ESS_SumOut}","${list2[16].ESS_SumOut}","${list2[17].ESS_SumOut}","${list2[18].ESS_SumOut}","${list2[19].ESS_SumOut}","${list2[20].ESS_SumOut}","${list2[21].ESS_SumOut}","${list2[22].ESS_SumOut}","${list2[23].ESS_SumOut}","${list2[24].ESS_SumOut}","${list2[25].ESS_SumOut}","${list2[26].ESS_SumOut}","${list2[27].ESS_SumOut}","${list2[28].ESS_SumOut}","${list2[29].ESS_SumOut}","${list2[30].ESS_SumOut}"]

    					},
    					{

    						label: "방전량",
    						stacked: true,
    						backgroundColor: "rgb(75, 219, 165)",

    						strokeColor: "rgb(75, 219, 165)",

    						highlightFill: "rgb(75, 219, 165)",

    						highlightStroke: "rgb(75, 219, 165)",

    						data: ["${list2[0].ESS_SumRcv}","${list2[1].ESS_SumRcv}","${list2[2].ESS_SumRcv}","${list2[3].ESS_SumRcv}","${list2[4].ESS_SumRcv}","${list2[5].ESS_SumRcv}","${list2[6].ESS_SumRcv}","${list2[7].ESS_SumRcv}","${list2[8].ESS_SumRcv}","${list2[9].ESS_SumRcv}","${list2[10].ESS_SumRcv}","${list2[11].ESS_SumRcv}","${list2[12].ESS_SumRcv}","${list2[13].ESS_SumRcv}","${list2[14].ESS_SumRcv}","${list2[15].ESS_SumRcv}","${list2[16].ESS_SumRcv}","${list2[17].ESS_SumRcv}","${list2[18].ESS_SumRcv}","${list2[19].ESS_SumRcv}","${list2[20].ESS_SumRcv}","${list2[21].ESS_SumRcv}","${list2[22].ESS_SumRcv}","${list2[23].ESS_SumRcv}","${list2[24].ESS_SumRcv}","${list2[25].ESS_SumRcv}","${list2[26].ESS_SumRcv}","${list2[27].ESS_SumRcv}","${list2[28].ESS_SumRcv}","${list2[29].ESS_SumRcv}","${list2[30].ESS_SumRcv}"]

    					}

    				]

    			};

    	   

    	    
    	    window.onload = function() {	
    	    	 var ctx = document.getElementById("barCanvas").getContext("2d");
				
    	   window.myBar = new Chart(ctx, {
				type: 'bar',
				data: data,
				options: {
					title: {
						display: true,
						text: '${date2}'
					},
					legend: {
					      display: false
					      
					    },
					tooltips: {
						mode: 'index',
						intersect: false
					},
					responsive: true,
					maintainAspectRatio: false,
					scales: {
						xAxes: [{
							stacked: true,
							display: true,
							scaleLabel: {
								display: true,
								labelString: 'Month'
							}
						}],
						yAxes: [{
							stacked: true,
							display: true,
							scaleLabel: {
								display: true,
								labelString: 'kWh'
							},gridLines:{ 
							     color:"rgba(255,255,255,0.5)", 
							     zeroLineColor:"rgba(255,255,255,0.5)" 
							    }
							    
						}]
					}
				}
    	   
			});
    	   var ctx = document.getElementById('lineCanvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
    	    }
    	*/

		var config2 = {
			type: 'bar',
			data: {
				labels: MonthDate,
				datasets: [

					{

						label: "발전량",

						backgroundColor: "rgb(249, 179, 28)",
						
						strokeColor: "rgb(249, 179, 28)",

						highlightFill: "rgb(249, 179, 28)",

						highlightStroke: "rgb(249, 179, 28)",

						data: ["${list2[0].PV_SumOut}","${list2[1].PV_SumOut}","${list2[2].PV_SumOut}","${list2[3].PV_SumOut}","${list2[4].PV_SumOut}","${list2[5].PV_SumOut}","${list2[6].PV_SumOut}","${list2[7].PV_SumOut}","${list2[8].PV_SumOut}","${list2[9].PV_SumOut}","${list2[10].PV_SumOut}","${list2[11].PV_SumOut}","${list2[12].PV_SumOut}","${list2[13].PV_SumOut}","${list2[14].PV_SumOut}","${list2[15].PV_SumOut}","${list2[16].PV_SumOut}","${list2[17].PV_SumOut}","${list2[18].PV_SumOut}","${list2[19].PV_SumOut}","${list2[20].PV_SumOut}","${list2[21].PV_SumOut}","${list2[22].PV_SumOut}","${list2[23].PV_SumOut}","${list2[24].PV_SumOut}","${list2[25].PV_SumOut}","${list2[26].PV_SumOut}","${list2[27].PV_SumOut}","${list2[28].PV_SumOut}","${list2[29].PV_SumOut}","${list2[30].PV_SumOut}"]

					},
					{

						label: "충전량",

						backgroundColor: "rgb(242, 55, 88)",
						
						strokeColor: "rgb(242, 55, 88)",

						highlightFill: "rgb(242, 55, 88)",

						highlightStroke: "rgb(242, 55, 88)",

						data: ["${list2[0].ESS_SumOut}","${list2[1].ESS_SumOut}","${list2[2].ESS_SumOut}","${list2[3].ESS_SumOut}","${list2[4].ESS_SumOut}","${list2[5].ESS_SumOut}","${list2[6].ESS_SumOut}","${list2[7].ESS_SumOut}","${list2[8].ESS_SumOut}","${list2[9].ESS_SumOut}","${list2[10].ESS_SumOut}","${list2[11].ESS_SumOut}","${list2[12].ESS_SumOut}","${list2[13].ESS_SumOut}","${list2[14].ESS_SumOut}","${list2[15].ESS_SumOut}","${list2[16].ESS_SumOut}","${list2[17].ESS_SumOut}","${list2[18].ESS_SumOut}","${list2[19].ESS_SumOut}","${list2[20].ESS_SumOut}","${list2[21].ESS_SumOut}","${list2[22].ESS_SumOut}","${list2[23].ESS_SumOut}","${list2[24].ESS_SumOut}","${list2[25].ESS_SumOut}","${list2[26].ESS_SumOut}","${list2[27].ESS_SumOut}","${list2[28].ESS_SumOut}","${list2[29].ESS_SumOut}","${list2[30].ESS_SumOut}"]

					},
					{

						label: "방전량",
						backgroundColor: "rgb(75, 219, 165)",

						strokeColor: "rgb(75, 219, 165)",

						highlightFill: "rgb(75, 219, 165)",

						highlightStroke: "rgb(75, 219, 165)",

						data: ["${list2[0].ESS_SumRcv}","${list2[1].ESS_SumRcv}","${list2[2].ESS_SumRcv}","${list2[3].ESS_SumRcv}","${list2[4].ESS_SumRcv}","${list2[5].ESS_SumRcv}","${list2[6].ESS_SumRcv}","${list2[7].ESS_SumRcv}","${list2[8].ESS_SumRcv}","${list2[9].ESS_SumRcv}","${list2[10].ESS_SumRcv}","${list2[11].ESS_SumRcv}","${list2[12].ESS_SumRcv}","${list2[13].ESS_SumRcv}","${list2[14].ESS_SumRcv}","${list2[15].ESS_SumRcv}","${list2[16].ESS_SumRcv}","${list2[17].ESS_SumRcv}","${list2[18].ESS_SumRcv}","${list2[19].ESS_SumRcv}","${list2[20].ESS_SumRcv}","${list2[21].ESS_SumRcv}","${list2[22].ESS_SumRcv}","${list2[23].ESS_SumRcv}","${list2[24].ESS_SumRcv}","${list2[25].ESS_SumRcv}","${list2[26].ESS_SumRcv}","${list2[27].ESS_SumRcv}","${list2[28].ESS_SumRcv}","${list2[29].ESS_SumRcv}","${list2[30].ESS_SumRcv}"]

					}

				]
			},
			options: {
				title: {
					display: true,
					text: '${date2}'
				},
				legend: {
				      display: false
				      
				    },
				tooltips: {
					mode: 'index',
					intersect: false
				},
				responsive: true,
				maintainAspectRatio: false,
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Month'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'kWh'
						},gridLines:{ 
						     color:"rgba(255,255,255,0.5)", 
						     zeroLineColor:"rgba(255,255,255,0.5)" 
						    }
						    
					}]
				}
			}
		};
    	var ctx = document.getElementById('barCanvas').getContext('2d');
		window.myLine = new Chart(ctx, config2);
		var ctx2 = document.getElementById('lineCanvas').getContext('2d');
		window.myLine = new Chart(ctx2, config);
	    

	</script>
    </div>
  </div>
</div>
<script>
function check(type){
	var date1 = document.getElementById('date1').value;
	var date2 = document.getElementById('date2').value;
	
	var diffDate_1 = date1 instanceof Date ? _date1 : new Date(date1);
	var diffDate_2 = date2 instanceof Date ? _date2 : new Date(date2);
	console.log(diffDate_1+diffDate_2);
	
	if (diffDate_1 == "Invalid Date" || diffDate_2 == "Invalid Date") {
		alert("날짜값이 잘못되었습니다.");
		
		return false;
	}
	else{
		if(type ==1) document.form1.submit();
		else document.form2.submit();
	}
		return true;
}

</script>
      
  
<c:import url="/bottom"/>



    
    

<body>
    
    
    
    

	
	


	
	