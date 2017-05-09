$( document ).ready(function() {
  readyButtonLikeAction();
});

function readyButtonLikeAction(){
  $("i.fa-heart").click(function(e){
    $(this).removeClass("fa-heart");
    $(this).addClass("fa-heart-o");
  });
  $("i.fa-heart-o").click(function(e){
    $(this).removeClass("fa-heart-o");
    $(this).addClass("fa-heart");
  });
  $("button").tooltip({
    title: function(){
      return $(this).attr('title');
    }
  });
}

function likeFaid(container){
  i = $(container).find("btn-like").find("i.fa-heart");
  i.removeClass("fa-heart");
  i.addClass("fa-heart-o");
}
function unlikeFaid(container){
  i = $(container).find("btn-unlike").find("i.fa-heart-o");
  i.removeClass("fa-heart-o");
  i.addClass("fa-heart");
}
