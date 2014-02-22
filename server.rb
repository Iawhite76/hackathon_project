require 'rubygems'
require 'sinatra'
require 'pry'
require 'flickraw'

FlickRaw.api_key = ENV['API_KEY']
FlickRaw.shared_secret = ENV['SECRET']

flickr.access_token = ENV['TOKEN']
flickr.access_secret = ENV['A_SECRET']
enable :sessions

PHOTO_PATH='photo.jpg'

#set :bind, '0.0.0.0' # Vagrant fix

get '/welcome' do
  login = flickr.test.login
puts "You are now authenticated as #{login.username}"
end

get '/post' do
flickr.upload_photo PHOTO_PATH, :title => 'Title', :description => 'This is the description'
end



get '/authenticate' do
  token = flickr.get_request_token(:oauth_callback => to('check'))
  session[:token] = token
  redirect flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')
end

get '/check' do
  token = session.delete :token
  session[:auth_flickr] = @auth_flickr = FlickRaw::Flickr.new
  @auth_flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], params['oauth_verifier'])

  redirect to('/authenticated')
end

get '/authenticated' do
  @auth_flickr = session[:auth_flickr]

  #login = @auth_flickr.test.login
  %{
You are now authenticated as <em>#{login.username}</em>
with token <strong>#{@auth_flickr.access_token}</strong> and secret <strong>#{@auth_flickr.access_secret}</strong>.
}
end
