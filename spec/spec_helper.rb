require 'factory_girl'
require 'factories'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
end
