require 'dm-transactions'

module DataMapperHelper
end

RSpec.configure do |c|
  [:all, :each].each do |s|
    c.before s, :type => :api do
      repository :default do |r|
        t = DataMapper::Transaction.new(repository)
        t.begin
        r.adapter.push_transaction(t)
      end
    end
    c.after s, :type => :api do
      repository(:default).adapter.pop_transaction.rollback
    end
  end
end
