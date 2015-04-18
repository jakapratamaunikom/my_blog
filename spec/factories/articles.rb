FactoryGirl.define do
  sequence(:random_title) { |n| "Статья № #{n}#{rand(1000000)}" }
  factory :article do
    title_ru { generate :random_title}
    title_en { generate :random_title}
    content_en "MyText"
    content_ru "МойТекст"
    
    after(:biuld) do |article|
      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        article.image_en = f
        article.image_ru = f
      end
    end
  end

end
