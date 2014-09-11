require 'sinatra'
require 'rack-flash'
require 'haml'
require 'v8'
require 'json'
require 'coffee-script'
require 'carQuote'
require 'lifeQuote'
require 'carPremiumCalculator'
require 'lifePremiumCalculator'
require 'emailValidator'
require 'rack-google-analytics'
require 'logger'
require "warden"

require 'data_mapper'
require "dm_noisy_failures"
require 'bcrypt'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/db.sqlite")
DataMapper::Model.raise_on_save_failure = true

require './models/policies'
require './models/users'
DataMapper.finalize
DataMapper.auto_upgrade!

use Rack::GoogleAnalytics, :tracker => 'UA-53462613-1'

configure :production do
  require 'newrelic_rpm'
end

class App < Sinatra::Base
  
  $logger = Logger.new(STDERR)
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
  use Rack::Flash, :sweep => true
  
  use Warden::Manager do |config|
    config.serialize_into_session{|user| user.id }
    config.serialize_from_session{|id| User.get(id) }

    config.scope_defaults :default,
      strategies: [:password],
      action: 'auth/unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end
  
  Warden::Strategies.add(:password) do
    def valid?
      params['user']['username'] && params['user']['password']
    end

    def authenticate!
      user = User.first(username: params['user']['username'])

      if user.nil?
        fail!("The username you entered does not exist.")
      elsif user.authenticate(params['user']['password'])
        success!(user)
      else
        fail!("Could not log in")
      end
    end
  end

  get '/' do
    session["quote"] ||= nil
    haml :index
  end
  
  get '/index' do
    session["quote"] ||= nil
    redirect "/", flash[:success] = "This is a test message"
  end
  
  get '/seed' do
    username = "hans2@hans.com"
    createUser(username, "hans", "Hans", :admin)
    carQuote = getCarQuote({"age" => "23", "email" => username, "make" => "bmw", "year" => "2009", "gender" => "male", "state" => "nsw"})
    createPolicy(:car, username, carQuote)
    redirect '/users'
  end
  
  get "/bad" do
    content_type :json
    { :login_successful => "false" }.to_json
  end
  
  get "/good" do
    content_type :json
    { :login_successful => "true", :name => "Hans"}.to_json
  end

  get '/login' do
    session["quote"] ||= nil
    haml :login
  end

  get '/life' do
    haml :life
  end
  
  get '/car' do
    haml :car
  end
  
  get '/payment' do
    @quote = session["quote"]
    haml :payment
  end

  post '/login' do
    redirect "/", flash[:warning] = "Login functionality not implemented yet"
  end
  
  get '/users' do
    @users = User.all
    haml :users
  end
  
  get '/policies' do
    @policies = Policy.all
    haml :policies
  end
  
  post '/pay' do
    @quote = session["quote"]
    $logger.info @quote.inspect
    $logger.info @quote.type.inspect
    createUser(params["username"], params["password"], params["cardholdername"], :user)
    createPolicy(params["username"], @quote)    
    haml :done
  end
  
  post '/quote' do
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
    #@logger.info params
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
  
  def createPolicy(username, quote)
    user = User.get(username)
    $logger.info "BEFORE: CREATING POLICY: " + Policy.all.count.to_s
    $logger.info quote.inspect
    $logger.info quote.type.to_s
    policy = Policy.new(:user => user, :type=>quote.type, :quote=>quote, :created_at => Time.now, :updated_at => Time.now)
    policy.save
    $logger.info "AFTER: SIZE OF TABLE: " + Policy.all.count.to_s
  end

  def createUser(username, password, name, role)
    if User.get(username).nil?
      $logger.info "BEFORE: CREATING USER"
      User.create(:role=>role, :username=>username, :password=>password, :name => name)
      $logger.info "AFTER: SIZE OF TABLE: " + User.all.count.to_s
    end
  end
  
end