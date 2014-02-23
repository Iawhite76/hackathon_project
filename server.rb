require 'rubygems'
require 'sinatra'
require 'pry'
require 'flickraw'
require 'json'
require 'digest/md5'

#set :bind, '0.0.0.0' # Vagrant fix

FlickRaw.api_key = ENV['API_KEY']
FlickRaw.shared_secret = ENV['SECRET']

flickr.access_token = ENV['TOKEN']
flickr.access_secret = ENV['A_SECRET']
enable :sessions

get '/form' do
    session[:user] = nil
  @name = params[:name]
  @user_name = params[:user_name]
  @phone = params[:phone]
  @email = params[:email]

  @zip = params[:zip]
  @total = 0
  if @name
  session[:user] = [@user_name, @name, @email, @phone, @zip]
  end
 @saved_email = params[:email]
  @digest = Digest::MD5.hexdigest(@saved_email)
  erb :form
end

post '/form' do

  session[:submitted_items] ||= []


  @item = params[:item]
  @serial_number = params[:serial_number]
  @price = params[:price]
  @pic = params[:pic]
  if @pic
  PHOTO_PATH=params[:pic][:tempfile]
    @id = flickr.upload_photo PHOTO_PATH, :title => @item, :description => 'serial number: ' + @serial_number + 'retail price: ' + @price, :tags => @user_name
    @photo_detail = flickr.photos.getInfo :photo_id => @id
    @pid = @photo_detail.id
    @secret = @photo_detail.secret
    @ps = @photo_detail.server
    @farm = @photo_detail.farm
  end
      if @farm
        session[:submitted_items] << [@item, @pid, @secret, @ps, @farm, @serial_number, @price, @user_name]
      end
  puts @digest

  erb :form
end

get '/_inventory' do
#temporary just to show rendered inventory page

  @user_photos = flickr.photos.search :user_id => '118312704@N05', :tags => @user_name
  puts @user_photos
  @name ||= params[:name]
  @user_name ||= params[:user_name]
  @phone ||= params[:phone]
  @email ||= params[:email]
  @zip ||= params[:zip]
  erb :_inventory
end


