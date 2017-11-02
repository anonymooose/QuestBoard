if (window.location.pathname === "/") {
  $("#dashboard").show(0);
}
$(".toggleit").click(function(){
  $("#dashboard").slideToggle();
});
