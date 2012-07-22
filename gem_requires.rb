%w(sinatra 
   json 
   rest_client 
   active_support 
   active_support/all
   dm-core 
   dm-migrations 
   dm-serializer 
   dm-aggregates 
   dm-constraints 
   dm-pager 
   dm-validations).each  { |gem| require gem}