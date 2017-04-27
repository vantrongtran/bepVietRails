function call_form_edit(url){
  loading();
  $.ajax({
    type: "GET",
    url: url,
    dadaType: "script",
    success: function(){
      loaded();
    },
    error: function(){
      loaded();

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
