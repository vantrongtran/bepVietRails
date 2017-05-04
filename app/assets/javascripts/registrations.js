$( document ).ready(function() {
  $("#signup-box").bind("ajax:success", function(e, data, status, xhr) {
    if (data.success) {
      location.reload();
      return $('#submit_comment').slideToggle(1000, "easeOutBack");
    } else {
      console.log(data);
      shakeModal(data.errors[0]);
    }
  });
});
