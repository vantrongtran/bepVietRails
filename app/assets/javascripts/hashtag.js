$(document).ready(function() {
  $(".autocomplete-suggestion").hide();
  $("form input[name='hashtag']").keypress(function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
      e.preventDefault();
      return false;
    }
  });
});

function getHastagHTML(name, inputName, value){
  result ="<span class='hashtag' id='hashtag-id-" + name + "'><span>"
         + name
         + "<input type='hidden' name='" + inputName + "' value='" + value + "'></span>"
         + "<i class='remove-tag-icon' onclick="
         + '"removeParent(this, '+ "'.hashtag'" + ',revertIndexInputHastag)">&times;</i></span>';
  return result;
}

function revertIndexInputHastag(){
  revertIndexInput(".autocomplete", ".hashtag", "input[type=hidden][name*='[hashtags_attributes]']");
  revertIndexInput(".autocomplete", ".hashtag", "input[type=hidden][name*='[hashtag_id]");
}

function searchHashtag(element, event){
  key = $(element).val().trim();
  parent = $(element).closest(".autocomplete");
  var keyCode = event.which || event.keyCode;
      console.log(keyCode);
  if (keyCode == 13) {
    if ($(element).closest(".autocomplete").find("#hashtag-span-" + key).length > 0) {
      selectHashtag($(element).closest(".autocomplete").find("#hashtag-span-" + key));
      $(element).val("");
    }
    else if(key.length > 0 && !key.includes(" ")){
      name = parent.find(".suggestion-name-sub").text()+ "[hashtags_attributes]" + "[" + parent.find("input[type=hidden][name*='[hashtags_attributes]']").length + "][name]";
      result = getHastagHTML(key, name, key);
      parent.append(result);
    }
    parent.find("input[name='hashtag']").val("");
    $(".autocomplete-suggestion").hide();
  }
  else if(key.length > 0) {
    loading();
    $.ajax({
      type: "GET",
      url: "/hashtags?hashtag=" + key,
      dataType: "script",
      success: function(data){
        loaded();
      },
      error: function(){
        loaded();
        console.log("error");
      }
    });
  }
}

function selectHashtag(spanElement){
  returnValue = false;
  if ($("#hashtag-id-" + $(spanElement).text().trim()).length == 0) {
    parent = $(spanElement).closest(".autocomplete");
    name = parent.find(".suggestion-name").text() + "[" + parent.find("input[type=hidden][name*='[hashtag_id]']").length + "][hashtag_id]";
    result = getHastagHTML($(spanElement).text().trim(), name, $(spanElement).attr("value"));
    parent.append(result);
    parent.find("input[name='hashtag']").val("");
    returnValue = true;
  }
  $(".autocomplete-suggestion").hide();
  return returnValue;
}
