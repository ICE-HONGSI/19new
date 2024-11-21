<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<c:import url="/top" />

<SCRIPT LANGUAGE="JavaScript">
    var monthName = new Array("1","2","3","4","5","6","7","8","9","10","11","12")
    var monthDays = new Array(31,28,31,30,31,30,31,31,30,31,30,31)
    var now = new Date();
 
    var nowd = now.getDate()
    var nowm = '${month}';
    var nowy ='${year}';
    var startDate ='${startDate}';
   var sdate="0";
   for(var i=1; i<=31; i++){
      if(i<10) sdate="0"+i;
      else sdate=i;
      if(sdate==startDate.substring(8,10))
         break;        
   }  
   sdate=Number(sdate);
   if(startDate==""){
      sdate=1;
   }
    var mCharge = '${mCharge}';
    mCharge=0.001*mCharge;
   
    var mDischarge = '${mDischarge}';
    mDischarge=0.001*mDischarge;
   
    var dResultStr='${dResultStr}';

    var dateResult=new Array(31);
    var dateProfit=new Array(31);
    
    //일별 수익계산
    var profitStr ='${profitStr}';
    var totProfit = '${totProfit}'; 
   
    function profitSum(num1, num2){
       num1= parseFloat(num1);
       num2= parseFloat(num2);
       return num1+num2;
    }
    
    //figureDiv 값
    var smp = '${smp}';
    var rec = '${rec}';
    var pv_multi = '${pv_multi}';
    var ess_multi = '${ess_multi}';
    
    
    function calDateProfit(){
       if(profitStr!=""){
          var eachDate = profitStr.split("@");
          var i=0;
          while(i<eachDate.length-1){
             dateProfit[i]=eachDate[i].split("/");
             i++;
          }
       }
    }
    
    function getDateProfit(day,info){
       //day 은 일별 변수, info는 정보 (ex.ess=0, sun=1) 변수
       if(day<profitStr.split("@").length-1)
          return dateProfit[day][info];
       else
          return "0";
    }
    

    function calDateCharge(){
       if(dResultStr!=""){
          var eachDate = dResultStr.split("@");
          var i=0;
          while(i<eachDate.length-1){
             dateResult[i]=eachDate[i].split("/");
             i++;
          }
       }
    }
    
    function getDateCharge(day,info){
       //day 은 일별 변수, info는 정보 (ex.충전량=0, 방전량=1, 발전량=2) 변수
       if(day<dResultStr.split("@").length-1)
          return dateResult[day][info];
       else
          return "0";
    }
  
    function goSubmit(){  
        var form = document.createElement("form");
         form.setAttribute("action","/pms/report");
         form.setAttribute("method","get");
         form.setAttribute("type","hidden");
         
         var yearInput = document.createElement("input");
         yearInput.setAttribute("type","hidden");
         yearInput.setAttribute("name","year");
         yearInput.setAttribute("value",nowy);
         
         var monthInput = document.createElement("input");
         monthInput.setAttribute("type","hidden");
         monthInput.setAttribute("name","month");
         monthInput.setAttribute("value",nowm);
    
         form.appendChild(yearInput);
         form.appendChild(monthInput);
         
         document.body.appendChild(form);
         
         form.submit();
     }
     
    
    function showProfit(id){
       var profitId="profitId"+id;
       var profitSumId="profitSumId"+id;
       
       var sum=document.getElementById(profitSumId).innerHTML;
       if(sum!="0"){
           document.getElementById(profitId).style.display='block';
       }
       
    }
    
    function hideProfit(id){
       var profitId="profitId"+id;
       document.getElementById(profitId).style.display='none';

    }
    
    function showCalendar(day,month,year) {
     calDateCharge();
     calDateProfit();
      
     if ((year%4 == 0 || year%100 == 0) && (year%400 == 0)) monthDays[1]=29;
     else monthDays[1]=28

      var firstDay=new Date(year,month-1,1).getDay()
      var calStr="<div id='calendar'>"
      calStr+="<ul class='calendarTop'>"
      calStr+="<li id='monthChange'><p>"+year+"</p>"
      calStr+="<p><a class='yearMonth' href='javascript:;' onClick='nowm--; if (nowm<=0) { nowy--; nowm=12; } goSubmit(); '>&lt;</a>"
      calStr+="<span id='largeMonth'>"+monthName[month-1]+"</span>"
      calStr+="<a class='yearMonth' href='javascript:;' onClick='nowm++; if (nowm>12) { nowy++; nowm=1; } goSubmit();'>&gt;</a></p></li>"
      calStr+="<li id='monthTotal'><span class='totProfit'>월 총수익</span><span class='totProValue'>"+numberWithCommas(totProfit)+"</span><span class='totWon'>원</span></li>"    
      calStr+="<li></li>"
      calStr+="<li></li>"
      calStr+="<li></li>"
      calStr+="<li></li>"
      calStr+="<li>"
      calStr+="<div class='buttonDiv'><input type='button' class='excelButton' onclick='goExcel()'><input type='button' class='profitButton' onclick='openPopup()'></div>"
      calStr+="<div class='figureDiv'><span>SMP</span><span class='figValue'>"+smp+"</span><span>원</span><span class='bar'> | </span>"
      calStr+="<span>REC</span><span class='figValue'>"+rec+"</span><span>원 </span><span class='bar'> | </span>"
      calStr+="<span>태양광가중치</span><span class='figValue'>"+pv_multi+"</span><span>배수</span><span class='bar'> | </span>"      
      calStr+="<span>ESS가중치</span><span class='figValue'>"+ess_multi+"</span><span>배수</span></div>"
      calStr+="</li>"
      calStr+="</ul>"

      var dayCount=1
      var rowCount=1
      var lastEmpty = 7 - (firstDay + monthDays[month-1])%7

      calStr+="<ul class='days'>"

      for (var i=0; i<firstDay; i++) calStr+="<li class='day'><div class='date'></div></li>"  //앞 공백
      for (var i=0; i<monthDays[month-1]; i++)
      { 
        if(year>now.getFullYear() || (year==now.getFullYear() && month>now.getMonth() && i> now.getDate()-1) || (year==now.getFullYear() && month>now.getMonth()+1) ){
            calStr+="<li class='day'><div class='date'>"+(dayCount++)+"</div>"
            calStr+="<div class='dayData'><div class='dayDataWrapper'><p class='dayDataLeft'></p><p class='dayDataRight'><span class='red'></span><span class='value'></span></p></div>"
            calStr+="<div class='dayDataWrapper'><p class='dayDataLeft'></p><p class='dayDataRight'><span class='green'></span><span class='value'></span></p></div>"
            calStr+="<div class='dayDataWrapper'><p class='dayDataLeft'></p><p class='dayDataRight'><span class='yellow'></span><span class='value'></span></p></div></div></li>"
        }
        else{
           if(i<sdate-1){
              calStr+="<li class='day'><div class='date'>"+(dayCount++)+"</div>"
                calStr+="<div class='dayData'><div class='dayDataWrapper'><p class='dayDataLeft'>발전량</p><p class='dayDataRight'><span class='yellow'>0</span><span class='value'>kWh</span></p></div>"
                calStr+="<div class='dayDataWrapper'><p class='dayDataLeft'>충전량</p><p class='dayDataRight'><span class='green'>0</span><span class='value'>kWh</span></p></div>"
                calStr+="<div class='dayDataWrapper'><p class='dayDataLeft'>방전량</p><p class='dayDataRight'><span class='red'>0</span><span class='value'>kWh</span></p></div>"
                calStr+="<div class='dayDataWrapper'><p class='dayDataLeft' >발전수익</p><p class='dayDataRight'><span class='value'>0원</span></p></div></div>"
           }
           else{
              var dayIndex = i-sdate+1;
              calStr+="<li class='day'><div class='date'>"+(dayCount++)+"</div>"
                calStr+="<div class='dayData'><div class='dayDataWrapper'><p class='dayDataLeft'>발전량</p><p class='dayDataRight'><span class='yellow'>"+getDateCharge(dayIndex,2)+"</span><span class='value'>kWh</span></p></div>"
                calStr+="<div class='dayDataWrapper'><p class='dayDataLeft'>충전량</p><p class='dayDataRight'><span class='green'>"+getDateCharge(dayIndex,0)+"</span><span class='value'>kWh</span></p></div>"
                calStr+="<div class='dayDataWrapper'><p class='dayDataLeft'>방전량</p><p class='dayDataRight'><span class='red'>"+getDateCharge(dayIndex,1)+"</span><span class='value'>kWh</span></p></div>"
                calStr+="<div class='dayDataWrapper'><p class='dayDataLeft' >발전수익</p><p class='dayDataRight'><span id='profitSumId"+dayIndex+"' class='white' onmouseover='showProfit("+dayIndex+")' onmouseout='hideProfit("+dayIndex+")'>"+numberWithCommas(profitSum(getDateProfit(dayIndex,0),getDateProfit(dayIndex,1)))+"</span><span class='value'>원</span></p></div></div>"
                calStr +="<div id='profitId"+dayIndex+"' class='profitChild'><p class='profitLeft'>태양광수익<br><span class='profitValue'>"+numberWithCommas(getDateProfit(dayIndex,1))+"<span class='won'>원</span></span></p><br><p class='profitLeft'>ESS수익<br><span class='profitValue'>"+numberWithCommas(getDateProfit(dayIndex,0))+"<span class='won'>원</span></span></p></div></li>"
           }
        }
           
        if ((i+firstDay+1)%7 == 0 && (dayCount < monthDays[month-1]+1)) {
            calStr+="</ul><ul class='days'>"
            rowCount++
        }
      }
      if (rowCount == 6) {
           calStr = calStr.replace(/'day'/gi, "'day6'");
      }  
      if (rowCount == 4) {
           calStr = calStr.replace(/'day'/gi, "'day4'");
      }

      if (lastEmpty != 7) {
           rowCount++
        for (var i=0; i<lastEmpty; i++) calStr+="<li class='day'><div class='date'></div></li>" //뒤 공백
      }

      if (rowCount == 7) {
        calStr = calStr.replace(/'day'/gi, "'day6'");
      }

      var totCells=firstDay+monthDays[month-1]
      for (var i=0;i<(totCells>28?(totCells>35?42:35):28)-totCells;i++) calStr+="<td> "

      calStr+="</ul></div>" 
      calendarSub.innerHTML=calStr

    }
    
    function openPopup(){
       $('.detailPopup').fadeIn(500);
    }
    function closePopup(){
        $('.detailPopup').fadeOut(500);
        
    }
    
    function goExcel(){
       var strSdate = sdate;
       location.href="excel?year="+nowy+"&month="+nowm+"&sdate="+strSdate;
    }
    
    function numberWithCommas(x) {
        return parseInt(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    function check() {

        if(profitForm.smp.value == ""||profitForm.rec.value == ""||profitForm.sunWeight.value == ""||profitForm.ess_multi.value == ""||profitForm.smp.value == null||profitForm.rec.value == null||profitForm.sunWeight.value == null||profitForm.ess_multi.value == null) {

          alert("모든값을 입력해 주세요.");
          return false;    
        }
        if(!$.isNumeric(profitForm.smp.value)||!$.isNumeric(profitForm.rec.value)||!$.isNumeric(profitForm.sunWeight.value)||!$.isNumeric(profitForm.ess_multi.value)){
         alert("숫자를 입력해 주세요.");
           return false;
        }
        else 
           return true;

      }

  </SCRIPT>

<div class="reportDetail">
   <div class="reportSubWrapper">
      <div class="reportTitle">
         <span>운영 리포트</span>
      </div>
      <div id="calendarSub"></div>
   </div>
</div>

<div class="detailPopup">
   <div class="profitPopup">
      <p style="font-weight: bold; font-size: 23px; opacity: 0.8">수익계산기</p>
      <form id="profitForm" onsubmit="return check();" name="profitForm"
         style="margin-inline-start: 1em; margin-block-start: 3em; margin: 0, auto; width: 600px"
         method="GET" action="/pms/reportUpdate">
         <a class="closeDetailInfo" onclick="closePopup()" href="#"><img
            src="./img/report/svg/closemodal.svg" /></a>
         <div class="profitDiv">
            <span class="popupInput" style="margin-right: 50px;">SMP</span><input
               style="color: #ffffff; opacity: 1" class="popuptext" type="text"
               name="smp" value="${smp}"><span class="popupUnit">원</span>
         </div>
         <div class="profitDiv">
            <span class="popupInput" style="margin-right: 53px;">REC</span><input
               style="color: #ffffff; opacity: 1" class="popuptext" type="text"
               name="rec" value="${rec}"><span class="popupUnit">원</span>
         </div>
         <div class="profitDiv">
            <span class="popupInput">태양광 가중치</span><input
               style="color: #ffffff; opacity: 1" class="popuptext" type="text"
               name="sunWeight" value="${pv_multi}"><span
               class="popupUnit">배수</span>
         </div>
         <div class="profitDiv">
            <span class="popupInput" style="margin-right: 17px;">ESS 가중치</span><input
               style="color: #ffffff; opacity: 1" class="popuptext" type="text"
               name="ess_multi" value="${ess_multi}"><span
               class="popupUnit">배수</span>
         </div>
         <div class="profitDiv" style="float: right; margin-top: -10">
            <input class="popupSubmit"
               style="background-color: rgb(50, 50, 50); background-image: url(./img/report/svg/cancel2.svg)"
               onclick="closePopup()" type="button" value=""> <input
               class="popupSubmit" id="btn" type="submit" value="">
         </div>
      </form>
   </div>
</div>
<script language="JavaScript" type="text/JavaScript">
  showCalendar(nowd,nowm,nowy);
 // alert(dResultStr);
</script>
<c:import url="/bottom" />