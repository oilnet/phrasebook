$(document).on 'turbolinks:load', ->
  $('#phrases_list').on 'click', 'a.audio_recording', (event) ->
    $(this).next('audio').trigger('play')
    event.preventDefault()
