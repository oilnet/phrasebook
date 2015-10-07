source 'https://rubygems.org'

gem 'rails', '~> 4.2.0'
gem 'sqlite3'
gem 'haml' # Who wants to be writing closing tags all day long?
gem 'sass' # Has the command line tools missing from sass-rails
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-ui-sass-rails'
gem 'jquery-cookie-rails'
gem 'mediaelement_rails' # HTML5/Flash/Silverlight gracefully downgrading video player
# gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bcrypt', '~> 3.1.7' # For has_secure_password in AR
gem 'simple_form' # Don't forget to use it!
gem 'browser' # For browser detection
gem 'rails-i18n'
gem 'i18n-js', github: 'fnando/i18n-js' # , branch: 'rewrite'
gem 'language_list'
gem 'countries', require: 'global'
gem 'country_select' # 'Helper to get an HTML select list of countries using the ISO 3166-1 standard'
gem 'swfobject-rails'
gem 'toolbox', path: 'toolbox' # Local path!
# gem 'browserify-rails' # To be able to use npm…
gem 'font-awesome-rails'
gem 'quiet_assets' # , group: :development # - but why?

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console' # , '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'better_errors' # Still needed?
  # gem 'binding_of_caller', platforms: [:mri_21]
  gem 'html2haml'
  # gem 'hub', require: nil
  # gem 'rails_layout'
  # gem 'i18n-debug'
  gem 'pry' # A better IRB
  gem 'pry-rails'
  gem 'meta_request' # To be used together with Chrome and the Rails Panel plugin
  gem 'annotate' # Show the model's schema on top of the model file
  gem 'lol_dba' # Points out database columns that should be indexed
  gem 'mailcatcher' # Local mailserver for testing purposes
  gem 'railroady' # Generate UML files from a Rails project
  # gem 'zeus' # Makes things faster
end

group :production do
  # gem 'mysql2' # , '< 0.3'
  gem 'pg'
end

# -----------------------------------------------------
# Phrasebook-specific
# -----------------------------------------------------
gem 'streamio-ffmpeg'
gem 'google-webfonts-rails'
gem 'sorcery' # Authentication
gem 'pundit' # Authorization
gem 'validates_email_format_of'
gem 'http_accept_language'
# Either these two:
# gem 'ransack'
# gem 'will_paginate', '~> 3.0.6'
# Or this instead:
# gem 'kaminari' # But need to check it out…

# -----------------------------------------------------
# Older projects
# -----------------------------------------------------
=begin
# Taps:
# For cloning legacy databases, etc.
# Careful, only works properly with Ruby <= 1.9.3!
# gem 'sqlite3'
# gem 'mysql'
# gem 'pq'
gem 'tilt', '~> 1.4.1'
gem 'rack', '1.0.1'
gem 'taps', :git => 'https://github.com/ricardochimal/taps.git'

# AnkiDict:
gem 'nokogiri' # HTML parser; used to be hpricot

# CamelDB:
gem 'bootstrap-sass'
gem 'pundit' # 'Minimal authorization through OO design and pure Ruby classes'
gem 'cocoon' # 'Cocoon makes it easier to handle nested forms'
gem 'momentjs-rails' # , '~> 2.5.0' # 'Lightweight javascript date library for parsing, manipulating, and formatting dates'
gem 'bootstrap3-datetimepicker-rails' # , '~> 3.0.0.1'
gem 'paperclip' # , '~> 4.1' # For handling uploads
gem 'colorbox-rails' # Make links open in lightbox

# Qawamīs:
gem 'jquery_mb_extruder'
gem 'jquery-mousewheel-rails'
gem 'http_accept_language'

# Mark¹:
gem 'htmlentities'

gem 'devise' # Ready-made, heavy-weight authentication
gem 'cancan' # More heavy-weight than pundit
gem 'acts_as_list'
gem 'ruby_parser'
gem 'railroady' # UML class diagram generator
gem 'rspec-rails'

# MSA-Website-Rails:
gem 'modernizr-rails' # 'Detects HTML5 and CSS3 features in the user’s browser'
gem 'high_voltage' # For including static pages under arbitrary route patterns
gem 'safe_attributes' # 'Add support for reserved word column names with ActiveRecord'
gem 'prawn-rails' # Create PDFs
=end
