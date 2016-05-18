FactoryGirl.define do
  factory :article_content do
    title             { generate :random_title }
    content           { generate :random_content }
    short_description { generate :random_short_description }
    lang :ru

    after(:build) do |article_content|
      article_content.article ||= Article.first
      article_content.article ||= FactoryGirl.create(:article)
    end

  end

end
