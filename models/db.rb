%w(person 
   party
   membership  
   region 
   district 
   constituency 
   coalition 
   coalitionship 
   user
   log).each { |lib| require "./models/#{lib}"}

A_LARGE_NUMBER = 999999

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:root@localhost/zelus')
DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize
