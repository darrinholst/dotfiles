$(function() {
  setTimeout(function() {$(".AcctListData").show();}, 2000)

  $("#DisplayPassword").change(function() {
    setTimeout(function() {$("#Submit").trigger("click");}, 100);
  });
});
