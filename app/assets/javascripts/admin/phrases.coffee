# Case-insensitive version of jQuery's :contains selector.
# http://stackoverflow.com/questions/2196641/how-do-i-make-
#    jquery-contains-case-insensitive-including-jquery-1-8
jQuery.expr[':'].contains = (a, i, m) ->
  jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0

# Toggle filter on every keypress inside the search field.
# Hooked onto document:ready instead of turbolinks:load
# since parent element is data-turbolinks-permanent.
$ ->
  $('#search_text').keyup ->
    filter this, '#phrase_list ul'

# Inspired by http://stackoverflow.com/questions/1772035
#               filtering-a-list-as-you-type-with-jquery
filter = (search_field, haystack) ->
  needle = $(search_field).val().toLowerCase()
  console.log needle
  if needle == ''
    $(haystack + ' li').show()
  else
    $(haystack + ' li:not(:contains(' + needle + '))').hide()
    $(haystack + ' li:contains(' + needle + ')').show()
