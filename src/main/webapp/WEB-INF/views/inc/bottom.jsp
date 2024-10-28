<%@ page contentType="text/html;charset=utf-8"%>
</div>
<!--Body Wrapper-->
<div class="bottomWrapper">
	<div class="bottomLeft">
		<div class="bottom_logo">
			<img class="bottomLeft" src="./img/top/ubnetsys.png" alt="(주)유비넷시스" />
		</div>
		<div class="bottom_logo_name">
			<span>(주)유비넷시스</span>
		</div>
	</div>
	<div class="bottomRight" onload="dptime()">
		<button class="bottom_button" id="logout"
			onclick="location.href='/pms/logout'"></button>
		<div class="bottom_date" id="daydate">
			<span class="date" id="date2"></span><span class="time" id="time"></span>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	function dpTime() {
		var now = new Date();
		year = now.getFullYear();
		month = now.getMonth() + 1;
		date = now.getDate();
		hours = now.getHours();
		minutes = now.getMinutes();
		seconds = now.getSeconds();
		if (month < 10) {
			month = "0" + month;
		}
		if (date < 10) {
			date = "0" + date;
		}
		if (hours > 12) {
			hours -= 12;
			ampm = "오후 ";
		} else {
			ampm = "오전 ";
		}
		if (hours < 10) {
			hours = "0" + hours;
		}
		if (minutes < 10) {
			minutes = "0" + minutes;
		}
		if (seconds < 10) {
			seconds = "0" + seconds;
		}
		document.getElementById("date2").innerHTML = year + "-" + month + "-" + date + " " + getTodayLabel() + " ";
		document.getElementById("time").innerHTML = ampm + hours + ":" + minutes + ":" + seconds;

	}

	function getTodayLabel() {

		var week = new Array('(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)');

		var today = new Date().getDay();
		var todayLabel = week[today];

		return todayLabel;
	}

	setTimeout(dpTime(), 1000);
	setInterval(dpTime, 1000);
</script>

</html>
