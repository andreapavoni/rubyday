require './rubyday.rb'

set :environment, :development
set :run, false

run Sinatra::Application
