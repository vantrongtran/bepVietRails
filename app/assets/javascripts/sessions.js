$("form#login-box").bind("ajax:success", function(e, data, status, xhr) {
  if (data.success) {
    $('#sign_in').modal('hide');
    $('#sign_in_button').hide();
    return $('#submit_comment').slideToggle(1000, "easeOutBack");
  } else {
    return alert('failure!');
  }
});
