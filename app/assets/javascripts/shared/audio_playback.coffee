start_animation = ->
  $('html').css 'cursor', 'progress'
  $('#logo').css 'animation', 'play .8s steps(6) infinite'

stop_animation = ->
  $('html').css 'cursor', 'auto'
  $('#logo').css 'animation', ''

$(document).on 'turbolinks:load', ->
  # Audio abspielen wenn Link geklickt
  $('#phrases_list').on 'click', 'a.audio_recording', (event) ->
    event.preventDefault()
    start_animation() # Zu Begin Logo-Animation starten
    $(this).next('audio').trigger('play')
  # Nach dem Laden der MP3-Datei Logo-Animation beenden
  audio_event = 'loadeddata'
  $.createEventCapturing [audio_event]
  $('#phrases_list').on audio_event, 'audio', (event) ->
    stop_animation()
