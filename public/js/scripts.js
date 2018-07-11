$(document).ready(function() {

  $("form#login").submit(function(event) {
    event.preventDefault()
    $("#mainNavBar").hide()
  });

});
