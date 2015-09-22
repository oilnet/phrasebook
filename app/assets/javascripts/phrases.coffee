$ ->
  $('a.audio_recording').click ->
    $(this).after('<audio src="'+$(this).attr('href')+'" type="audio/ogg" autoplay="autoplay"/>')
    return false
