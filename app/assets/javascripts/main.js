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
    timer: 4000,
    placement: {
      from: "top",
      align: "right"
    }
  });
}

$(document).ready(function() {
  $("a").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
});
