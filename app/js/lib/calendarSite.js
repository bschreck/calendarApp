$(function() {
  if ($("#info-content").length > 0) {
      setActive($("#info"), true);
  }
  else if ($("#order-content").length > 0) {
      setActive($("#order"), true);
  }
  else if ($("#creators-content").length > 0) {
      setActive($("#creators"), true);
  }
  /*
   *function updateNav(href) {
   *  if (href=="#home") {
   *    setActive($("#info"), false);
   *    setActive($("#order"), false);
   *    setActive($("#creators"), false);
   *  } else if (href=="#info") {
   *    setActive($("#info"), true);
   *    setActive($("#order"), false);
   *    setActive($("#creators"), false);
   *  } else if (href=="#order") {
   *    setActive($("#info"), false);
   *    setActive($("#order"), true);
   *    setActive($("#creators"), false);
   *  } else if (href=="#creators") {
   *    setActive($("#info"), false);
   *    setActive($("#order"), false);
   *    setActive($("#creators"), true);
   *  }
   *}
   */
  function setActive(node, bool) {
    if (bool==false) {
      node.attr('class', 'disabled');
    } else {
      node.attr('class', 'active');
    }
  }
  /*
   *function updateContent(href) {
   *  if (href=="#home") {
   *    $("#home-content").show();
   *    $("#info-content").hide();
   *    $("#order-content").hide();
   *    $("#creators-content").hide();
   *  } else if (href=="#info") {
   *    $("#home-content").hide();
   *    $("#info-content").show();
   *    $("#order-content").hide();
   *    $("#creators-content").hide();
   *  } else if (href=="#order") {
   *    $("#home-content").hide();
   *    $("#info-content").hide();
   *    $("#order-content").show();
   *    $("#creators-content").hide();
   *  } else if (href=="#creators") {
   *    $("#home-content").hide();
   *    $("#info-content").hide();
   *    $("#order-content").hide();
   *    $("#creators-content").show();
   *  }
   *}
   */
  /*
   *$("#home").click(function(){
   *  //var href = $('#home').children().attr('href');
   *  updateNav("#home");
   *  //updateContent(href);
   *});
   *$("#info").click(function(){
   *  //var href = $('#info').children().attr('href');
   *  updateNav("#info");
   *  //updateContent(href);
   *});
   *$("#order").click(function(){
   *  //var href = $('#order').children().attr('href');
   *  updateNav("#order");
   *  //updateContent(href);
   *});
   *$("#creators").click(function(){
   *  //var href = $('#creators').children().attr('href');
   *  updateNav("creators");
   *  //updateContent(href);
   *});
   *$("#order-button").click(function(){
   *  //var href = $('#order-button').attr('href');
   *  updateNav("#order");
   *  //updateContent(href);
   *});
   */
});
