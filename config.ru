require './rubyday.rb'

set :env, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)
set :run, false

run Sinatra::Application
