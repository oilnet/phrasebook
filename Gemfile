source 'https://rubygems.org'

gem 'rails', '~> 4.2.0'
gem 'haml' # Who wants to be writing closing tags all day long?
gem 'sass' # Has the command line tools missing from sass-rails
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 2.7'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'remotipart', '~> 1.2'
gem 'jquery-ui-rails'
gem 'jquery-ui-sass-rails'
gem 'jquery-cookie-rails'
gem 'js_cookie_rails'
gem 'mediaelement_rails' # HTML5/Flash/Silverlight gracefully downgrading video player
gem 'turbolinks', '~> 5.0.0.beta' # gem 'turbolinks', :github => 'rails/turbolinks', :branch => 'master'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bcrypt', '~> 3.1.7' # For has_secure_password in AR
gem 'simple_form' # Don't forget to use it!
gem 'browser' # For browser detection
gem 'rails-i18n'
gem 'i18n-js', github: 'fnando/i18n-js' # , branch: 'rewrite'
gem 'toolbox', path: 'toolbox' # Local path!
# gem 'browserify-rails' # To be able to use npm…
gem 'font-awesome-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'quiet_assets'
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
  gem 'meta_request' # To be used together with Chrome and the Rails Panel plugin
  gem 'annotate' # Show the model's schema on top of the model file
  gem 'lol_dba' # Points out database columns that should be indexed
  gem 'mailcatcher' # Local mailserver for testing purposes
  gem 'railroady' # Generate UML files from a Rails project
  # gem 'zeus' # Makes things faster
  gem 'rails-erd' # For visualizing the schema
  gem 'pry' # A better IRB
  gem 'awesome_print'
  # gem 'seed_dump' # Careful with associations!
end

group :sqlite do
  gem 'sqlite3'
end

group :mysql do
  gem 'mysql2'
end

group :postgres do
  gem 'pg'
end

group :phrasebook do
  gem 'language_list'
  gem 'countries' # , require: 'global'
  gem 'country_select' # 'Helper to get an HTML select list of countries using the ISO 3166-1 standard'
  gem 'swfobject-rails'
  gem 'streamio-ffmpeg'
  gem 'google-webfonts-rails'
  gem 'sorcery' # Authentication
  gem 'pundit' # Authorization
  gem 'validates_email_format_of'
  gem 'http_accept_language'
  gem 'foundation-rails', '~> 5.5.1.2'
  gem 'pry-rails'
  gem 'htmlentities'
  gem 'will_paginate', '~> 3.0.6'
  # Hopefully this will work for all CSS needs?!
  gem 'normalize-rails'
  gem 'bourbon'
  gem 'neat'
  gem 'bitters'
  # Either these two:
  # gem 'ransack'
  # gem 'will_paginate', '~> 3.0.6'
  # Or this instead:
  # gem 'kaminari' # But need to check it out…
  gem 'recorderjs-rails', git: 'git@github.com:sixtyfive/recorderjs-rails.git',
                          ref: '88fb8d8'
end

=begin
# -----------------------------------------------------
# Older projects
# -----------------------------------------------------

group :legacy do
  # Taps:
  # For cloning legacy databases, etc.
  # Careful, only works properly with Ruby <= 1.9.3!
  # gem 'sqlite3'
  # gem 'mysql'
  # gem 'pq'
  gem 'tilt', '~> 1.4.1'
  gem 'rack', '1.0.1'
  gem 'taps', :git => 'https://github.com/ricardochimal/taps.git'
end

group :ankidict do
  gem 'nokogiri' # HTML parser; used to be hpricot
end

group :cameldb do
  gem 'bootstrap-sass'
  gem 'pundit' # 'Minimal authorization through OO design and pure Ruby classes'
  gem 'cocoon' # 'Cocoon makes it easier to handle nested forms'
  gem 'momentjs-rails' # , '~> 2.5.0' # 'Lightweight javascript date library for parsing, manipulating, and formatting dates'
  gem 'bootstrap3-datetimepicker-rails' # , '~> 3.0.0.1'
  gem 'paperclip' # , '~> 4.1' # For handling uploads
  gem 'colorbox-rails' # Make links open in lightbox
end

group :qawamis do
  gem 'jquery_mb_extruder'
  gem 'jquery-mousewheel-rails'
  gem 'http_accept_language'
end

group :mark1 do
  gem 'htmlentities'
  gem 'devise' # Ready-made, heavy-weight authentication
  gem 'cancan' # More heavy-weight than pundit
  gem 'acts_as_list'
  gem 'ruby_parser'
  gem 'railroady' # UML class diagram generator
  gem 'rspec-rails'
end

group :msa_website_rails do
  gem 'modernizr-rails' # 'Detects HTML5 and CSS3 features in the user’s browser'
  gem 'high_voltage' # For including static pages under arbitrary route patterns
  gem 'safe_attributes' # 'Add support for reserved word column names with ActiveRecord'
  gem 'prawn-rails' # Create PDFs
end
=end
