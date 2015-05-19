FactoryGirl.define do
  factory :tag do
    title Forgery('name').company_name
    after(:build) do |tag|
    end

  end


end
