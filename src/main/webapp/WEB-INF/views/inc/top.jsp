<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>ENERGUARD SYSTEM</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="./js/top.js"></script>
<link rel="stylesheet" type="text/css" href="./css/top.css">
<link rel="stylesheet" type="text/css" href="./css/main.css">
<link rel="stylesheet" type="text/css" href="./css/oper.css">
<link rel="stylesheet" type="text/css" href="./css/trend.css">
<link rel="stylesheet" type="text/css" href="./css/report.css">
<link rel="stylesheet" type="text/css" href="./css/control.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script>

	   console.log("Ver. 191101. \nby WALAB 2019-2 Capstone Project");

 	   var setCookie = function(name, value) {
		 var date = new Date();
		 date.setTime(date.getTime() + 1000 * 10 * 60); //cookie 10분 지속
		 document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
	   };
	   
	   var getCookie = function(name) {
		   var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		   return value? value[2] : null;
		};
        
        const appKey = "8d4de91e1577d6361f6d18064dc6e96b";
        var weather_name;
        var temperature;
        var img;
        var d = new Date();
        
        function change_weather(icon, temp) {
        	var status;
        	img.src = "./img/top/svg/";
        	
            switch (icon) {
                /*맑음*/
                case "01d":
                case "01n":
                case "03n":
                case "03d":
                    img.src += "clear.svg";
                    status = "맑음";
                    break;

                /* 구름 조금  */
                case "02d":
                case "02n":
                case "04d":
                case "04n":
                    img.src += "little-cloud.svg";
                    status = "조금흐림";
                    break;

                /*구름 많이*/
                case "50d":
                case "50n":
                    img.src += "cloudy.svg";
                    status = "흐림";
                    break;

                /*비*/
                case "09d":
                case "09n":
                case "10d":
                case "10n":
                case "11d":
                case "11n":
                    img.src += "rain.svg";
                    status = "비";
                    break;

                /*눈*/
                case "13d":
                case "13n":
                    img.src += "snow.svg";
                    status = "눈";
                    break;
            }
            
            weather_name.innerHTML = status;
            temperature.innerHTML = temp  + "˚C";
            
            var time = String(d);
          	var month = String(d.getFullYear()) + String(d.getMonth() + 1);
          	var day = d.getDate();
          	$('.time').val(time);
          	$('.month').val(month);
          	$('.date').val(date);
            $('.status').val(status);
            $('.reason').val(reason);

            $.ajax({
    			type : "POST",
    			url : "weatherRecord", 
    			data : $('form').serialize(),
    			error : function(error) {
    				console.log("error");
    			},
    			success : function(data) {

    			}
    		});
            
           
        }
        
        $(document).ready(function () {
        	img = document.getElementById("weather");
            weather_name = document.getElementById("weather_name");
            temperature = document.getElementById("temp");
            
          	check_time();
          	setInterval(check_time, 1 * 1000 * 60 * 5); //5분마다 실행
           
        });
        
        function check_time() {
        	
        	/* 데이터가 없거나 현재시간 - 마지막call시간 >=5 */
            if(getCookie("icon") == null)
            {
            	setCookie("pre_time", d.getHours()*60 + d.getMinutes());
            	setCookie("pre_date", d.getDate());
            	reason="0";
            	findWeatherDetails();
            }
            else if(d.getHours()*60 + d.getMinutes() - getCookie("pre_time") >= 5 || d.getDate() != getCookie("pre_date"))
            {
            	setCookie("pre_time", d.getHours()*60 + d.getMinutes());
            	setCookie("pre_date", d.getDate());
            	reason="1";
            	findWeatherDetails();
            }
            else
            {
            	reason="2";
            	change_weather(getCookie("icon"), getCookie("temp"));
            }
          	
        }

        //2nd
        function findWeatherDetails() {
            var region = "lat=" + "${sessionScope.userLoginInfo.getLocX()}" + "&lon=" + "${sessionScope.userLoginInfo.getLocY()}";
            var searchLink = "https://api.openweathermap.org/data/2.5/weather?" + region + "&appid=" + appKey;
            
            httpRequestAsync(searchLink, theResponse);
        }
        
        function theResponse(response) {
        	var jsonObject = JSON.parse(response);
        	setCookie("icon", jsonObject.weather[0].icon);
        	setCookie("temp", (jsonObject.main.temp-273).toFixed(0));
        
        	change_weather(jsonObject.weather[0].icon, (parseInt(jsonObject.main.temp - 273)).toFixed(0));
        }

  
        //3rd
        function httpRequestAsync(url, callback) {
        	var d = new Date();
            var httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () =>
            {
                if (httpRequest.readyState == 4 && httpRequest.status == 200)
                    callback(httpRequest.responseText);
            }
            httpRequest.open("GET", url, true); // true for asynchronous
            httpRequest.send();
        }
    </script>
</head>

<body class="backGround">
	<div class="topMenu">
		<div class="logo">
			<div class="logo_image">
				<img src="./img/top/svg/energuard.svg" id="logo" style="cursor:pointer" onclick='locationRedir("main")'>
			</div>
			<c:choose>
				<c:when test="${not empty sessionScope.userLoginInfo}">
					<div class="logo_name">
						<span id="compName">${sessionScope.userLoginInfo.getGname()}
							발전소&nbsp&nbsp</span>
					</div>
				</c:when>
				<c:otherwise>
					<script>location.href = '/';</script>
				</c:otherwise>
			</c:choose>

			<div class="logo_weather">
				<img src="" id="weather" />
				<div class="map_wrap">
					<div id="map"></div>
					<div class="hAddr">
						<span>&nbsp</span><span id="centerAddr"></span>
					</div>
				</div>
				<div class="weather_name">
					<span>&nbsp</span><span id="weather_name"></span><span id="temp">˚C</span>
				</div>
			</div>

		</div>


		<div class="menu">
			<ul>
				<li id="control" class="unselected" style="margin-left: -15px;"
					onclick='locationRedir("control")'><a href="#">제어</a></li>
				<li id="oper" class="unselected" style="margin-left: -2px;"
					onclick='locationRedir("oper")'><a href="#">운영</a></li>
				<li id="report" class="unselected" onclick='locationRedir("report")'><a
					href="#">리포트</a></li>
				<li id="trend" class="unselected" style="margin-left: 1px;"
					onclick='locationRedir("trend")'><a href="#">트렌드</a></li>
				<li id="main" class="unselected" onclick='locationRedir("main")'><a
					href="main">메인</a></li>
			</ul>
		</div>
	</div>
	<form>
		<input id="time" class="time" name="time" type="hidden"> <input
			id="month" class="month" name="month" type="hidden"> <input
			id="date" class="date" name="date" type="hidden"> <input
			id="reason" class="reason" name="reason" type="hidden"> <input
			id="status" class="status" name="status" type="hidden">
	</form>


	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2e4d3db9202a876bae8b4b4ab3c7e0b8&libraries=services"></script>
	<script>
	    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	        mapOption = {
	            center: new kakao.maps.LatLng("${sessionScope.userLoginInfo.getLocX()}", "${sessionScope.userLoginInfo.getLocY()}"), // 지도의 중심좌표
	            level: 1
	        };
	
	    var map = new kakao.maps.Map(mapContainer, mapOption);
	    var geocoder = new kakao.maps.services.Geocoder();
	
	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
	    function searchAddrFromCoords(coords, callback) {
	        geocoder.coord2RegionCode(coords.getLng(), coords.getLat(),
	            callback);
	    }

	    /* city,do name + gu name*/
	    function displayCenterInfo(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            var infoDiv = document.getElementById('centerAddr');
	            for (var i = 0; i < result.length; i++) {
	                if (result[i].region_type === 'H') {
	                    infoDiv.innerHTML = result[i].region_1depth_name + " " + result[i].region_2depth_name;
	                    break;
	                }
	            }
	        }
	    }
</script>
	<!-- Top Menu -->


	<div class="bodyWrapper">