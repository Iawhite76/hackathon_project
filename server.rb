require 'rubygems'
require 'sinatra'
require 'pry'
require 'flickraw'
require 'json'
#set :bind, '0.0.0.0' # Vagrant fix

FlickRaw.api_key = ENV['API_KEY']
FlickRaw.shared_secret = ENV['SECRET']

flickr.access_token = ENV['TOKEN']
flickr.access_secret = ENV['A_SECRET']
enable :sessions

get '/form' do
  # @name ||= params[:name]
  # @user_name ||= params[:user_name]
  # @phone ||= params[:phone]
  # @email ||= params[:email]
  # @zip ||= params[:zip]
  # if @id
  # @photo_detail = flickr.photos.getInfo :photo_id => @id
  # end
  erb :form
end

# post '/form' do

#   @@name ||= params[:name]
#   @@user_name ||= params[:user_name]
#   @@phone ||= params[:phone]
#   @@email ||= params[:email]
#   @@zip ||= params[:zip]
#   @serial_number = params[:serial_number]
#   @item = params[:item]
#   @price = params[:price]
#   @pic = params[:pic]
#   if @pic
#   PHOTO_PATH=params[:pic][:tempfile]
#   @id = flickr.upload_photo PHOTO_PATH, :title => @item, :description => 'serial number: ' + @serial_number + 'retail price: ' + @price, :tags => @user_name
#   end
#   erb :form
# end


post '/form' do
  session[:user] ||=[]
  session[:submitted_items] ||= []

  @name = params[:name]
  @user_name = params[:user_name]
  @phone = params[:phone]
  @email = params[:email]
  @zip = params[:zip]

  if @user
  session[:user] << [@user_name, @name, @email, @phone, @zip]
  end

  @item = params[:item]
  @serial_number = params[:serial_number]
  @price = params[:price]
  @pic = params[:pic]
  if @pic
  PHOTO_PATH=params[:pic][:tempfile]
  @id = flickr.upload_photo PHOTO_PATH, :title => @item, :description => 'serial number: ' + @serial_number + 'retail price: ' + @price, :tags => @user_name
  puts @id
    @photo_detail = flickr.photos.getInfo :photo_id => @id
  @pid = @photo_detail.id
  @secret = @photo_detail.secret
  @ps = @photo_detail.server
  @farm = @photo_detail.farm

  if @id
    session[:submitted_items] << [@item, @pid, @secret, @ps, @farm, @serial_number, @price, @user_name]
  end
  puts session[:submitted_items]
end

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

get '/detail' do
  @user_photos = flickr.photos.search :user_id => '118312704@N05', :tags => 'zalary'

  puts @user_photos.class

  photos = @user_photos.to_a
  puts photos.count
  puts photos = @user_photos.to_a

  # photos.each_with_index { |x, index| index }
  puts photos[0]["id"]
  puts photos[1]["id"]
  photos[0]["id"]
  photos[1]["id"]
#pry.binding
  #y = photos.count
   #y = y.to_i
 # puts ("count" + y)
  # for i in 0..y - 1
  #   puts photos[i]["id"]
  # end

  for i in 0..photos.count - 1
    puts y = photos[i]["id"]
    #puts y.to_s
  end
  # string = photos.to_s
  # split = string.split("},{")
  # #json = JSON.parse(split)
  # puts split
  # puts split[0]
  # # array = [string]
  # # puts array
  # # array.each {|x,y| puts x }
 #binding.pry


end
