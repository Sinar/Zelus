require 'spec_helper'

describe '/people', :type => :api do

  before :each do
    @person = create :person
  end

  context 'Getting all people' do
    it "should return created persons" do
      get '/people'
      last_response.body.should have_json_path 'payload'
      last_response.body.should include_json(@person.to_json).at_path('payload')
    end
  end

  context 'Getting a person with their UUID' do
    it "should return the specified person" do
      get "/people/#{@person.id}"
      last_response.body.should have_json_path 'payload'
      last_response.body.should have_json_size(1).at_path('payload')
      last_response.body.should be_json_eql(@person.to_json).at_path('payload/0')
    end
  end

end
