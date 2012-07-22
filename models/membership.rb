class Membership
 include DataMapper::Resource

 property :joined_at, Integer
 property :parted_at, Integer 
 property :position, String, :length => 255

 belongs_to :party, :key => true  
 belongs_to :person, :key => true  
end