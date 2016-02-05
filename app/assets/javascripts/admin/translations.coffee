$(document).on 'turbolinks:load', ->

  # -------------------------------------
  # Global variables                     
  # -------------------------------------

  media_constraints =
    audio: navigator.mozGetUserMedia
    video: !navigator.mozGetUserMedia # Apparently Chrome only does video?

  media_recorder = Object
  blob_url = Object
  
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
   
  start_audio_capture = (success_callback, error_callback) ->
    console.log("*** Starting audio capture")
    record_btn.html(record_btn.data 'stop')
    navigator.mediaDevices.getUserMedia(media_constraints).then(success_callback).catch(error_callback)
    
  stop_audio_capture = ->
    console.log("*** Stopping audio capture")
    record_btn.html(record_btn.data 'record')
    media_recorder.stop()
    media_recorder.stream.stop()
    play_btn.show()

  on_media_success = (stream) ->
    media_recorder = new MediaStreamRecorder(stream)
    media_recorder.stream = stream
    media_recorder.mimeType = 'audio/mpeg'
    player.attr('src', URL.createObjectURL(stream))
    player.prop('muted', true)
    player.trigger('play')
    # The below is the important part:
    media_recorder.ondataavailable = (blob) ->
      blob_url = URL.createObjectURL(blob)
      console.log("*** Saved blob URL:", blob_url)
      player.attr('src', blob_url)
      player.trigger('load')
      player.prop('muted', false)
      console.log("*** Player unmuted and re-set")
      reader = new window.FileReader()
      reader.readAsDataURL(blob)
      reader.onloadend = ->
        base64_data = reader.result
        $('input.recording_data').attr('value', base64_data)
        console.log("*** Blob converted to base64 and appended to form")
    # --------------------------------
    max_length = 60*1000 # 640k ought to be enough for anybody… right?
    media_recorder.start(max_length)
    setTimeout(stop_audio_capture, max_length) # Don't allow more than one blob

  on_media_error = (e) ->
    console.error("*** Media error:", e)
  
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
