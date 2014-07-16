require 'sinatra'
require 'haml'
require 'v8'
require 'json'
require 'coffee-script'
require 'quote'
require 'premiumCalculator'
require 'emailValidator'
require 'logger'

class App < Sinatra::Base
  
  #logger = Logger.new(STDERR)
  emailValidator = EmailValidator.new()

  #configure do
  #  Dir.mkdir('log') unless File.exists?('log')
  #  enable :logging
  #  log_file = File.new('log/access.log', 'a+')
  #  log_file.sync = true
  #  use Rack::CommonLogger, log_file
  #end

  get '/' do
    sleep 1
    haml :index
  end
  
  post '/quote' do
    #logger.info params
    sleep 1
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
  
  post '/checkemail' do
    #logger.info params
    sleep 1
    email = params["email"]
    content_type :json
    {:valid => emailValidator.isEmailValid?(email)}.to_json
  end
  
  get '/javascripts/application.js' do
    coffee :application
  end
  
  not_found do
    haml :not_found
  end

end