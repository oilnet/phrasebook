start_animation = ->
  $('html').css 'cursor', 'progress'
  $('#logo').css 'animation', 'play .8s steps(6) infinite'

stop_animation = ->
  $('html').css 'cursor', 'auto'
  $('#logo').css 'animation', ''

$(document).on 'turbolinks:load', ->

  $('#phrases_list').on 'click', 'a.audio_recording', (event) ->
    $(this).next('audio').trigger('play')
    event.preventDefault()
  
  $('.phrase').on 'click', 'a', (event) ->
    start_animation()
  
  $.createEventCapturing ['ended']
  
  $('.phrase').on 'ended', 'audio', (event) ->
    stop_animation()
