function search_ingredient(selector, url){
  key = $(selector).val();
  if(key) {
    $(".ingredient_items_result").last().hide();
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
  $("#modal-add-food").on('show.bs.modal', function(e){
    $(".ingredient_items_result").html("");
    $(".ingredient_items_result").hide();
  });
});

function addIngredient(selector, id){
  if ($(selector).closest(".col-md-7").find("#ingredient_added").find("input[name*='[ingredient_id]'][value=" + id + "]").length == 0) {
    var element = document.getElementById(id);
    var img_src = selector.getElementsByTagName('img')[0].src;
    var name = selector.getElementsByTagName('a')[0].innerHTML;
    var index = $(selector).closest(".col-md-7").find("#ingredient_added").find(".result_ingredient").length;
    var html = "<div class='result_ingredient' id=ingredient_add_" + index + ">"
                + "<input type='hidden' name='food[food_ingredients_attributes][" + index + "][ingredient_id]' value='" + id + "'>"
                + "<button type='button' class='close' onclick=" + '"' + "removeIngredientAdded(this)" + '"' +">"
                + "<i class='material-icons'>clear</i></button>"
                + "<div class='ingredient_image'>"
                + "<img class='ingredient_image' src=" + img_src + "></div>"
                + "<div class='ingredient_detail'>"
                + "<a>" + name + "</a>"
                + "<div class='form-group is-empty'><input type='number' name='food[food_ingredients_attributes][" + index + "][value]' id='value' class='form-control' step='0.001' placeholder='Value' required><span class='material-input'></span></div>"
                + "</div></div>";
    $(selector).closest(".col-md-7").find("#ingredient_added").append(html);
  }
  addedIngredient = $(selector).closest(".col-md-7").find("#ingredient_added").find("input[value=" + id + "].destroy-ingredient");
  if (addedIngredient.length != 0 ) {
    addedIngredient.prop('disabled', true);
    addedIngredient.closest(".result_ingredient").show();
    addedIngredient.closest(".result_ingredient").find("input").each(function(element){
      addedIngredient.prop('disabled', true);
    });
  }
  $(selector).closest(".ingredient_items").find(".ingredient_items_result").hide();
}

function show_form_edit_food(){
  $("form input[name='hashtag']").keypress(function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
      e.preventDefault();
      return false;
    }
  });
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

function removeIngredient(element){
  $(element).closest(".result_ingredient").find("input").each(function(element){
    $(element).prop('disabled', true);
  });
  $(element).closest(".result_ingredient").find("input.destroy-ingredient").prop('disabled', false);
  $(element).closest(".result_ingredient").hide();
}

function removeIngredientAdded(element){
  $(element).closest(".result_ingredient").remove();
  removeIngredient($(element).closest("#ingredient_added"), ".result_ingredient");
}
