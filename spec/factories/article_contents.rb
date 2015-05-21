FactoryGirl.define do
  factory :article_content do
    title   { generate :random_title }
    content { generate :random_content }
    lang :ru

    after(:build) do |article_content|
      article_content.article ||= Article.first
      article_content.article ||= FactoryGirl.create(:article)

      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        article_content.image = f
      end
    end

  end

end
