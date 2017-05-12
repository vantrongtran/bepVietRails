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
  checkboxReady();
  // $(".tab-pane").hide();
  // $(".tab-pane.active").show();
  // $("a[role='tab'][data-toggle='tab'][href='#" + $(".tab-pane.active").attr('id') + "']").each(function(i, e){
  //   $(e).show();
  //   showActive(e);
  // })
  // $("ul.nav").find("li.active").removeClass("active");
  // $("ul.nav").find("a[href='" + window.location.pathname + "']").closest("li").addClass("active");

  $("#btn-user-avatar").change(function (e) {
    readURL(this);
    $("#update-avatar").submit();
  });
});

// function showActive(target) {
//   $(target).closest("ul[role='tablist']").find("li.active").removeClass('active');
//   $(target).closest("li").addClass('active');
//   console.log($(target).attr('href').trim());
//   s = $(target).attr('href')
//   pane = $(".tab-pane" + s);
//   pane.closest("tab-content").find(".tab-pane").removeClass('active');
//   pane.closest("tab-content").find(".tab-pane").hide();
//   pane.show();
//   pane.addClass('active');
// }
function checkboxReady(){
  $(".checkbox").each(function(i, e){
    checkbox = $(e).find("input[type=checkbox]");
    name = checkbox.attr("name");
    val = checkbox.val() == 'true';
    inputHidden = '<input type="hidden" name="' + name + '" value="' + !val + '" disabled>';
    $(e).append(inputHidden);
  });
   $(".checkbox").find("label").click(function(e){
      checkbox = $(e.target).closest(".checkbox").find("input[type=checkbox]")
      checkbox = $(e.target).closest(".checkbox").find("input[type=checkbox]");
      input = $(e.target).closest(".checkbox").find("input[type=hidden]")
      input = $(e.target).closest(".checkbox").find("input[type=hidden]");
      checked = checkbox.is(':checked')
      checked = checkbox.is(':checked');
      checkbox.prop('checked', !checked)
      checkbox.prop('checked', !checked);
      checkbox.attr('checked', !checked)
      checkbox.attr('checked', !checked);
      input.prop('disabled', !checked)
      input.prop('disabled', !checked);
  });
}
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#user-avatar-image')
      .attr('src', e.target.result)
    };

    reader.readAsDataURL(input.files[0]);
  }
}

function disable_input() {
  $("#edit_user :input").prop("disabled", true);
}
