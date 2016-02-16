$(document).on 'turbolinks:request-start', ->
  $('html').css 'cursor', 'progress'
  $('#logo').css 'animation', 'play .8s steps(6) infinite'
$(document).on 'turbolinks:request-end', ->
  $('html').css 'cursor', 'auto'
  $('#logo').css 'animation', ''
