$(document).on 'turbolinks:load', ->
  setTimeout (->
    $('header div#flash').toggle 'blind'), 1500
