function search_ingredient(selector, url){
  key = $(selector).val();
  console.log(key);
  if(key) {
    $.ajax({
      type: "GET",
      url: url + "?ingredient=" + key,
      dataType: "script",
      success: function(data){
        $("body").on("click", ".close", function() {
          $(this).parents(".result_ingredient").remove();
        });
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
  $("#modal-add-food").on('show.bs.modal', function(e){
    $(".ingredient_items_result").html("");
  });
});

function addIngredient(selector, id){
  if (!$(selector).closest(".col-md-7").find("#ingredient_added").find("#ingredient_add_" + id).length) {
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
                + "<div class='form-group is-empty'><input type='number' name='food[food_ingredients_attributes][" + id + "][value]' id='value' class='form-control' step='0.1' placeholder='Value' required><span class='material-input'></span></div>"
                + "</div></div>";
    $(selector).closest(".col-md-7").find("#ingredient_added").append(html);
  }
  $(selector).closest(".ingredient_items").find(".ingredient_items_result").hide();
}

function show_form_edit_food(){
  $("#modal-edit-food").modal({
    ready: function(modal, trigger) {
    },
    complete: function() {
    }
  });
  $("#modal-edit-food").find(".ingredient_items_result").hide();
  $( "#modal-edit-food" ).on('hidden.bs.modal', function(e){
     $("#edit_form").last().html("");
  });
  $("#modal-edit-food").modal("open");
}
