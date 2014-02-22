require 'rubygems'
require 'sinatra'
require 'pry'
require 'flickraw'

#set :bind, '0.0.0.0' # Vagrant fix

FlickRaw.api_key = ENV['API_KEY']
FlickRaw.shared_secret = ENV['SECRET']

flickr.access_token = ENV['TOKEN']
flickr.access_secret = ENV['A_SECRET']
enable :sessions

get '/form' do
  if @id
  @photo_detail = flickr.photos.getInfo photo_id=@id
 end
  erb :form
end

post '/form' do
  PHOTO_PATH=params[:pic][:tempfile]
  @serial_number = params[:serial_number]
  @item = params[:item]
  @price = params[:price]
  @pic = params[:pic]
  @item2 = params[:item2]
  @serial_number2 = params[:serial_number2]
  @price2 = params[:price2]
  @pic2 = params[:pic2]
  @item3 = params[:item3]
  @serial_number3 = params[:serial_number3]
  @price3 = params[:price3]
  @pic3 = params[:pic3]
  @items = [@item, @item2, @item3]

  @serial_numbers = [@serial_number, @serial_number2, @serial_number3]

  @prices = [@price, @price2, @price3]

  @pics = [@pic, @pic2, @pic3]

  erb :form
end

# post '/inventory' do
#   @name = params[:name]
#   @user_name = params[:user_name]
#   @phone = params[:phone]
#   @email = params[:email]
#   @zip = params[:zip]
#   @item = params[:item]
#   @serial_number = params[:serial_number]
#   @price = params[:price]
#   @pic = params[:pic]
#   @item2 = params[:item2]
#   @serial_number2 = params[:serial_number2]
#   @price2 = params[:price2]
#   @pic2 = params[:pic2]
#   @item3 = params[:item3]
#   @serial_number3 = params[:serial_number3]
#   @price3 = params[:price3]
#   @pic3 = params[:pic3]
#   @items = [@item, @item2, @item3]
#   @serial_numbers = [@serial_number, @serial_number2, @serial_number3]
#   @prices = [@price, @price2, @price3]
#   @pics = [@pic, @pic2, @pic3]
#   erb :inventory
# end

