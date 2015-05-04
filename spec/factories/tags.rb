FactoryGirl.define do
  factory :tag do
    title "MyString"
    lang  :ru
    after(:build) do |tag|
      tag.article ||= Article.first
      tag.article ||= FactoryGirl.create(:article)
    end

  end


end
