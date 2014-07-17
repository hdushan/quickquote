require 'sinatra'
require 'haml'
require 'v8'
require 'json'
require 'coffee-script'
require 'carQuote'
require 'lifeQuote'
require 'carPremiumCalculator'
require 'lifePremiumCalculator'
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
    haml :index
  end

  get '/life' do
    sleep 1
    haml :life
  end
  
  get '/car' do
    sleep 1
    haml :car
  end
  
  get '/payment' do
    sleep 1
    haml :payment
  end
  
  post '/pay' do
    sleep 1
    haml :done
  end
  
  post '/quote' do
    #logger.info params
    sleep 1
    @typeOfInsurance = params["typeOfInsurance"]
    if @typeOfInsurance == "life"
      getLifeQuote(params)
    else
      getCarQuote(params)
    end
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
  
  def getLifeQuote(params)
    age = params["age"]
    email = params["email"]
    occupationCategory = params["occupation"]
    gender = params["gender"]
    state = params["state"]
    @quote=LifeQuote.new(age, email, state, occupationCategory, gender)
    calc = LifePremiumCalculator.new
    @premium = calc.getPremiumForQuote(@quote)
  end
  
  def getCarQuote(params)
    age = params["age"]
    email = params["email"]
    make = params["make"]
    year = params["year"]
    gender = params["gender"]
    state = params["state"]
    @quote=CarQuote.new(age, email, state, make, gender, year)
    calc = CarPremiumCalculator.new
    @premium = calc.getPremiumForQuote(@quote)
  end

end