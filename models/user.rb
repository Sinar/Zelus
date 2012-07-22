class User
  include DataMapper::Resource

  property :id, Serial
  property :uuid, String, :length => 255
  property :timestamp, DateTime

  property :name, String, :length => 255
  property :api_key, String, :length => 255
  
  before :create do
    self.uuid = UUID.create_sha1(Time.now.to_s + rand(A_LARGE_NUMBER).to_s, UUID::NameSpace_OID) unless self.uuid
    self.timestamp = Time.now
  end

  def generate_api_key
    self.api_key = UUID.create_sha1(self.name + Time.now.to_s + rand(A_LARGE_NUMBER).to_s, UUID::NameSpace_OID)
    self.save
  end


end