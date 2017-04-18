function modalConfrim(messages = "Are you sure??", callackYes = function(){}, callackNo = function(){}){
  try{
    $('#confirm-modal').remove();
  }catch(e){

  }
  html = '<div class="modal fade in" id="confirm-modal" tabindex="-1 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >'
       + '<div class="modal-dialog">'
       + '<div class="modal-content confirm-dialog">'
       + '<div class="modal-body"><div class="row">'
       + '<h2 class="confirm-text title">' + messages + '</2></div>'
       + '<div class="row"><div class="confirm-button pull-right">'
       + '<button class="btn btn-danger btn-round button-confrim-yes">Yes<div class="ripple-container"></div></button>'
       +  '<button class="btn btn-default btn-round button-confrim-cancel">No<div class="ripple-container"></div></button>'
       + '</div></div>';
  html += "</div></div></div></div>";
  $('.wrapper').append(html);
  modal = $('#confirm-modal');
  modal.find(".confirm-button").find(".button-confrim-yes").click(function(e){
    callackYes();
    modal.modal('hide');
    setTimeout(function(){
      modal.remove();
    }, 3000);
  });
  modal.find(".confirm-button").find(".button-confrim-cancel").click(function(e){
    callackNo();
    modal.modal('hide');
    setTimeout(function(){
      modal.remove();
    }, 3000);
  });
  modal.modal('show');
}
$(document).ready(function() {
  $(".click-confrim").click(function(e){
    e.preventDefault();
    modalConfrim($(e.target).attr("message"), function(){$(".click-confrim").unbind('click'); $(".click-confrim").trigger( "click" );},function(){console.log("cancel");});
  });
});
