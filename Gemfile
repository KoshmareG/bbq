source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'cssbundling-rails', '~> 1.1'
gem 'devise'
gem 'devise-i18n'
gem 'image_processing', '>= 1.2'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-yandex', github: 'evrone/omniauth-yandex', branch: 'dependabot/bundler/omniauth-2.1.0'
gem 'mailjet'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.3'
gem 'rails', '~> 7.0.4'
gem 'rails-i18n'
gem 'redis', '~> 4.0'
gem 'resque', '~> 2.4'
gem 'rmagick'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails'
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'shoulda-matchers', '~> 5.3'
end

group :development do
  gem 'capistrano', '~> 3.17', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem "capistrano-resque", "~> 0.2.3", require: false
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-bundler', '~> 2.0'
  gem 'ed25519', '~> 1.3.0'
  gem 'bcrypt_pbkdf', '~> 1.1.0'
  gem 'web-console'
end
