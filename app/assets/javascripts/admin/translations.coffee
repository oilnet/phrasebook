$(document).on 'turbolinks:load', ->
  # As the form may be reloaded either through TurboLinks or because it
  # will be remotely submitted, delegate event binding needs to be used.
  # Explanations: http://taplar.com/jquery/#delegateEventBinding
  parent = 'article#phrase'
  # Playback/recording
  player = 'audio'
  recorder = Object
  audio_context = Object
  # Buttons
  play   = 'a.play_stop'
  record = 'a.record_stop'

  # --------
  # Playback
  # --------
  
  $(parent).on 'click', play, (event) ->
    b = $(this)
    switch b.html()
      when b.data('play')                  # Button is displaying "Play"
        b.html b.data('stop')              # Make it display "Stop" instead
        b.siblings(player).trigger('play') # Start playing
        b.siblings(record).hide()
      when b.data('stop')                  # Button is displaying "Stop"
        b.html b.data('play')              # Make it display "Play" instead
        b.siblings(player).trigger('load') # Stop playing and rewind
        b.siblings(record).show()
    return false
  
  # <audio> and <video> events do not bubble as someone somewhere
  # thought that they wouldn't make sense to any other HTML element.
  # I call bullshit, but whatever. A solution was suggested on SE
  # that uses a function stolen from the webshims library. URL:
  # http://stackoverflow.com/questions/11291651/why-dont-audio-and-video-events-bubble
  $.createEventCapturing ['ended']
  
  $(parent).on 'ended', player, (event) ->
    b = $(this).siblings play
    b.html b.data('play')     # Have play button display 'Play' again
    b.siblings(record).show() # And make record button reappear
    $(this).trigger 'load'    # Rewind player

  # ---------
  # Recording
  # ---------

  start_user_media = (stream) ->
    input = audio_context.createMediaStreamSource(stream)
    console.log 'Media stream created'
    recorder = new Recorder(input)
    recorder && recorder.record()
    console.log 'Recorder initialised'
    return
    
  start_audio_capture = (b) ->
    console.log 'Recording started'  
    navigator.getUserMedia {audio: true}, start_user_media, (error) ->
      console.log 'No live audio input: ', error
    b.html b.data('stop')
    b.siblings(play).hide()
    
  stop_audio_capture = (b) ->
    recorder && recorder.stop()
    console.log 'Recording stopped'
    b.html b.data('record')
    b.siblings(play).show()
    save_audio_for_upload(b)
    recorder.clear()

  try
    # Cross-browser shims
    window.AudioContext = window.AudioContext or window.webkitAudioContext
    navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia
    window.URL = window.URL or window.webkitURL
    createObjectURL = window.URL.createObjectURL
    # Back to business
    audio_context = new AudioContext
    console.log 'navigator.getUserMedia is ' + (if navigator.getUserMedia then 'available' else 'not available')
  catch e
    console.log 'Browser does not have web audio support (' + e + ')'
    
  $(parent).on 'click', record, (event) ->
    b = $(this)
    switch b.html()
      when b.data('record')
        start_audio_capture(b)
      when b.data('stop')
        stop_audio_capture(b)
    return false
    
  save_audio_for_upload = (b) ->
    console.log 'save_audio_for_upload'
    # For some reason, even after &&, .exportWAV fails 
    # silently when recorderWorker.js is inaccessibly.
    # If things are not working, check that first!
    recorder && recorder.exportWAV (blob) ->
      # It is quite enough to set the blob URL as the
      # <audio>'s src attribute as the blob is not PCM,
      # but includes a full WAV header.
      audio_tag = b.siblings 'audio'
      url = createObjectURL blob
      audio_tag.attr 'src', url
      console.log 'Blob set as <audio> src attribute'
      # For uploading to the server, the blob needs to
      # be converted to base64 as otherwise JavaScript
      # will set the <input>'s src attribute to be a
      # string simply reading "[object Blob]".
      input_tag = b.siblings('div').children('input.recording_data')
      reader = new FileReader
      reader.readAsDataURL blob
      reader.onload = ->
        base64 = reader.result
        input_tag.val base64
        console.log 'Base64 set as <input> value'
      reader.onerror = (event) ->
        console.log "Error: " + event.target.error
