function addConditionDetails(inputName,html) {
  add = $("select[detailname='" + inputName + "']").closest(".div-condition-detail").find(".condition_details");
  add.html(html);
}
function addCondition(){
  clone = $(".div-condition-detail.template:first").clone();
  clone.find("button.btn-danger.display-none").removeClass("display-none");
  clone.find(".condition").find("select").attr("detailname", clone.find(".condition").find("select").attr("detailname").replace(/\d/, $(".div-condition-detail").length));
  clone.find("select#condition_detail-select").attr("name", clone.find("select#condition_detail-select").attr("name").replace(/\d/, $(".div-condition-detail").length));
  clone.find("select#condition_detail-select").html("");
  clone.find("input[type=checkbox]").attr("name", clone.find("input[type=checkbox]").attr("name").replace(/\d/, $(".div-condition-detail").length));
  $(".div-condition-details").append(clone);
  $("button").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
  $('select#condition_details-select').change(function(e){
    if ($(e.target).val() != "") {
      loading();
      $.ajax({
        type: "GET",
        url: '/condition_details' + '?condition_id=' + $(e.target).val() + "&params_name=" + $(e.target).attr("detailname"),
        dataType: "script",
        success: function(data){
          loaded();
        },
        error: function(){
          loaded();
        }
      });
    }
  });
}

function removeCondition(element){
  removeParent(
    element,
    ".div-condition-detail",
    function(){
      index = 0;
      collectionGroup= ".div-condition-details";
      asElement = ".div-condition-detail";
      $(collectionGroup).find(asElement).each(function(index, e){
        $(e).find("select").each(function(i, input){
          try {
            $(input).attr("detailname", $(input).attr("detailname").replace(/\d/, index));
          }
          catch(err) {
          }
        });
        $(e).find("input[type=checkbox]").each(function(i, input){
          try {
            $(input).attr("name", $(input).attr("name").replace(/\d/, index));
          }
          catch(err) {
          }
        });
        index++;
      });
    }
    );
}
$(document).ready(function() {
  $('select#condition_details-select').change(function(e){
    if ($(e.target).val() != "") {
      loading();
      $.ajax({
        type: "GET",
        url: '/condition_details' + '?condition_id=' + $(e.target).val() + "&params_name=" + $(e.target).attr("detailname"),
        dataType: "script",
        success: function(data){
          loaded();
        },
        error: function(){
          loaded();
        }
      });
    }
  });
});
