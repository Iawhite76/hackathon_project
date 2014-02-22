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

post '/inventory' do
  @name = params[:name]
  @user_name = params[:user_name]
  @phone = params[:phone]
  @email = params[:email]
  @zip = params[:zip]
  @item = params[:item]
  @serial_number = params[:serial_number]
  @price = params[:price]
  puts params
  erb :inventory
end

