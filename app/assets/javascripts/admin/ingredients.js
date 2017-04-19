function call_form_edit(url){
  $.ajax({
    type: "GET",
    url: url,
    dadaType: "script",
    success: function(){
    },
    error: function(){
    }
  });
}

function show_form_edit_ingredient(){
  $("#modal-edit-ingredient").modal({
    ready: function(modal, trigger){
    }
  });
  $("#modal-edit-ingredient").modal("open");
}
