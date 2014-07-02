require 'sinatra'
require 'haml'
require 'v8'
require 'coffee-script'

get '/' do
  haml :index
end

get '/test' do
  erb :test
end

post '/quote' do
  haml :quote
end

get '/javascripts/application.js' do
  coffee :application
end

not_found do
  haml :not_found
end