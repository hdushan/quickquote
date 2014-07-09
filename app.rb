require 'sinatra'
require 'haml'
require 'v8'
require 'coffee-script'
require 'quote'
require 'premiumCalculator'
require 'logger'

class App < Sinatra::Base
  
  logger = Logger.new(STDERR)

  configure do
    Dir.mkdir('log') unless File.exists?('log')
    enable :logging
    log_file = File.new('log/access.log', 'a+')
    log_file.sync = true
    use Rack::CommonLogger, log_file
  end

  get '/' do
    haml :index
  end
  
  post '/quote' do
    logger.info params
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

end