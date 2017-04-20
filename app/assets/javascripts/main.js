function sendRequestScript(link, method){
  $.ajax({
    type: method,
    url: link,
    dataType: "script",
    success: function(data){
    },
    error: function(errorMessage){
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
    case "success":
      icon = "done";
      break;
    case "warning":
      icon = "warning";
      break;
    case "danger":
      icon = "error_outline";
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

$(document).ready(function() {
  $("a").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
  $(".nodeExample1").hover(function(e){

  }, function(e){

  });
});
