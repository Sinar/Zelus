require "./gem_requires"
require "./models/db"
Dir.new("lib").each { |lib| require "./lib/#{lib}" if File.extname(lib) == '.rb' }

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:root@localhost/zelus')
DataMapper.finalize

module Setup

  def self.init
    
  end
  
  def self.migrate
    self.migrate_people
    self.migrate_parties
    self.migrate_memberships
    self.migrate_coalitions
    self.migrate_coalitionships
    self.migrate_regions
    self.migrate_constituencies
    self.migrate_districts
    nil
  end
  
  
  def self.migrate_people
    members = YAML.load_file('data/members.yml')
    members['members']['records'].each do |rec|
      person = Person.create :uuid => rec[0]
      person.name = rec[1]
      person.email = rec[2]
      person.facebook = rec[3]
      person.twitter = rec[4]
      person.www = rec[5]
      person.phone = rec[6]
      person.fax = rec[7]
      person.save
    end
  end
  
  def self.migrate_parties
    parties = YAML.load_file('data/parties.yml')
    parties['parties']['records'].each do |rec|
      party = Party.create :uuid => rec[5]
      party.code = rec[0]
      party.name = rec[1]
      party.name_in_malay = rec[2]
      party.founded_in = rec[3].to_i unless rec[3].to_s.to_i     
      party.disbanded_in = rec[4].to_i unless rec[4].to_s.to_i     
      party.save      
    end    
  end
  
  def self.migrate_memberships
    memberships = YAML.load_file('data/party_memberships.yml')
    memberships['party_memberships']['records'].each do |rec|
      begin
        member = Person.first :uuid => rec[1]
        party = Party.first :uuid => rec[6]
        if party
          m = Membership.create :person => member, :party => party
          m.joined_at = rec[2].to_i unless rec[2].to_s.to_i
          m.parted_at = rec[3].to_i unless rec[3].to_s.to_i
          m.save
        end
      rescue
        p $!
      end
    end
  end
  
  
  def self.migrate_coalitions
    coalitions = YAML.load_file('data/coalitions.yml')
    coalitions['coalitions']['records'].each do |rec|
      coalition = Coalition.create :uuid => rec[5]
      coalition.code = rec[0]
      coalition.name = rec[1]
      coalition.name_in_malay = rec[2]
      coalition.founded_in = rec[3].to_i unless rec[3].to_s.to_i     
      coalition.disbanded_in = rec[4].to_i unless rec[4].to_s.to_i     
      coalition.save      
    end    
  end

  def self.migrate_coalitionships
    coalitionships = YAML.load_file('data/coalitionships.yml')
    coalitionships['coalitionships']['records'].each do |rec|
      begin
        coalition = Coalition.first :uuid => rec[6]
        party = Party.first :uuid => rec[5]
        c = Coalitionship.create :coalition => coalition, :party => party
        c.joined_at = rec[1].to_i unless rec[1].to_s.to_i
        c.parted_at = rec[2].to_i unless rec[2].to_s.to_i
        c.save
      rescue
        p $!
      end
    end    
  end
  
  def self.migrate_regions
    regions = YAML.load_file('data/regions.yml')
    regions['regions']['records'].each do |rec|
      region = Region.create
      region.code = rec[0]
      region.name = rec[1]
      region.save      
    end    
  end
  
  def self.migrate_constituencies
    constituencies = YAML.load_file('data/constituencies.yml')
    constituencies['constituencies']['records'].each do |rec|
      region = Region.first :code => rec[1]
      person = Person.first :uuid => rec[2]      
      constituency = region.constituencies.create :uuid => rec[0], :member => person
      constituency.code = rec[5]
      constituency.name = rec[3]
      constituency.iteration = rec[4]
      constituency.previous = rec[7]
      constituency.save      
    end   
      
  end
  
  def self.migrate_districts
    
  end
  
end

