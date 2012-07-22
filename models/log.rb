class Log
  include DataMapper::Resource

  property :id, Serial
  property :timestamp, DateTime
  property :remote_addr, String
  property :client, String, :length => 255
  property :method, String
  property :path, String
  property :http_version, String
  property :return_code, String
  property :return_size, Integer
  property :user_uuid, String, :length => 255
  
  before :create do
    self.timestamp = Time.now
  end

end