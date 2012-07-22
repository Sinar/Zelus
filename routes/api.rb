# get all people
get "/people" do
  { status: "success",
    payload: Person.all    
  }.to_json
end

# get people by page size and page
get "/people/:page_size/?:page?" do
  people = Person.all.page(:page => params[:page], :per_page => params[:page_size])
  { status: "success",
    page_size: params[:page_size],
    next_page: people.pager.next_page,
    previous_page: people.pager.previous_page,
    payload: people     
  }.to_json
end

# get all MPs
get "/representatives" do
  { status: "success",
    payload: Member.all    
  }.to_json
end

# get a specific person
get "/person/:uuid" do
  person = Person.first(uuid: params[:uuid])
  raise "Person not found" if person.nil?
  { status: "success",
    payload: {
      person: person,
      parties: person.parties, 
      connections: person.connections      
    }
  }.to_json
end

# create either a person or an MP
["/person", "/representative"].each do |route|
  post route do  
    begin      
      person = (route == "/person" ? Person.create : Member.create)
      params.each do |param, value|
        person.send("#{param}=".to_sym, value) unless param == "api_key"
      end
      person.save
      {status: "success", payload: person.uuid}.to_json
    rescue
      raise "Cannot create this person record"
    end
  end
end

# update either a person or an MP
["/person/:uuid", "/representative/:uuid"].each do |route|
  post route do  
    person = Person.first uuid: params[:uuid]
    raise "Person not found" if person.nil?    
    begin
      params.each do |param, value|
        person.send("#{param}=".to_sym, value) unless param == "api_key"
      end
      person.save
    rescue
      raise "Cannot update person record #{person.uuid}"
    end
  end
end

# search people based on name or email
get "/people/search/:query" do
  {status: "success", 
   payload:  Person.all(:name.like => "%#{params[:query]}%") || 
             Person.all(:email.like => "%#{params[:query]}%")
  }.to_json
end

# get all people from a specific party
get "/people/party/:uuid" do
  party = Party.first uuid: params[:uuid]  
  raise "Party not found" if party.nil?
  {status: "success", payload: party.people.all}.to_json  
end

# associate a person with a party
post "/person/:uuid/party/:uuid" do
  person = Person.first uuid: params[:uuid]
  raise "Person not found" if person.nil?  
  party = Party.first uuid: params[:uuid]  
  raise "Party not found" if party.nil?
  
  begin
    party.people << person
    party.save
  rescue
    raise "Cannot associate person with party"
  end    
end


get "/regions" do
  { status: "success",
    payload: Region.all    
  }.to_json
end

get "/parties" do
  { status: "success",
    payload: Party.all    
  }.to_json
end

get "/coalitions" do
  { status: "success",
    payload: Coalition.all    
  }.to_json
end

get "/constituencies" do
  { status: "success",
    payload: Constituency.all    
  }.to_json
end

get "/districts" do
  { status: "success",
    payload: District.all    
  }.to_json
end