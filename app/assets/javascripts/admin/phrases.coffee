$(document).on 'turbolinks:load', ->

  # TODO: Set up functions encapsulating the features below
  # so that there is no more danger of overlapping variable
  # scope.

  # ---------------------------------
  # Position of phrase list scrollbar
  # ---------------------------------

  parents = $('aside, article#phrase')

  ac_cookie = 'aside_scroll_position'
  aside = $('aside')
  aside.scrollTop Cookies.get(ac_cookie)
  parents.on 'click', 'a, input[type=submit]', (event) ->
    Cookies.set ac_cookie, aside.scrollTop()

  # --------------------------------
  # Text field to filter for phrases
  # --------------------------------
  
  # Case-insensitive version of jQuery's :contains selector.
  # http://stackoverflow.com/questions/2196641/how-do-i-make-
  #    jquery-contains-case-insensitive-including-jquery-1-8
  jQuery.expr[':'].contains = (a, i, m) ->
    jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0
  
  # Inspired by http://stackoverflow.com/questions/1772035
  #               filtering-a-list-as-you-type-with-jquery
  ps_cookie = 'phrase_search_text'
  filter = (search_field, haystack) ->
    needle = search_field.val().toLowerCase()
    Cookies.set ps_cookie, input.val() # Save search value
    if needle == ''
      $(haystack + ' li').show()
    else
      $(haystack + ' li:not(:contains(' + needle + '))').hide()
      $(haystack + ' li:contains(' + needle + ')').show()
  
  # Toggle filter on every keypress inside the search field.
  # Hooked onto document:ready instead of turbolinks:load
  # since parent element is data-turbolinks-permanent.
  input = $('#search_text')
  list = '#phrase_list ul'
  input.on 'input', (event) ->
    input = $(this)
    filter input, list # On each keypress
  input.val Cookies.get(ps_cookie) # Restore search value
  filter input, list # On page load
  
  # ------------------------------------
  # Remove phrase's image, add a new one
  # ------------------------------------
  
  parent = $('article#phrase')
  
  parent.on 'click', 'fieldset.image a.delete', (event) ->
    a = $(this)
    a.hide()
    img = a.siblings('img')
    img.hide()
    event.preventDefault()
   
  parent.on 'change', 'fieldset.image input[type=file]', (event) ->
    input = $(this)
    reader = new FileReader
    reader.onload = (event) ->
      a = input.parent().siblings('a')
      a.show()
      img = a.siblings('img')
      img.attr('src', event.target.result)
      img.show()
    reader.onerror = (event) ->
      console.log "Error: " + event.target.error
    reader.readAsDataURL input[0].files[0]
