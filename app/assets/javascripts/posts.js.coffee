# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.star').click ->
    #    console.log $(this).data()
    data = $(this).data()
    $.post('/posts/'+data.id+'/rate', {rating: data.rating}
    ).success( ->
      $('#alert-success').text("Thank you!").fadeIn(500).delay(1000).fadeOut(1000)
    ).error( (xhr) ->
      $('#alert-error').text("Server Error: " + JSON.parse(xhr.responseText).error).fadeIn(500).delay(1500).fadeOut(2000)
    )

  $('.tag').click ->
    #    console.log $(this).data()
    data = $(this).data()
    $.post('/posts/'+data.id+'/tag', {tag: data.tag}
    ).success( ->
      $('#alert-success').text("Thank you!").fadeIn(500).delay(1000).fadeOut(1000)
    ).error( (xhr) ->
      $('#alert-error').text("Server Error: " + JSON.parse(xhr.responseText).error).fadeIn(500).delay(1500).fadeOut(2000)
    )
