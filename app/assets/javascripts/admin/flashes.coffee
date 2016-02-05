$(document).on 'turbolinks:load', ->
  setTimeout (->
    $('header div').toggle 'blind'
    return
  ), 1500
  return
