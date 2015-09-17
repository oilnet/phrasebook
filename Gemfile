source 'https://rubygems.org'

gem 'rails' # , '4.2.4'
gem 'sqlite3'
gem 'haml' # Who wants to be writing closing tags all day long?
gem 'sass' # Has the command line tools missing from sass-rails
gem 'haml-rails'
gem 'sass-rails' # , '~> 5.0'
gem 'uglifier' # , '>= 1.3.0'
gem 'coffee-rails' # , '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-ui-sass-rails'
gem 'jquery-cookie-rails'
gem 'mediaelement_rails' # HTML5/Flash/Silverlight gracefully downgrading video player
# gem 'turbolinks'
gem 'jbuilder' # , '~> 2.0'
gem 'sdoc', group: :doc # , '~> 0.4.0'
gem 'bcrypt' # , '~> 3.1.7' # For has_secure_password in AR
gem 'pry' # A better IRB
gem 'pry-rails'
gem 'simple_form' # Don't forget to use it!
gem 'browser' # For browser detection
gem 'i18n-js', github: 'fnando/i18n-js' # , branch: 'rewrite'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console' # , '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'better_errors' # Still needed?
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'i18n-debug'
end

group :production do
  # gem 'mysql2' # , '< 0.3'
end

group :ankidict do
  gem 'nokogiri' # HTML parser; used to be hpricot
end

group :cameldb do
  gem 'bootstrap-sass'
  gem 'pundit' # "Minimal authorization through OO design and pure Ruby classes"
  gem 'country_select' # "Helper to get an HTML select list of countries using the ISO 3166-1 standard"
  gem 'cocoon' # "Cocoon makes it easier to handle nested forms"
  gem 'momentjs-rails' # , '~> 2.5.0' # "Lightweight javascript date library for parsing, manipulating, and formatting dates"
  gem 'bootstrap3-datetimepicker-rails' # , '~> 3.0.0.1'
  gem 'paperclip' # , '~> 4.1' # For handling uploads
  gem 'colorbox-rails' # Make links open in lightbox
end

group :qawamis do
  gem 'jquery_mb_extruder'
  gem 'jquery-mousewheel-rails'
  gem 'http_accept_language'
end

group :mark_one do
  gem 'htmlentities'
end

group :touchstone do
  gem 'devise' # Ready-made, heavy-weight authentication
  gem 'cancan' # More heavy-weight than pundit
  gem 'acts_as_list'
  gem 'ruby_parser'
  gem 'railroady' # UML class diagram generator
  gem 'rspec-rails'
end

group :msa_website do
  gem 'modernizr-rails' # "Detects HTML5 and CSS3 features in the user’s browser"
  gem 'high_voltage' # For including static pages under arbitrary route patterns
  gem 'safe_attributes' # "Add support for reserved word column names with ActiveRecord"
  gem 'prawn-rails' # Create PDFs
  gem 'will_paginate', '~> 3.0.6'
  gem 'ransack'
end
