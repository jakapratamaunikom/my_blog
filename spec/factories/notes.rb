FactoryGirl.define do
  factory :note do
    title { generate :random_title }
    description { generate :random_description }
  end

end
