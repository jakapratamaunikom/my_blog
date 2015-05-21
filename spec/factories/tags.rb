FactoryGirl.define do
  factory :tag do
    title { generate :random_name }
    after(:build) do |tag|
    end

  end


end
