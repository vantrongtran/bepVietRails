function search_ingredient(url){
  key = $("#ingredient").val();
  if(key) {
    $.ajax({
      type: "GET",
      url: url + "?ingredient=" + key,
      dataType: "script",
      success: function(data){
      },
      error: function(){
        console.log("error");
      }
    });
  }
  else {
    $("#ingredient_items").hide();
  }
}
$( document ).ready(function() {
  $("#ingredient_items").hide();
  $("body").on("click", ".close", function() {
    $(this).parents(".result_ingredient").remove();
  });
});

function addIngredient(selector, id){
  if (!$("#ingredient_add_" + id).length) {
    var element = document.getElementById(id);
    var img_src = selector.getElementsByTagName('img')[0].src;
    var name = selector.getElementsByTagName('a')[0].innerHTML;
    var html = "<div class='result_ingredient' id=ingredient_add_" + id + ">"
                + "<input type='hidden' name='food[ingredients][" + id + "][ingredient_id]' value='" + id + "'>"
                + "<button type='button' class='close'>"
                + "<i class='material-icons'>clear</i></button>"
                + "<div class='ingredient_image'>"
                + "<img class='ingredient_image' src=" + img_src + "></div>"
                + "<div class='ingredient_detail'>"
                + "<a>" + name + "</a>"
                + "<div class='form-group is-empty'><input type='number' name='food[ingredients][" + id + "][ingredient_value]' id='value' class='form-control' step='0.1' placeholder='Value' required><span class='material-input'></span></div>"
                + "</div></div>";
    $("#ingredient_added").append(html);
  }
  $(selector).closest(".ingredient_items").find("#ingredient_items").hide();
}

function show_form_edit_food(){
  $("#modal-edit-food").modal({
    ready: function(modal, trigger){
    }
  });
  $("#modal-edit-food").modal("open");
}
