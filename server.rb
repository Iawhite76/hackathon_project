require 'rubygems'
require 'sinatra'
require 'pry'

set :bind, '0.0.0.0' # Vagrant fix

get '/welcome' do
  erb :welcome
end

get '/form' do
  erb :form
end

post '/form' do
  @name = params[:name]
  erb :inventory
end

