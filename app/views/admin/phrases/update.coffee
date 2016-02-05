$('#phrase').fadeOut 200
$('#phrase').html '<%= escape_javascript(render(@phrase)) %>'
$('#phrase').fadeIn 50

<% if remotipart_submitted? %>
console.log('submitted via remotipart')
<% else %>
console.log('submitted via native jquery-ujs')
<% end %>
