require File.dirname(__FILE__) + '/spec_helper'
set :environment, :test
 
describe "QuickQuote Test" do
  include Rack::Test::Methods
 
  def app
    @app ||= Sinatra::Application
  end
 
  # Do a root test
  it "should respond to /" do
    get '/'
    expect(last_response).to be_ok
  end
end