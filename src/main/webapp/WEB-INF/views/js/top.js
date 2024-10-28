$(function(){
  var CurrentFileName = document.URL.substring(document.URL.lastIndexOf("/") + 1, document.URL.lastIndexOf("/") + 30);
  CurrentFileName = CurrentFileName.split('?')[0]//split('.')으로 하면 트렌드 검색시 selected class가 적용되지 않아서 ('?')로 split
  var Clength = CurrentFileName.length-1;
  if(CurrentFileName[Clength]=="#"){
	  CurrentFileName = CurrentFileName.slice(0,Clength);
  }
  
  console.log(CurrentFileName);
  
  $('#'+CurrentFileName).removeClass();
  $('#'+CurrentFileName).addClass('selected');
})

function locationRedir(a){location.href=a;}