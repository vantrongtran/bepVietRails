function show_form_edit_post(){
  $("#modal-edit-post").modal({
    ready: function(modal, trigger) {
    },
    complete: function() {
    }
  });
  hashtagReady();
  $("#modal-edit-post").modal("open");
}
