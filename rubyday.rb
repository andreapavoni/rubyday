Dir['vendor/isolate*/lib'].each do |dir|
  $: << dir
end

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'isolate/now'
require 'sqlite3'

require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'

require 'email_veracity'
require './lib/authorization'


configure do
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/rubyday.db")
end

class Subscriber
  include DataMapper::Resource

  property :id,     Serial
  property :email,  String
  property :created_at,   DateTime
  property :updated_at,   DateTime
    
end

helpers do
  include Sinatra::Authorization
end

configure :development do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  haml :index
end

get '/thanks' do
  haml :thanks
end

get '/subscribers' do
  require_admin
  @guys = Subscriber.all(:order => [:created_at.desc])
  haml :list
end

post '/subscribe' do

  @you = Subscriber.new(params[:subscriber])
  address = EmailVeracity::Address.new(@you.email)
  
  if @you.save && address.valid?
    redirect "/thanks"
  else
    redirect "/"
  end
end