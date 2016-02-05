$('#phrase').fadeOut 200
$('#phrase').html '<%= escape_javascript(render(@phrase)) %>'
$('#phrase').fadeIn 50
