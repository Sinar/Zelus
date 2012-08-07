require 'spec_helper'

describe '/people', :type => :api do

  let (:user) { FactoryGirl.create :user }

  before :each do
    @person = FactoryGirl.create :person
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

  context 'Creating a person via HTTP params' do
    it "should be persisted and readable after" do
      post "/person?api_key=#{user.api_key}", build(:person, { name: 'Presley Hart' }).attributes.delete_if{ |k| k == :type }
      Person.all(:name.like => '%Presley%Hart%').count.should == 1
    end
  end

  context 'Creating a person via JSON' do
    it "should be persisted and readable after" do
      post "/person?api_key=#{user.api_key}", { person: build(:person, { name: 'Samantha Saint' }).attributes.delete_if{ |k| k == :type }.to_json }
      Person.all(:name.like => '%Samantha%Saint%').count.should == 1
    end
  end

  context 'Updating a person via HTTP params' do
    it "should see the changes being reflected" do
      post "/person/#{@person.uuid}?api_key=#{user.api_key}", { name: 'Presley Allure' }
      Person.all(:name.like => '%Presley%Allure%').count.should == 1
    end
  end

  context 'Updating a person via JSON' do
    it "should see the changes being reflected" do
      post "/person/#{@person.uuid}?api_key=#{user.api_key}", { person: { name: 'Saint Samantha' }.to_json }
      Person.all(:name.like => '%Saint%Samantha%').count.should == 1
    end
  end

end
