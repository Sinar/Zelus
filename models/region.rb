class Region
  include DataMapper::Resource

  property :id, Serial
  property :uuid, String, :length => 255
  property :timestamp, DateTime

  property :name, String, :length => 255
  property :code, String, :length => 255
  
  has n, :constituencies
  has n, :members, :through => :constituencies
  
  before :create do
    self.uuid = UUID.create_sha1(Time.now.to_s + rand(A_LARGE_NUMBER).to_s, UUID::NameSpace_OID) unless self.uuid
    self.timestamp = Time.now
  end

end