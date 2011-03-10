Dir['vendor/isolate*/lib'].each do |dir|
  $: << dir
end

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'isolate/now'
require 'mysql'

require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-mysql-adapter'

require 'email_veracity'
require './lib/authorization'


configure :development do
  DataMapper::Logger.new(STDOUT, :debug)
  
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'root' ,
    :password => '',
    :database => 'rubyday'})  

  
  
  
end

configure :production do
  DataMapper.setup(:default, {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :username => 'user' ,
    :password => 'pass',
    :database => 'sinatra_production'})  
end


class Subscriber
  include DataMapper::Resource

  property :id,     Serial
  property :email,  String
  property :created_at,   DateTime
  property :updated_at,   DateTime
    
end

DataMapper.auto_upgrade!

helpers do
  include Sinatra::Authorization
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