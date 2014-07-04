require 'sinatra'
require 'haml'
require 'v8'
require 'coffee-script'
require 'quote'
require 'premiumCalculator'

get '/' do
  haml :index
end

post '/quote' do
  age = params["age"]
  email = params["email"]
  occupationCategory = params["occupation"]
  gender = params["gender"]
  state = params["state"]
  @quote=Quote.new(age, email, state, occupationCategory, gender)
  calc = PremiumCalculator.new
  @premium = calc.getPremiumForQuote(@quote)
  haml :quote
end

get '/javascripts/application.js' do
  coffee :application
end

not_found do
  haml :not_found
end