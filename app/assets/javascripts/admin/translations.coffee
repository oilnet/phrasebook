$(document).on 'turbolinks:load', ->
  # As the form may be reloaded either through TurboLinks or because it
  # will be remotely submitted, delegate event binding needs to be used.
  # Explanations: http://taplar.com/jquery/#delegateEventBinding
  parent = 'article#phrase'

  # -------------------------
  # Handling audio recordings
  # -------------------------

  # Globals for playback and recording
  play   = 'a.play_stop'
  record = 'a.record_stop'
  player = 'audio'

  # Playback
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
    b.html b.data('play')  # Have play button display 'Play' again
    $(this).trigger 'load' # Rewind player

  # Recording
  $(parent).on 'click', record, (event) ->
    b = $(this)
    switch b.html()
      when b.data('record')
        start_audio_capture(b)
      when b.data('stop')
        stop_audio_capture(b)
    return false
  start_audio_capture = (b) ->
    console.log "Starting audio capture"
    b.html b.data('stop')
    b.siblings(play).hide()
  stop_audio_capture = (b) ->
    console.log "Stopping audio capture"
    b.html b.data('record')
    b.siblings(play).show()
