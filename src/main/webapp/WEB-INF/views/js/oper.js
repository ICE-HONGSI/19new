$(document).ready(function(){
  $(".operRight").load("./oper_bmsCall");
  $('.bms').attr('id', 'operAct');
});
$(function() {
  $("#bmsCall").on("click", function() {
    $('#pcsDetail li a, #metaDetail li a').removeAttr( "id" )
    $("#pcsDetail, #metaDetail").css("display", "none");
    $(".operRight").load("./oper_bmsCall");
    $('.operLeft ul li').removeAttr( "id" )
    $('.bms').attr('id', 'operAct');
  });
  $("#pcsCall").on("click", function() {
	 
    $('#metaDetail li a').removeAttr( "id" )
    $("#metaDetail").css("display", "none");
    $("#pcsDetail").toggle();
    $('.operLeft ul li').removeAttr( "id" )
    $('.pcs').attr('id', 'operAct');
  });
 /* $(".pcsCall01").on("click", function() {
    $(".operRight").load("./oper_pcsCall01.php");
    $('#pcsDetail li a').removeAttr( "id" )
    $('.pcsCall01').attr('id', 'pcsSelected');
  });
  $(".pcsCall02").on("click", function() {
    $(".operRight").load("./oper_pcsCall02.php");
    $('#pcsDetail li a').removeAttr( "id" )
    $('.pcsCall02').attr('id', 'pcsSelected');
  });
  $("#metaCall").on("click", function() {
    $('#pcsDetail li a').removeAttr( "id" )
    $("#pcsDetail").css("display", "none");
    $("#metaDetail").toggle();
    $('.operLeft ul li').removeAttr( "id" )
    $('.meta').attr('id', 'operAct');
  });
  $(".metaCall01").on("click", function() {
    $(".operRight").load("./oper_metaCall01.php");
    $('#metaDetail li a').removeAttr( "id" )
    $('.metaCall01').attr('id', 'metaSelected');
  });
  $(".metaCall02").on("click", function() {
    $(".operRight").load("./oper_metaCall02.php");
    $('#metaDetail li a').removeAttr( "id" )
    $('.metaCall02').attr('id', 'metaSelected');
  });*/
  $("#systemInfo").on("click", function() {
    $('#pcsDetail li a, #metaDetail li a').removeAttr( "id" )
    $("#pcsDetail, #metaDetail").css("display", "none");
    $(".operRight").load("./oper_systemInfo");
    $('.operLeft ul li').removeAttr( "id" )
    $('.system').attr('id', 'operAct');
  });
  $("#eventList").on("click", function() {
    $('#pcsDetail li a, #metaDetail li a').removeAttr( "id" )
    $("#pcsDetail, #metaDetail").css("display", "none");
    $(".operRight").load("./oper_eventList");
    $('.operLeft ul li').removeAttr( "id" )
    $('.event').attr('id', 'operAct');
  });
});



