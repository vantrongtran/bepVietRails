function openModalEditCategory(category_id, category_name, path){
  $("#form-edit-category").attr("action", path);
  $("#category-old-name").html(category_name);
  $("input#category-edit-id").val(category_id);
  $("input#category-edit-name").val("");
  $('#category-edit-modal').modal('show');
}
function openModalNewCategory(parent_id, parent_name){
  $("#category-parent-name").html(parent_name);
  $("input#category-parent-id").val(parent_id);
  $('#category-new-modal').modal('show');
}
