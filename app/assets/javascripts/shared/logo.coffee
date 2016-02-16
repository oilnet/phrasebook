start_animation = ->
  $('html').css 'cursor', 'progress'
  $('#logo').css 'animation', 'play .8s steps(6) infinite'

stop_animation = ->
  $('html').css 'cursor', 'auto'
  $('#logo').css 'animation', ''

$(document).on 'turbolinks:request-start', ->
  start_animation()
$(document).on 'submit', 'form#search', ->
  start_animation()

$(document).on 'turbolinks:request-end', ->
  stop_animation()

