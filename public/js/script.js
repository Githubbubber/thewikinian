"use strict";

$(document).ready(function(){
  /* Menus */
  var menu_items = $('.main_navigation li');
  var entryMenu = $("select#changed");
  var editEntry = $("form#hideEdit");
  var deleteEntry = $("form#hideDelete");
  var newEntry = $("form#hideNew");
  var newArticle = $("button#newArticle");

  menu_items.hover(function(){
    $(this).children('a').addClass("hover");
    $(this).children('ul').show();
  }, function(){
    $(this).children('a').removeClass("hover");
    $(this).children('ul').hide();
  });

  entryMenu.change(function() {
    if (entryMenu.val()==="edit") {
      editEntry.css("display","block");
      deleteEntry.css("display","none");
    }
    else if (entryMenu.val()==="d") {
      editEntry.css("display","none");
      deleteEntry.css("display","block");
    }
  });

  newArticle.click(function() {
    if (newEntry.css("display") === "none") {
      newEntry.css("display","block");
    } else newEntry.css("display","none");
  });
});
