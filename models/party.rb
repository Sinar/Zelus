class Party
  include DataMapper::Resource

  property :id, Serial
  property :uuid, String, :length => 255
  property :timestamp, DateTime
  property :code, String

  property :name, String, :length => 255
  property :name_in_malay, String, :length => 255
  
  property :founded_in, Integer
  property :disbanded_in, Integer
  
  has n, :memberships
  has n, :people, :through => :memberships

  has n, :coalitionships
  has n, :coalitions, :through => :coalitionships
  
  before :create do
    self.uuid = UUID.create_sha1(Time.now.to_s + rand(A_LARGE_NUMBER).to_s, UUID::NameSpace_OID) unless self.uuid
    self.timestamp = Time.now
  end

end