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
   @name = params[:name]
  if @id
  @photo_detail = flickr.photos.getInfo :photo_id => @id
  end
  erb :form
end

post '/form' do

  @name = params[:name]
  @user_name = params[:user_name]
  @phone = params[:phone]
  @email = params[:email]
  @zip = params[:zip]
  @serial_number = params[:serial_number]
  @item = params[:item]
  @price = params[:price]
  @pic = params[:pic]
  @hidden_name = params[:hidden_name]
  if @pic
  PHOTO_PATH=params[:pic][:tempfile]
  @id = flickr.upload_photo PHOTO_PATH, :title => @item, :description => 'serial number: ' + @serial_number + 'retail price: ' + @price, :tags => @hidden_name
  end
  erb :form
end

get '/_inventory' do
#temporary just to show rendered inventory page

  @user_photos = flickr.photos.search :user_id => '118312704@N05', :tags => 'zalary'
  puts @user_photos
  erb :_inventory
end

# post '/_inventory' do
#   PHOTO_PATH=params[:pic][:tempfile]
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
#   @id = flickr.upload_photo PHOTO_PATH, :title => @item, :description => 'serial number: ' + @serial_number + 'retail price: ' + @price, :tags => @hidden_name
#   puts @id
#   @photo_detail = flickr.photos.getInfo :photo_id => @id
#   @pid = @photo_detail.id
#   @secret = @photo_detail.secret
#   @ps = @photo_detail.server
#   @farm = @photo_detail.farm
#   erb :form
# end



get '/detail' do
  @id = '12702679144'
  @photo_detail = flickr.photos.getInfo :photo_id => @id
  @photo_detail.title
  @photo_detail.description
end
