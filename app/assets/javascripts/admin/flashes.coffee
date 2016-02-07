$(document).on 'turbolinks:load', ->
  setTimeout (->
    $('header div').toggle 'blind'), 1500
