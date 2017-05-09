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
  var queueWaitingSubmit = [];
  setInterval(function(){
    queueWaitingSubmit.forEach(function(e){
      $(e).closest("form").submit();
    });
    queueWaitingSubmit = [];
  }, 3000);
  $("a").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
  $("a.data-confirm").click(function(e){
    e.preventDefault();
    text = $(this).attr("confirmcontent");
    confrimMaterial(
      text,
      function(){
        $("a.data-confirm").unbind('click');
        $(e.target).click();
        loading();
      }
    );
    return false;
  });
  $("a:not(.data-confirm):not(.click-event)").click(function(e){
    if ($(e.target).attr("href")[0] != "#") {
      loading();
    }
  });
  $("form:not([data-remote='true'])").submit(function(e){
    loading();
  });

  $("input.keyup-submit").keyup(function(e){
    if (!queueWaitingSubmit.includes(e.target)){
      queueWaitingSubmit.push(e.target);
    }
  });

  $(".checkbox").each(function(i, e){
    checkbox = $(e).find("input[type=checkbox]");
    name = checkbox.attr("name");
    val = checkbox.val() == 'true';
    inputHidden = '<input type="hidden" name="' + name + '" value="' + !val + '" disabled>';
    $(e).append(inputHidden);
  });
  $("ul.nav").find("li.active").removeClass("active");
  $("ul.nav").find("a[href='" + window.location.pathname + "']").closest("li").addClass("active");
});

function showActive(target) {
  $(target).closest("ul[role='tablist']").find("li.active").removeClass('active');
  $(target).closest("li").addClass('active');
  console.log($(target).attr('href').trim());
  s = $(target).attr('href')
  pane = $(".tab-pane" + s);
  pane.closest("tab-content").find(".tab-pane").removeClass('active');
  pane.closest("tab-content").find(".tab-pane").hide();
  pane.show();
  pane.addClass('active');
}
