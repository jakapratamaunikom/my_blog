FactoryGirl.define do
  sequence(:random_title) { |n| "Статья № #{n}#{rand(1000000)}" }
  factory :article do
    title_ru { generate :random_title}
    title_en { generate :random_title}
    content_en "MyText"
    content_ru "МойТекст"
    image_ru   "img"
    image_en   "img"
  end

end
