$( document ).ready(function() {
  $("#login-box").bind("ajax:success", function(e, data, status, xhr) {
    if (data.success) {
      location.reload();
      return $('#submit_comment').slideToggle(1000, "easeOutBack");
    } else {
      shakeModal(data.errors);
    }
  });
});

function shakeModal(errors){
  $('#loginModal .modal-dialog').addClass('shake');
  $('.error').addClass('alert alert-danger').html(errors);
  $('input[type="password"]').val('');
  setTimeout( function(){
    $('#loginModal .modal-dialog').removeClass('shake');
  }, 1000 );
}
