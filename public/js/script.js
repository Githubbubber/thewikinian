"use strict";

$(document).ready(function(){
  /* Menus */
  var menu_items = $('.main_navigation li');
  var editArticle = $("button#changed");
  var newArticle = $("button#newArticle");
  var editEntry = $("form#hideEdit");
  var newEntry = $("form#hideNew");

  menu_items.hover(function(){
    $(this).children('a').addClass("hover");
    $(this).children('ul').show();
  }, function(){
    $(this).children('a').removeClass("hover");
    $(this).children('ul').hide();
  });

  editArticle.click(function() {
    if (editEntry.css("display") === "block") {
      editEntry.css("display","none");
    } else editEntry.css("display","block");

  });

  newArticle.click(function() {
    if (newEntry.css("display") === "none") {
      newEntry.css("display","block");
    } else newEntry.css("display","none");
  });
});
