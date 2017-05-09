function addConditionDetails(inputName,html) {
  add = $("select[detailname='" + inputName + "']").closest(".div-condition-detail").find(".condition_details");
  add.html(html);
}
function addCondition(target = -1){
  var clone, length;
  try{
    clone = $(target).find(".div-condition-detail.template:first").clone();
    length = $(target).find(".div-condition-detail").length;

  }catch(e){
    clone = $(".div-condition-detail.template:first").clone();
    length = $(".div-condition-detail").length
  }
  clone.find("button.btn-danger.display-none").removeClass("display-none");
  clone.find(".condition").find("select").attr("detailname", clone.find(".condition").find("select").attr("detailname").replace(/(\d+)(?!.*\d)/, length));
  clone.find("select#condition_detail-select").attr("name", clone.find("select#condition_detail-select").attr("name").replace(/(\d+)(?!.*\d)/, length));
  clone.find("select#condition_detail-select").html("");
  clone.find("input[type=checkbox]").attr("name", clone.find("input[type=checkbox]").attr("name").replace(/(\d+)(?!.*\d)/, length));
  try{
    $(target).append(clone);
  }catch(e){
    if (target === -1) {
      $(".div-condition-details").append(clone);
    }
  }
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
  checkboxReady()
}

function removeCondition(element){
  target = $(element).closest(".div-condition-details");
  asElement = ".div-condition-detail";
  removeParent(element, asElement);
  index = 0;
  $(target).find(asElement).each(function(index, e){
    $(e).find("select").each(function(i, input){
      try {
        $(input).attr("detailname", $(input).attr("detailname").replace(/(\d+)(?!.*\d)/, index));
      }
      catch(err) {
      }
      try {
        $(input).attr("name", $(input).attr("name").replace(/(\d+)(?!.*\d)/, index));
      }
      catch(err) {
      }
    });
    $(e).find("input[type=checkbox]").each(function(i, input){
      try {
        $(input).attr("name", $(input).attr("name").replace(/(\d+)(?!.*\d)/, index));
      }
      catch(err) {
      }
    });
    index++;
  });
}

function addConditionGroup(){
  length = $(".conditions-groups").find(".conditions-group").length
  groupClone = $(".conditions-groups").find(".conditions-group.template:first").clone();
  clone = groupClone.find(".div-condition-detail.template:first").clone();
  groupClone.find(".div-condition-detail.template:first")
    .find("select#condition_detail-select").html("");
  groupClone.find(".div-condition-detail.template:first")
    .find(".condition").find("select").attr("detailname", clone.find(".condition").find("select").attr("detailname").replace(/\d+/, length));
  groupClone.find(".div-condition-detail.template:first")
    .find("select#condition_detail-select").attr("name", clone.find("select#condition_detail-select").attr("name").replace(/\d+/, length));
  groupClone.find(".div-condition-detail:not(:first)").remove();
  groupClone.find(".div-condition-details").attr("id", groupClone.find(".div-condition-details").attr("id").replace(/\d+/, length));
  buttonAdd = groupClone.find("button.btn-addCondition");
  groupClone.find("button.btn-addCondition").attr("onclick", buttonAdd.attr("onclick").replace(/\d+/, length));
  $(groupClone).find("input").each(function(i, input){
    try {
      $(input).attr("name", $(input).attr("name").replace(/\d+/, length));
    }
    catch(err) {
    }
  });

  $(".conditions-groups").append(groupClone);
  $("button").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
  checkboxReady();
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
