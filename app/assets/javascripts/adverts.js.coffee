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
        $("#new_comment").before("<p class='comment'>" + data.text + "</p>")
        $("#noentry").remove()
        $("#new_comment").remove()
        $("#comment_label").remove()
      "json"
    )
  $(".delete_link").click (event) ->
    event.preventDefault()
    $.ajax(
      type: "DELETE"
      url: $(this).attr("href") + ".json"
      success: (data) ->
        $(this).parent().remove()
    )