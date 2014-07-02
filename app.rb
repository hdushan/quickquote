require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

post '/quote' do
  haml :quote
end

not_found do
  haml :not_found
end