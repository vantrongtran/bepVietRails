function sendRequestScript(link, method){
  loadnig();
  $.ajax({
    type: method,
    url: link,
    dataType: "script",
    success: function(data){
      loaded();
    },
    error: function(errorMessage){
      loaded();
    }
  });
}

function redirectTo(url){
  window.location.href = url;
}

function showNotification(type, message){
  icon = "notifications";
  switch(type) {
    case "info":
      icon = "info_outline";
      break;
    case "notice":
      icon = "info_outline";
      type = "info";
      break;
    case "success":
      icon = "done";
      break;
    case "warning":
      icon = "warning";
      break;
    case "danger":
      icon = "error_outline";
      break;
    case "error":
      icon = "error_outline";
      type = "danger";
      break;
    case "primary":
      icon = "notifications";
      break;
    default:
      icon = "notifications";
  }
  $.notify({
    icon: icon,
    message: message
  },{
    type: type,
    timer: 1000,
    placement: {
      from: "top",
      align: "right"
    }
  });
}

function configCKEditor(){
  CKEDITOR.editorConfig = function(config){
    config.toolbar = [
      {name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFormWord', '-', 'Undo', 'Redo']},
      {name: 'editing', items: ['Scayt']},
      {name: 'links', items: ['Link', 'Unlink', 'Anchor']},
      {name: 'insert', items: ['Image', 'Table', 'HorizontaRule', 'SpecialChar']},
      {name: 'tool', items: ['Maximize']},
      {name: 'document', items: ['Source']}
    ];
  };
  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      CKEDITOR.replace(data[i].id)
    });
  }
}

function removeParent(element, parent, callback = function(){console.log("None callback!!!");}){
  $(element).closest(parent).remove();
  callback();
}
function removeServer(element, parent, callback = function(){console.log("None callback!!!");}){
  $(element).closest(parent).hide();
  $(element).closest(parent).find("input[type=hidden][name*='[_destroy]']").prop('disabled', false);;
  callback();
}


function revertIndexInput(collectionGroup, asElement){
  index = 0;
  $(collectionGroup).find(asElement).each(function(index, element){
    $(element).find("input").each(function(i, input){
      try {
        selector.attr("id", selector.attr("id").replace(/\d/, index));
        selector.attr("name", selector.attr("name").replace(/\d/, index));
      }
      catch(err) {
      }
    });
    index++;
  });
}
function revertIndexInput(collectionGroup, asElement, groupBy){
  index = 0;
  $(collectionGroup).find(asElement).each(function(index, element){
    $(element).find("groupBy").each(function(i, input){
      try {
        selector.attr("id", selector.attr("id").replace(/\d/, index));
        selector.attr("name", selector.attr("name").replace(/\d/, index));
      }
      catch(err) {
      }
    });
    index++;
  });
}

function loading(){
  $(".loading").show();
}

function loaded(){
  $(".loading").hide();
}

function confrimMaterial(contentText, okAction, cancelAction = function(){console.log("none cancelAction");}){
  $.confirm({
    title: 'Confirm',
    icon: 'fa fa-question',
    theme: 'material',
    closeIcon: true,
    animation: 'scale',
    type: 'purple',
    content: contentText,
    buttons: {
      confirm: {
        text: 'OK',
        btnClass: 'btn btn-primary',
        action: function () {
          okAction();
        }
      },
      cancel: {
        text: 'Cancel',
        btnClass: 'btn btn-default',
        action: function () {
          cancelAction();
        }
      }
    },
  });
}
$(document).ready(function() {
  $("a").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
  $("a.data-confirm").click(function(e){
    e.preventDefault();
    confrimMaterial(
      $(e.target).attr("confirmcontent"),
      function(){
        $("a.data-confirm").unbind('click');
        $(e.target).click();
        loading();
      }
    );
    return false;
  });
  $("a:not(.data-confirm)").click(function(e){
    loading();
  });
  $("form:not([data-remote='true'])").submit(function(e){
    loading();
  });
});
