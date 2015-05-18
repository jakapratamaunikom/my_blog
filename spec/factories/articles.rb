FactoryGirl.define do
  factory :article do
    after(:build) do |article|
      en_ac = article.article_contents.build(FactoryGirl.build(:article_content, lang: :en, article: article).attributes)
      en_ac.article = article

      ru_ac = article.article_contents.build(FactoryGirl.build(:article_content, lang: :ru, article: article).attributes)
      ru_ac.article = article
    end
  end

end
