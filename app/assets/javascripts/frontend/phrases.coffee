adjustHeights = (elem) ->
  console.log "Trying to adjust panel font size"
  fontstep = 2
  console.log $(elem).height()
  console.log $(elem).parent().height()
  console.log $(elem).width()
  console.log $(elem).parent().width()
  if $(elem).height() > $(elem).parent().height() or $(elem).width() > $(elem).parent().width()
    console.log "Yeah, font size was too large"
    $(elem).css('font-size', $(elem).css('font-size').substr(0, 2) - fontstep + 'px').css 'line-height', $(elem).css('font-size').substr(0, 2) + 'px'
    adjustHeights elem
  return
