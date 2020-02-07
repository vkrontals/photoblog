source 'https://rubygems.org'
ruby '2.3.7'

gem 'rails', '~> 5.2.3'
gem 'mysql2'
gem 'sass-rails'
gem 'uglifier'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'config'

gem 'aws-sdk', '~> 2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :test do

end

gem 'bootsnap', '>= 1.1.0', require: false

gem 'colorize'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.0.1'

  gem 'listen', '>= 3.0.5', '< 3.2'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec-rails'
  gem 'minitest'
  gem 'shoulda-matchers'
end
gem 'kaminari'

gem 'puma'

group :prodction do
  gem 'rails_12factor'
end
