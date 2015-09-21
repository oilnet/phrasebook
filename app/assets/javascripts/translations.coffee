$ ->
  
  play_btn = $('#play_stop')
  record_btn = $('#record')
  player = $('audio')

  # -------------------------------------
  # Playback of previously recorded audio
  # -------------------------------------

  play_btn.click ->
    switch play_btn.html()
      when play_btn.data('play')
        play_btn.html(play_btn.data 'stop')
        player.trigger('play') # Start playing
      when play_btn.data('stop')
        play_btn.html(play_btn.data 'play')
        player.trigger('load') # Stop playing and rewind
    return false
    
  # -------------------------------------
  # Triggering recording of new audio    
  # -------------------------------------

  media_constraints =
    audio: navigator.mozGetUserMedia
    video: !navigator.mozGetUserMedia # Apparently Chrome only does video?

  media_recorder = Object
   
  start_audio_capture = (success_callback, error_callback) ->
    record_btn.html(record_btn.data 'stop')
    navigator.mediaDevices.getUserMedia(media_constraints).then(success_callback).catch(error_callback)
    
  stop_audio_capture = ->
    record_btn.html(record_btn.data 'record')
    media_recorder.stop()
    media_recorder.stream.stop()
    # TODO 2: XMLHttpRequest blob from global blob URL variable,
    # then write it into hidden input field named :recording
    play_btn.show()

  on_media_success = (stream) ->
    media_recorder = new MediaStreamRecorder(stream)
    media_recorder.stream = stream
    media_recorder.mimeType = 'audio/ogg'
    player.attr('src', URL.createObjectURL(stream))
    player.prop('muted', true)
    player.trigger('play')
    media_recorder.ondataavailable = (blob) ->
      player.attr('src', URL.createObjectURL(blob))
      player.trigger('load')
      player.prop('muted', false)
      # TODO 1: Write blob URL into *global* variable!
    max_length = 60*1000 # 640k ought to be enough for anybody…
    media_recorder.start(max_length)
    setTimeout(stop_audio_capture, max_length) # Don't allow more than one blob

  on_media_error = (e) ->
    console.error('Media error:', e)
  
  record_btn.click ->
    switch record_btn.html()
      when record_btn.data('record')
        start_audio_capture(on_media_success, on_media_error)
      when record_btn.data('stop')
        stop_audio_capture(record_btn)
    return false

  # -------------------------------------
  # Reset "stop" button to "play" when
  # playback ends by itself
  # -------------------------------------

  on_playback_end = -> 
    play_btn.html(play_btn.data 'play')
    player.trigger('load')
  player.bind('ended', on_playback_end)
