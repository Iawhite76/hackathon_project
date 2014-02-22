require 'rubygems'
require 'sinatra'
require 'pry'

set :bind, '0.0.0.0' # Vagrant fix

get '/welcome' do
  erb :welcome
end
