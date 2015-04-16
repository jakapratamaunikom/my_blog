FactoryGirl.define do
  sequence(:random_title) { |n| "Статья № #{n}#{rand(1000000)}" }
  factory :article do
    title_ru { generate :random_title}
    title_en { generate :random_title}
    content_en "MyText"
    content_ru "МойТекст"
    image_ru   "#{::Rails.root}/spec/files.img.jpeg"
    image_en   "#{::Rails.root}/spec/files.img.jpeg"
  end

end
