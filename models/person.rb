class Person
  include DataMapper::Resource

  property :id, Serial
  property :uuid, String, :length => 255
  property :timestamp, DateTime
  property :updated_at, DateTime
  property :type, Discriminator

  property :name, String, :length => 255
  
  # contacts
  property :email, String, :length => 255
  property :facebook, String, :length => 255
  property :twitter, String, :length => 255
  property :linkedin, String, :length => 255
  
  property :www, String, :length => 255
  property :phone, String, :length => 255
  property :fax, String, :length => 255

  property :race, String, :length => 255
  property :sex, String, :length => 255
  property :birth_year, Integer
  
  property :education, Text
  property :home_address, Text
  property :office_address, Text

  property :deceased_at, DateTime
  property :biography, Text
  
  has n, :memberships
  has n, :parties, :through => :memberships
  
  
  has n, :links, :child_key => [:source_id]
  has n, :connections, self, :through => :links, :via => :target

  before :create do
    self.uuid = UUID.create_sha1(Time.now.to_s + rand(A_LARGE_NUMBER).to_s, UUID::NameSpace_OID) unless self.uuid
    self.timestamp = Time.now
  end

end

class Link
 include DataMapper::Resource

 property :relation, String, :length => 255

 belongs_to :source, 'Person', :key => true
 belongs_to :target, 'Person', :key => true
end

class Member < Person; end