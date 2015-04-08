FactoryGirl.define do
  sequence(:random_title) { |n| "Статья № #{n}#{rand(1000000)}" }
  factory :article do
    title { generate :random_title}
    content "MyText"
    image_path "MyString"
  end

end
