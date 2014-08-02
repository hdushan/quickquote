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

use Rack::GoogleAnalytics, :tracker => 'UA-53462613-1'

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
  
  use Rack::Session::Cookie, :key => 'rack.session',
                               :path => '/',
                               :secret => 'secret_stuff'

  get '/' do
    session["quote"] ||= nil
    haml :index
  end

  get '/life' do
    sleep 0.5
    haml :life
  end
  
  get '/car' do
    sleep 0.5
    haml :car
  end
  
  get '/payment' do
    sleep 0.5
    haml :payment
  end
  
  post '/pay' do
    sleep 0.5
    @quote = session["quote"]
    haml :done
  end
  
  post '/quote' do
    #logger.info params
    sleep 0.5
    type = params["typeOfInsurance"]
    if type == "life"
      @quote = getLifeQuote(params)
    else
      @quote = getCarQuote(params)
    end
    session["quote"] = @quote
    haml :quote
  end
  
  post '/checkemail' do
    #logger.info params
    sleep 0.5
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
    LifeQuote.new(age, email, state, occupationCategory, gender)
  end
  
  def getCarQuote(params)
    age = params["age"]
    email = params["email"]
    make = params["make"]
    year = params["year"]
    gender = params["gender"]
    state = params["state"]
    CarQuote.new(age, email, state, make, gender, year)
  end

end