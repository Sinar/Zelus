FactoryGirl.define do

  factory :person do
    sequence(:name) { |n| "Nicole Neal (#{n})" }
    factory :person_with_party do
      after_create do |person|
        # TODO
        # party = FactoryGirl.create(:party)
        # FactoryGirl.create(:party_membership, { party: party, member: member, joined_at: 1.year.ago.year })
      end
    end

  end
end
