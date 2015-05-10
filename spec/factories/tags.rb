FactoryGirl.define do
  factory :tag do
    title "MyString"
    lang  :ru
    after(:build) do |tag|
    end

  end


end
