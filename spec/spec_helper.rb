require 'factory_girl'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }
require 'factories'

FactoryGirl.duplicate_attribute_assignment_from_initialize_with = false

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
end
