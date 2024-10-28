var autoMode = 0;

$(document).ready(function() {
	
	$('#manualModeButton').removeClass();
	$('#autoModeButton').removeClass();

	if (getCookie("state") == 0) {
		$.ajax({
			url : 'control_run',
			type : 'POST',
			success : function(data) {
				var success = document.querySelector(".controlDetailRow");
				success.innerHTML = data;
				setCookie("state", 0);
				closeRunPopup();
			}
		})
	} else {
		$.ajax({
			url : 'control_stop',
			type : 'POST',
			success : function(data) {
				var success = document.querySelector(".controlDetailRow");
				success.innerHTML = data;
				setCookie("state", 1);
				closeStopPopup();
			}
		});
	}
	if (getCookie("state_mode") == 0) {
		$('.controlDetailContainer').load("./control_autoMode");
		$('#autoModeButton').addClass('modeButtonSelected');
		$('#manualModeButton').addClass('modeButtonUnselected');
	} else {
		$('.controlDetailContainer').load("./control_manualMode");
		$('#autoModeButton').addClass('modeButtonUnselected');
		$('#manualModeButton').addClass('modeButtonSelected');
	}
	// 기본제어
	$("#normalControlButton").on("click", function() {

		// 3개 버튼 다 선택해제
		$('#operationSetting').removeClass();
		$('#normalControlButton').removeClass();
		$('#engineer').removeClass();
		$('#operationSetting').addClass('controlMenuUnselected');
		$('#normalControlButton').addClass('controlMenuSelected');
		$('#engineer').addClass('controlMenuUnselected');
		$('.controlDetailOptionButtonBox').css("display", "flex");

		$('#autoModeButton').removeClass();
		$('#manualModeButton').removeClass();

		if (getCookie("state_mode") == 0) {
			$('.controlDetailContainer').load("./control_autoMode");
			$('#autoModeButton').addClass('modeButtonSelected');
			$('#manualModeButton').addClass('modeButtonUnselected');
		} else {
			$('.controlDetailContainer').load("./control_manualMode");
			$('#autoModeButton').addClass('modeButtonUnselected');
			$('#manualModeButton').addClass('modeButtonSelected');
		}

	});

	// 운용 설정
	$("#operationSetting").on("click", function() {

		$('#operationSetting').removeClass();
		$('#normalControlButton').removeClass();
		$('#engineer').removeClass();

		$('#operationSetting').addClass('controlMenuSelected');
		$('#normalControlButton').addClass('controlMenuUnselected');
		$('#engineer').addClass('controlMenuUnselected');
		$('.controlDetailContainer').load("./control_operationSetting");
		$('.controlDetailOptionButtonBox').css("display", "none");
	});

	// 엔지니어
	$("#engineer").on("click", function() {

		$('#operationSetting').removeClass();
		$('#normalControlButton').removeClass();
		$('#engineer').removeClass();

		$('#operationSetting').addClass('controlMenuUnselected');
		$('#normalControlButton').addClass('controlMenuUnselected');
		$('#engineer').addClass('controlMenuSelected');
		$('.controlDetailContainer').load("./control_engineer");
		$('.controlDetailOptionButtonBox').css("display", "none");
	});

	// $('#manualModeButton').on('click', function() {
	// $('#autoModeButton').removeClass();
	// $('#manualModeButton').removeClass();
	//
	// $('#autoModeButton').addClass('modeButtonUnselected');
	// $('#manualModeButton').addClass('modeButtonSelected');
	// $(".controlDetailControlBox").load("./control_manualMode.php");
	//
	// });

	// $('#autoModeButton').on('click', function() {
	// $('#autoModeButton').removeClass();
	// $('#manualModeButton').removeClass();
	//
	// $('#manualModeButton').addClass('modeButtonUnselected');
	// $('#autoModeButton').addClass('modeButtonSelected');
	// $(".controlDetailControlBox").load("./control_autoMode.php");
	// });
});

/* password Modal */
function openPwModal() {
	$('.pwModal').fadeIn(500);
}

function closePwModal() {
	$('.pwModal').fadeOut(500);
}

function resetMode() {
	var re_open = false;
	$.ajax({
		// type : "POST",
		url : "control_url.do",
		data : {
			UPwd : "${UPwd}"
		},
		error : function(error) {
			console.log("error");
		},
		success : function(data) {
			if (document.form1.password.value != data)
				alert("비밀번호가 다릅니다");
		}

	});

}
var setCookie = function(name, value) {
	var date = new Date();
	date.setTime(date.getTime() + 1000 * 60 * 60 * 24 * 30); // cookie 10분 지속
	document.cookie = name + '=' + value + ';expires=' + date.toUTCString()
			+ ';path=/';
};

var getCookie = function(name) {
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value ? value[2] : null;
};
