require 'rack/test'

module RackHelper

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure do |c|
  c.include RackHelper, :type => :api
end
