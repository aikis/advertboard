# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/>
$(document).ready ->
  $('#new_comment').submit (event) ->
    event.preventDefault()
    $.post(
      "/comments.json"
      $("#new_comment").serialize()
      (data) =>
        $str ="<p>" + data.text + "</p>" + "<a href='/comments/" + data.id + "/edit'>Edit</a>"
        $("#comment_label").before("<div class='comment'>" + $str + "</div>")
        $("#noentry").remove()
      "json"
    )
  $(".delete_link").click (event) ->
    event.preventDefault()
    $parent = $(this).parent()
    $.ajax(
      type: "DELETE"
      url: $(this).attr("href") + ".json"
      success: (data)->
        $parent.slideUp()
      error: (data, textStatus)->
        alert "DB delete error: no entry found!"
    )