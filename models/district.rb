class District
  include DataMapper::Resource

  property :id, Serial
  property :uuid, String, :length => 255
  property :timestamp, DateTime

  property :name, String, :length => 255
  property :code, String, :length => 255
  property :previous, Integer
  
  belongs_to :constituency
  
  def predecessor
    District.first(:uuid => self.previous) if previous
  end

  def predecessor=(pre)
    self.previous = pre.uuid
  end
  
  before :create do
    self.uuid = UUID.create_sha1(Time.now.to_s + rand(A_LARGE_NUMBER).to_s, UUID::NameSpace_OID) unless self.uuid
    self.timestamp = Time.now
  end

end